# Environment Variables Setup

Since `.env` files are gitignored, you'll need to create your own `.env` file manually.

## Creating Your .env File

```bash
# In the project root directory
touch .env
```

## Required Environment Variables

Copy and paste the following into your `.env` file, then update with your actual values:

```bash
# Database Configuration
DATABASE_URL=postgresql://localhost/gcwu_development

# Redis Configuration
REDIS_URL=redis://localhost:6379/0
CABLE_REDIS_URL=redis://localhost:6379/1
SIDEKIQ_REDIS_URL=redis://localhost:6379/2

# AWS S3 Configuration
AWS_ACCESS_KEY_ID=your_access_key_here
AWS_SECRET_ACCESS_KEY=your_secret_key_here
AWS_REGION=us-east-1
AWS_BUCKET=your-bucket-name

# Rails Configuration
RAILS_MAX_THREADS=5
WEB_CONCURRENCY=2
RAILS_LOG_LEVEL=info

# For production deployment
SECRET_KEY_BASE=

# Optional: SMTP Configuration (if sending emails)
# SMTP_ADDRESS=smtp.gmail.com
# SMTP_PORT=587
# SMTP_USERNAME=your_email@gmail.com
# SMTP_PASSWORD=your_app_password
# SMTP_DOMAIN=gmail.com

# Optional: Host configuration for production
# RAILS_HOSTNAME=example.com
```

## Development vs Production

### Development
- Can use default Redis URLs (localhost)
- Database can be local PostgreSQL
- AWS credentials can be dummy values (if not testing uploads)

### Production
- ALL environment variables must be properly set
- Use secure, production Redis instance
- Use production database credentials
- AWS credentials must be valid for S3 uploads

## Generating SECRET_KEY_BASE

For production, generate a secure secret key base:

```bash
bin/rails secret
```

Copy the output and set it as your `SECRET_KEY_BASE` environment variable.

## Security Notes

- **NEVER** commit your `.env` file to version control
- **NEVER** share your AWS credentials
- **NEVER** expose your SECRET_KEY_BASE
- Use different credentials for development and production
- Rotate credentials regularly
- Use Rails credentials for highly sensitive data:
  ```bash
  bin/rails credentials:edit
  bin/rails credentials:edit --environment production
  ```

## Testing Environment Variables

You can test if your environment variables are loaded correctly:

```bash
bin/rails runner 'puts ENV["REDIS_URL"]'
```

Should output your Redis URL if properly configured.

