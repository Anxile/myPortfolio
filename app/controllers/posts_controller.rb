class PostsController < ApplicationController
    require 'google/apis/drive_v3'
    require 'googleauth'
    require 'dotenv/load'
    scopes = [Google::Apis::DriveV3::AUTH_DRIVE]
    authorizer = Google::Auth.get_application_default(scopes)

    public_permission = Google::Apis::DriveV3::Permission.new(
    type: 'anyone',
    role: 'reader'
  )
    

    @@drive = Google::Apis::DriveV3::DriveService.new
    @@drive.authorization = authorizer
    
    def index
        @posts = Post.all
      
        @posts.each do |post|
          if post.image_url.present?
            begin
              file_metadata = @@drive.get_file(
                post.image_url,
                fields: 'id, name, mime_type, web_view_link, thumbnail_link'
              )
              post.define_singleton_method(:file_metadata) { file_metadata }
            rescue Google::Apis::ClientError => e
              Rails.logger.error "Failed to fetch file metadata for #{post.image_url}: #{e.message}"
            end
          end
        end
      end

    def show
        @post = Post.find_by(params[:id])
        @comments = Comment.where(post_id: @post.id)
    end

    def new
        @post = Post.new
    end
    def create
        file_id = upload_image.id
        @post = Post.create(title: params[:post][:title], content: params[:post][:content], user_id: current_user.id, image_url: file_id)
        # @@drive.create_permission(file_id, @@permission)
        @image=drive.get_file(file_id, fields: 'id, name, mime_type, web_view_link, created_time')
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
