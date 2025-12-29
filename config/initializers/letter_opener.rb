# Letter Opener configuration
# Opens emails in the browser instead of sending them in development

if Rails.env.development?
  Rails.application.configure do
    # Use letter_opener for email delivery in development
    config.action_mailer.delivery_method = :letter_opener
    config.action_mailer.perform_deliveries = true
  end
end
