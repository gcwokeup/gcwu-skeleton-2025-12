# Rails 8 Skeleton App

A production-ready Rails 8 skeleton/template repository with modern tools and best practices.

## Tech Stack

- **Rails**: 8.1.1
- **Ruby**: 3.3+ (check `.ruby-version` if present)
- **Database**: PostgreSQL
- **Frontend**: 
  - Hotwire (Turbo + Stimulus)
  - Bootstrap 5 with Bootstrap Icons
  - importmap-rails for JavaScript (no Node.js required)
  - dartsass-rails for CSS compilation (no Node.js required)
- **Background Jobs**: Sidekiq with Redis
- **Caching**: Redis
- **ActionCable**: Redis adapter
- **File Storage**: AWS S3 (production), local disk (development)
- **Asset Pipeline**: Propshaft

## Prerequisites

Before you begin, ensure you have the following installed:

- Ruby 3.3 or higher
- PostgreSQL
- Redis
- Bundler (`gem install bundler`)

**Note:** No Node.js required! This skeleton uses importmap-rails and dartsass-rails.

## Initial Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd gcwu-skeleton-2025-12
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Set up environment variables**
   
   Create a `.env` file (you can't create this via certain tools due to gitignore, so do it manually):
   ```bash
   touch .env
   ```
   
   Add the following environment variables to your `.env` file:
   ```bash
   # Database
   DATABASE_URL=postgresql://localhost/gcwu_development
   
   # Redis
   REDIS_URL=redis://localhost:6379/0
   CABLE_REDIS_URL=redis://localhost:6379/1
   SIDEKIQ_REDIS_URL=redis://localhost:6379/2
   
   # AWS S3 (for production)
   AWS_ACCESS_KEY_ID=your_access_key
   AWS_SECRET_ACCESS_KEY=your_secret_key
   AWS_REGION=us-east-1
   AWS_BUCKET=your-bucket-name
   
   # Rails
   RAILS_MAX_THREADS=5
   WEB_CONCURRENCY=2
   ```

4. **Start required services**
   
   Make sure PostgreSQL and Redis are running:
   ```bash
   # macOS with Homebrew
   brew services start postgresql
   brew services start redis
   
   # Or check if they're already running
   redis-cli ping  # Should return "PONG"
   psql -l         # Should list databases
   ```

5. **Set up the database**
   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed  # Optional: if you have seed data
   ```

6. **Build CSS assets**
   ```bash
   bin/rails dartsass:build
   ```

## Running the Application

### Development Mode

To start all development services (Rails server, CSS watcher, and Sidekiq):

```bash
bin/dev
```

This will start:
- Web server on `http://localhost:3000`
- Dart Sass watcher (auto-compiles SCSS changes)
- Sidekiq worker process

### Individual Services

You can also run services individually:

```bash
# Rails server
bin/rails server

# CSS watcher
bin/rails dartsass:watch

# Sidekiq
bundle exec sidekiq

# Rails console
bin/rails console

# Pry console (better than IRB)
bin/rails console  # pry-rails is automatically used
```

## Testing

Run the test suite:

```bash
bin/rails test

# Or for system tests
bin/rails test:system

# Code coverage (with SimpleCov)
COVERAGE=true bin/rails test
```

## Development Tools

### Included Gems

**Development:**
- `annotate` - Auto-generate schema documentation in models
- `better_errors` - Enhanced error pages with REPL
- `bullet` - N+1 query detection
- `letter_opener` - Preview emails in browser
- `pry-rails` - Better console than IRB
- `dotenv-rails` - Environment variable management

**Testing:**
- `factory_bot_rails` - Test data factories
- `faker` - Generate fake data
- `shoulda-matchers` - One-liner testing matchers
- `simplecov` - Code coverage reports

**Code Quality:**
- `rubocop-rails-omakase` - Ruby style guide enforcement
- `brakeman` - Security vulnerability scanning
- `bundler-audit` - Dependency security auditing

**Production:**
- `pagy` - Fast, lightweight pagination

### Useful Commands

```bash
# Run RuboCop (linting)
bin/rubocop

# Run Brakeman (security scan)
bin/brakeman

# Run Bundler Audit (check for vulnerable gems)
bin/bundler-audit

# Annotate models with schema info
bin/rails annotate_models

# Generate new controller
bin/rails generate controller ControllerName action1 action2

# Generate new model
bin/rails generate model ModelName field1:type field2:type

# Generate migration
bin/rails generate migration MigrationName

# Check N+1 queries (Bullet)
# Just browse your app - Bullet will alert you in the browser and logs
```

## Background Jobs

This app uses Sidekiq for background job processing. Jobs are stored in Redis.

### Creating a Job

```bash
bin/rails generate job ExampleJob
```

### Enqueuing a Job

```ruby
ExampleJob.perform_later(arg1, arg2)

# Or with delay
ExampleJob.set(wait: 1.hour).perform_later(arg1, arg2)
```

### Monitoring Sidekiq

Sidekiq comes with a web UI. To enable it, add to `config/routes.rb`:

```ruby
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
```

Then visit `http://localhost:3000/sidekiq` in development.

**Note:** In production, add authentication to protect this endpoint!

## Caching

The app uses Redis for caching in all environments.

```ruby
# Cache operations
Rails.cache.fetch("key", expires_in: 12.hours) do
  # Expensive operation
end

Rails.cache.write("key", value, expires_in: 1.hour)
Rails.cache.read("key")
Rails.cache.delete("key")
Rails.cache.clear  # Clear all cache
```

## ActionCable / WebSockets

ActionCable uses Redis for pub/sub in development and production.

```bash
# Generate a new channel
bin/rails generate channel NotificationChannel
```

## File Uploads (Active Storage)

- **Development/Test**: Files stored locally in `storage/` directory
- **Production**: Files stored on AWS S3

### Setup S3 for Production

1. Create an S3 bucket in AWS
2. Create an IAM user with S3 access
3. Add credentials to your `.env` file or Rails credentials
4. Files will automatically upload to S3 in production

### Basic Usage

```ruby
# In model
class User < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :documents
end

# In controller
def create
  @user = User.create(user_params)
  @user.avatar.attach(params[:avatar])
end

# In view
<%= image_tag user.avatar if user.avatar.attached? %>
```

## Bootstrap & Styling

This app uses Bootstrap 5 with SCSS compilation via dartsass-rails (no Node.js required).

- Main stylesheet: `app/assets/stylesheets/application.bootstrap.scss`
- Bootstrap is imported via the `bootstrap` gem
- Custom styles can be added to `application.bootstrap.scss`
- Bootstrap Icons available via `bootstrap-icons-helper` gem

### Adding Custom Styles

Edit `app/assets/stylesheets/application.bootstrap.scss`:

```scss
@import 'bootstrap/scss/bootstrap';
@import 'bootstrap-icons/font/bootstrap-icons';

// Your custom styles
.my-custom-class {
  color: $primary;
}
```

## JavaScript & Stimulus

JavaScript is managed via importmap-rails. Stimulus controllers are in `app/javascript/controllers/`.

### Adding a New Stimulus Controller

1. Create file: `app/javascript/controllers/my_controller.js`
2. It's automatically loaded via `controllers/index.js`

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Controller connected!")
  }
}
```

### Using in Views

```erb
<div data-controller="my">
  <!-- Your content -->
</div>
```

## Deployment

This app is configured for deployment with Kamal (Docker-based deployment).

### Production Checklist

1. Set environment variables on your production server
2. Ensure Redis is running
3. Ensure PostgreSQL is running
4. Set up AWS S3 bucket and credentials
5. Generate production credentials: `bin/rails credentials:edit --environment production`
6. Configure `config/deploy.yml` for Kamal
7. Deploy: `bin/kamal deploy`

## IDE Configuration

### RubyMine

This skeleton is optimized for RubyMine:
- `.idea/` directory is gitignored
- RubyMine should auto-detect Rails configuration

### Cursor

This project works great with Cursor AI:
- All standard Rails conventions are followed
- Well-documented code structure

## Project Structure

```
app/
├── assets/
│   ├── builds/          # Compiled CSS (gitignored except .keep)
│   └── stylesheets/     # Source SCSS files
├── controllers/
├── helpers/
├── javascript/
│   └── controllers/     # Stimulus controllers
├── jobs/                # Sidekiq jobs
├── mailers/
├── models/
└── views/

config/
├── environments/        # Environment-specific configs
├── initializers/
│   └── sidekiq.rb      # Sidekiq configuration
├── cable.yml           # ActionCable (Redis)
├── database.yml        # PostgreSQL
└── storage.yml         # AWS S3 configuration
```

## Common Issues & Solutions

### Redis Connection Error

```bash
# Make sure Redis is running
redis-cli ping

# Start Redis
brew services start redis  # macOS
sudo systemctl start redis # Linux
```

### PostgreSQL Connection Error

```bash
# Make sure PostgreSQL is running
brew services start postgresql  # macOS
sudo systemctl start postgresql # Linux
```

### CSS Not Compiling

```bash
# Rebuild CSS
bin/rails dartsass:build

# Or watch for changes
bin/rails dartsass:watch
```

### Gems Not Installing

```bash
# Update bundler
gem update bundler

# Clean install
rm Gemfile.lock
bundle install
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests: `bin/rails test`
4. Run linters: `bin/rubocop`
5. Commit your changes
6. Push and create a Pull Request

## License

[Your License Here]

## Support

For issues and questions, please open an issue in the repository.

---

**Happy Coding! 🚀**
