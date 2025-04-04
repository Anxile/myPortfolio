module PostsHelper
    begin
        scopes = [Google::Apis::DriveV3::AUTH_DRIVE]
        authorizer = Google::Auth.get_application_default(scopes)
    
        @@drive = Google::Apis::DriveV3::DriveService.new
        @@drive.authorization = authorizer
      rescue StandardError => e
        Rails.logger.error "Google Drive API initialization failed: #{e.message}"
        @@drive = nil
    end
    def generate_drive_link(file_id)
        file_metadata = @@drive.get_file(
            file_id,
              fields: 'id, name, mime_type, web_view_link, thumbnail_link'
            )
        file_metadata.web_view_link
    end
end
