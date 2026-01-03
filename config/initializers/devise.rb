# frozen_string_literal: true

# Assuming you have not yet modified this file, this will create a basic User model
# with authentication and OmniAuth support

Devise.setup do |config|
  # The secret key used by Devise. Generate with: bin/rails secret
  config.secret_key = ENV['DEVISE_SECRET_KEY'] || Rails.application.credentials.secret_key_base

  # ==> Mailer Configuration
  config.mailer_sender = ENV.fetch('MAILER_FROM', 'please-change-me@example.com')

  # Configure the class responsible to send e-mails.
  config.mailer = 'Devise::Mailer'

  # ==> ORM configuration
  require 'devise/orm/active_record'

  # ==> Configuration for any authentication mechanism
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  # Configure which keys are used when authenticating a user
  config.authentication_keys = [:email]

  # ==> Configuration for :database_authenticatable
  config.stretches = Rails.env.test? ? 1 : 12

  # Send a notification email when the user's password is changed.
  config.send_password_change_notification = true

  # ==> Configuration for :confirmable
  # config.reconfirmable = true
  # config.confirm_within = 3.days

  # ==> Configuration for :rememberable
  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true

  # ==> Configuration for :validatable
  config.password_length = 8..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :timeoutable
  config.timeout_in = 30.minutes

  # ==> Configuration for :lockable
  config.lock_strategy = :failed_attempts
  config.unlock_keys = [:email]
  config.unlock_strategy = :both
  config.maximum_attempts = 5
  config.unlock_in = 1.hour
  config.last_attempt_warning = true

  # ==> Configuration for :recoverable
  config.reset_password_within = 6.hours

  # ==> Configuration for OmniAuth
  config.omniauth :google_oauth2,
                  ENV['GOOGLE_CLIENT_ID'],
                  ENV['GOOGLE_CLIENT_SECRET'],
                  {
                    scope: 'email,profile',
                    prompt: 'select_account',
                    image_aspect_ratio: 'square',
                    image_size: 256
                  }

  # ==> Warden configuration
  config.warden do |manager|
    manager.failure_app = Devise::FailureApp
  end

  # ==> Hotwire/Turbo configuration
  config.navigational_formats = ['*/*', :html, :turbo_stream]
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  # ==> Configuration for :trackable
  # config.sign_in_after_reset_password = true
end
