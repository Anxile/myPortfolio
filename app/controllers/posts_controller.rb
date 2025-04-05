class PostsController < ApplicationController
  require 'google/apis/drive_v3'
  require 'googleauth'

  skip_before_action :ensure_user_logged_in

  begin
    scopes = [Google::Apis::DriveV3::AUTH_DRIVE]
    authorizer = Google::Auth.get_application_default(scopes)
    Rails.logger.info "Authorizer: #{authorizer.inspect}"
  
    @@drive = Google::Apis::DriveV3::DriveService.new
    @@drive.authorization = authorizer
    Rails.logger.info "Drive Service Initialized: #{@@drive.inspect}"
  rescue StandardError => e
    Rails.logger.error "Google Drive API initialization failed: #{e.message}"
    @@drive = nil
  end

  def index
    @post = Post.new
    @posts = Post.all
  
    if @@drive
      @posts.each do |post|
        if post.image_url.present?
          begin
            Rails.logger.info "Fetching metadata for Post ID: #{post.id}, Image URL: #{post.image_url}"
            file_metadata = @@drive.get_file(
              post.image_url,
              fields: 'id, name, mime_type, web_view_link, thumbnail_link'
            )
            post.instance_variable_set(:@file_metadata, file_metadata)
            Rails.logger.info "File Metadata: #{file_metadata.inspect}"
          rescue Google::Apis::ClientError => e
            Rails.logger.error "Failed to fetch file metadata for #{post.image_url}: #{e.message}"
          end
        end
      end
    else
      Rails.logger.warn "Google Drive API is not initialized. Skipping file metadata retrieval."
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = Comment.where(post_id: @post.id)

    if @@drive && @post.image_url.present?
      begin
        file_metadata = @@drive.get_file(
          @post.image_url,
          fields: 'id, name, mime_type, web_view_link, thumbnail_link'
        )
        @post.define_singleton_method(:file_metadata) { file_metadata }
      rescue Google::Apis::ClientError => e
        Rails.logger.error "Failed to fetch file metadata for #{@post.image_url}: #{e.message}"
      end
    end
    
  end

  def new
    @post = Post.new
  end

  def create
    file_id = upload_image&.id
    @post = Post.new(
      title: params[:post][:title],
      content: params[:post][:content],
      user_id: current_user.id,
      image_url: file_id
    )
  
    if @post.save
      redirect_to posts_path, notice: "Post created successfully!"
    else
      flash.now[:alert] = "Failed to create post."
      render :index
    end
  end

  def upload_image
    file = params[:post][:image]
    if file.present?
      metadata = Google::Apis::DriveV3::File.new(name: file.original_filename)
  
      uploaded_file = @@drive.create_file(
        metadata,
        fields: 'id',
        upload_source: file.tempfile.path,
        content_type: file.content_type
      )
  
      permission = Google::Apis::DriveV3::Permission.new(
        type: 'anyone',
        role: 'reader'
      )
      @@drive.create_permission(uploaded_file.id, permission)
  
      uploaded_file
    else
      Rails.logger.error "No file provided for upload"
      nil
    end
  end

  def list_files
    response = @@drive.list_files(
      page_size: 100,
      fields: "files(id, name, mime_type, web_view_link, created_time)"
    )
    
    response.files.each do |file|
      puts "ID: #{file.id}"
      puts "Name: #{file.name}"
      puts "URL: https://drive.google.com/file/d/#{file.id}/view"
      puts "Created: #{file.created_time}"
      puts "---"
    end
  end
end
