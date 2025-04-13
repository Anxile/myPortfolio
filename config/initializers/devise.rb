Devise.setup do |config|
    config.jwt do |jwt|
      jwt.secret = ENV['DEVISE_JWT_SECRET_KEY']
      jwt.dispatch_requests = [
        ['POST', %r{^/api/v1/login$}]
      ]
      jwt.revocation_requests = [
        ['DELETE', %r{^/api/v1/logout$}]
      ]
      jwt.expiration_time = 2.hours.to_i
    end
  end