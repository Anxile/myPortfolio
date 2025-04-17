class ApplicationMailer < ActionMailer::Base
  require 'aws-sdk-s3'
  default from: Rails.application.credentials.dig(:gmail, :user_name)
  layout "mailer"
  
end
