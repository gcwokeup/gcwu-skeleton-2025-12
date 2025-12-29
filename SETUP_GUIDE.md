# Rails 8 Skeleton Setup Guide

This guide walks you through setting up your new Rails 8 skeleton repository from scratch.

## What's Included

This skeleton includes a modern Rails 8 setup with:

### Core Stack
- ✅ Rails 8.1.1
- ✅ PostgreSQL database
- ✅ Hotwire (Turbo + Stimulus)
- ✅ Bootstrap 5 + Bootstrap Icons
- ✅ importmap-rails for JavaScript (no Node.js required!)
- ✅ dartsass-rails for CSS (no Node.js required!)
- ✅ Propshaft asset pipeline

### Background Processing & Caching
- ✅ Redis for caching
- ✅ Redis for ActionCable
- ✅ Sidekiq for background jobs
- ✅ Configured for optimal performance

### File Storage
- ✅ AWS S3 support (production)
- ✅ Local storage (development/test)

### Development Tools
- ✅ Better Errors - Enhanced error pages
- ✅ Bullet - N+1 query detection
- ✅ Letter Opener - Email preview in browser
- ✅ Pry Rails - Better console
- ✅ Annotate - Auto-document models
- ✅ Faker - Generate test data
- ✅ Factory Bot - Test factories

### Code Quality Tools
- ✅ RuboCop (Rails Omakase style)
- ✅ Brakeman - Security scanning
- ✅ Bundler Audit - Dependency security

### Testing
- ✅ Minitest (default Rails testing)
- ✅ Capybara for system tests
- ✅ Shoulda Matchers
- ✅ SimpleCov for code coverage

## Quick Start (First Time Setup)

### 1. Install Dependencies

```bash
# Install Ruby gems
bundle install

# No Node.js installation needed!
```

### 2. Set Up Environment Variables

Create your `.env` file:

```bash
touch .env
```

See `ENV_SETUP.md` for the complete list of environment variables you need to add.

**Minimum required for local development:**

```bash
DATABASE_URL=postgresql://localhost/gcwu_development
REDIS_URL=redis://localhost:6379/0
CABLE_REDIS_URL=redis://localhost:6379/1
SIDEKIQ_REDIS_URL=redis://localhost:6379/2
```

### 3. Start Required Services

Ensure PostgreSQL and Redis are running:

```bash
# macOS with Homebrew
brew services start postgresql
brew services start redis

# Check they're running
redis-cli ping  # Should return "PONG"
psql -l         # Should list databases
```

### 4. Set Up Database

```bash
bin/rails db:create
bin/rails db:migrate
```

### 5. Build CSS Assets

```bash
bin/rails dartsass:build
```

### 6. Start the Application

```bash
bin/dev
```

Visit `http://localhost:3000` in your browser.

## What Changed from Default Rails?

### Gemfile Changes

**Removed:**
- `solid_cache` → Replaced with Redis
- `solid_queue` → Replaced with Sidekiq
- `solid_cable` → Replaced with Redis adapter
- `cssbundling-rails` → Replaced with dartsass-rails (no Node.js!)

**Added:**
- `redis` + `hiredis-client` - Redis client libraries
- `sidekiq` - Background job processing
- `aws-sdk-s3` - AWS S3 file uploads
- `connection_pool` - Redis connection pooling
- `dartsass-rails` - Sass compilation without Node.js
- `bootstrap` - Bootstrap 5 gem
- `bootstrap-icons-helper` - Bootstrap Icons gem
- Development tools (see list above)
- Testing gems (see list above)
- `pagy` - Fast pagination

### Configuration Changes

**config/cable.yml**
- Now uses Redis instead of Solid Cable
- Configured for development and production

**config/cache.yml**
- Updated to note Redis is used (actual config is in environment files)

**config/queue.yml**
- Updated to note Sidekiq is used

**config/environments/development.rb**
- Cache store changed to Redis
- Letter Opener configured for email preview

**config/environments/production.rb**
- Cache store changed to Redis
- Active Job adapter changed to Sidekiq
- Active Storage changed to S3

**config/storage.yml**
- Uncommented and configured AWS S3 with environment variables

**config/application.rb**
- Set Sidekiq as default queue adapter

### Files Removed

**db/cable_schema.rb, db/cache_schema.rb, db/queue_schema.rb**
- Removed Solid* gem schema files (not needed with Redis/Sidekiq)

**config/database.yml (production section)**
- Removed separate cache/queue/cable database configurations
- Single PostgreSQL database + Redis for everything

### New Files Created

**config/initializers/sidekiq.rb**
- Sidekiq configuration for client and server

**config/initializers/bullet.rb**
- Bullet gem configuration for N+1 detection

**config/initializers/better_errors.rb**
- Better Errors configuration

**config/initializers/letter_opener.rb**
- Letter Opener configuration for email preview

**Procfile.dev**
- Added Sidekiq worker to run alongside Rails server and Dart Sass watcher

**.gitignore**
- Added `*.dump`, `*.sql`, `.DS_Store`
- Removed `/node_modules` (not needed without Node.js)

**ENV_SETUP.md**
- Complete guide for environment variables

**README.md**
- Comprehensive documentation

**SETUP_GUIDE.md** (this file)
- Step-by-step setup instructions

## Next Steps After Setup

### 1. Install the Gems

After all configuration changes, run:

```bash
bundle install
```

This will install Redis, Sidekiq, AWS SDK, and all development gems.

### 2. Verify Everything Works

```bash
# Start all services
bin/dev

# In another terminal, check Sidekiq is running
redis-cli ping

# Check database connection
bin/rails db:migrate:status

# Open Rails console
bin/rails console
```

### 3. Configure for Your Project

1. **Update Application Name:**
   - Search and replace `GcwuSkeleton202512` with your app name
   - Update `config/application.rb`
   - Update `config/database.yml`

2. **Set Up AWS S3 (if deploying to production):**
   - Create S3 bucket
   - Create IAM user with S3 permissions
   - Add credentials to environment variables

3. **Configure Email Settings (if sending emails):**
   - Add SMTP settings to environment variables
   - Update `config/environments/production.rb` with SMTP config

4. **Set Up Sidekiq Web UI (optional):**
   
   Add to `config/routes.rb`:
   ```ruby
   require 'sidekiq/web'
   mount Sidekiq::Web => '/sidekiq'
   ```
   
   **Important:** Add authentication before deploying to production!

### 4. Start Building

You're ready to start building your application! Some suggestions:

```bash
# Generate a scaffold
bin/rails generate scaffold Post title:string content:text

# Generate a model
bin/rails generate model User email:string name:string

# Generate a controller
bin/rails generate controller Pages home about contact

# Generate a background job
bin/rails generate job SendWelcomeEmail

# Run migrations
bin/rails db:migrate
```

## Common Commands Reference

```bash
# Development
bin/dev                          # Start all services
bin/rails server                 # Start Rails server only
bin/rails console                # Open Rails console
bin/rails dartsass:watch         # Watch CSS changes

# Database
bin/rails db:create              # Create database
bin/rails db:migrate             # Run migrations
bin/rails db:seed                # Seed database
bin/rails db:reset               # Drop, create, migrate, seed

# Background Jobs
bundle exec sidekiq              # Start Sidekiq worker
bin/rails jobs:work              # Process jobs (alternative)

# Testing
bin/rails test                   # Run all tests
bin/rails test:system            # Run system tests
COVERAGE=true bin/rails test     # Run with coverage

# Code Quality
bin/rubocop                      # Run linter
bin/rubocop -a                   # Auto-correct issues
bin/brakeman                     # Security scan
bin/bundler-audit                # Check gem vulnerabilities

# Generators
bin/rails generate scaffold      # Generate complete resource
bin/rails generate model         # Generate model
bin/rails generate controller    # Generate controller
bin/rails generate migration     # Generate migration
bin/rails generate job           # Generate Sidekiq job

# Documentation
bin/rails annotate_models        # Add schema info to models
```

## Troubleshooting

### Redis Not Running

```bash
# macOS
brew services start redis

# Linux
sudo systemctl start redis

# Check status
redis-cli ping  # Should return "PONG"
```

### PostgreSQL Not Running

```bash
# macOS
brew services start postgresql

# Linux
sudo systemctl start postgresql

# Check status
psql -l
```

### CSS Not Compiling

```bash
# Rebuild CSS
bin/rails dartsass:build

# Check for errors
bin/rails dartsass:watch
```

### Can't Connect to Database

Check your `DATABASE_URL` in `.env` file matches your PostgreSQL setup.

### Sidekiq Not Processing Jobs

1. Make sure Redis is running
2. Make sure Sidekiq is running (`bin/dev` starts it automatically)
3. Check `config/initializers/sidekiq.rb` configuration

## Production Deployment

Before deploying to production:

1. ✅ Set all environment variables on production server
2. ✅ Ensure Redis is running (use managed Redis like AWS ElastiCache)
3. ✅ Ensure PostgreSQL is running (use managed DB like AWS RDS)
4. ✅ Create and configure S3 bucket
5. ✅ Generate SECRET_KEY_BASE: `bin/rails secret`
6. ✅ Precompile assets: `bin/rails assets:precompile`
7. ✅ Configure SSL/HTTPS
8. ✅ Set up monitoring (e.g., New Relic, Datadog)
9. ✅ Configure error tracking (e.g., Sentry, Rollbar)
10. ✅ Set up backups for database

## Getting Help

- 📖 **Rails Guides:** https://guides.rubyonrails.org/
- 📖 **Sidekiq Docs:** https://github.com/sidekiq/sidekiq/wiki
- 📖 **Bootstrap Docs:** https://getbootstrap.com/docs/5.3/
- 📖 **Hotwire Docs:** https://hotwired.dev/

## Additional Resources

Check these files for more information:
- `README.md` - Complete project documentation
- `ENV_SETUP.md` - Environment variables guide
- `Gemfile` - All installed gems with comments
- `config/` - All configuration files

---

**You're all set! Happy coding! 🎉**

