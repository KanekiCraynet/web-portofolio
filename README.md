# Portfolio Application

A modern, production-ready personal portfolio website built with Ruby on Rails 8.1.

## Features

- **Public Pages**: Landing page, projects showcase, blog, about, and contact form
- **Admin Dashboard**: Full CRUD for projects, skills, experiences, and blog posts
- **Authentication**: Session-based authentication with role-based authorization (Pundit)
- **SEO Optimized**: Meta tags, sitemap generation, and friendly URLs
- **Modern UI**: Tailwind CSS with ViewComponents architecture
- **API Ready**: RESTful JSON API (v1) for external integrations
- **Production Ready**: Docker, CI/CD, and deployment configurations

## Tech Stack

- **Ruby**: 3.3.10
- **Rails**: 8.1.1
- **Database**: PostgreSQL 16
- **Cache/Queue**: Redis + Solid Queue
- **CSS**: Tailwind CSS
- **JavaScript**: Stimulus, Hotwire/Turbo
- **Testing**: RSpec, FactoryBot, Shoulda Matchers
- **Deployment**: Docker, Kamal

## Getting Started

### Prerequisites

- Ruby 3.3+
- PostgreSQL 15+
- Node.js 20+
- Redis (optional, uses Solid adapters by default)

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/portfolio-app.git
cd portfolio-app

# Install dependencies
bundle install
yarn install

# Setup environment
cp .env.example .env
# Edit .env with your configuration

# Setup database
rails db:create db:migrate db:seed

# Start the development server
bin/dev
```

### Using Docker

```bash
# Build and start all services
docker compose up --build

# Run in background
docker compose up -d

# Stop services
docker compose down
```

## Development

### Running Tests

```bash
# Run all RSpec tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/project_spec.rb

# Run with coverage
COVERAGE=true bundle exec rspec
```

### Code Quality

```bash
# Run RuboCop linter
bundle exec rubocop

# Auto-fix issues
bundle exec rubocop -A

# Security scan
bundle exec brakeman
bundle exec bundler-audit
```

### Generate Sitemap

```bash
rake sitemap:refresh
```

## Project Structure

```
portfolio-app/
├── app/
│   ├── components/       # ViewComponents
│   ├── controllers/      # Admin, API, Public controllers
│   ├── models/           # ActiveRecord models + concerns
│   ├── policies/         # Pundit authorization
│   ├── services/         # Service objects
│   ├── jobs/             # Background jobs
│   └── views/            # ERB templates
├── config/
│   ├── routes.rb         # Application routes
│   └── sitemap.rb        # Sitemap configuration
├── db/
│   ├── migrate/          # Database migrations
│   └── seeds.rb          # Development seeds
├── spec/                 # RSpec tests
│   ├── factories/        # FactoryBot factories
│   ├── models/           # Model specs
│   └── policies/         # Policy specs
└── docker-compose.yml    # Docker development setup
```

## Default Credentials

After running `rails db:seed`:

- **Email**: admin@example.com
- **Password**: password123

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/v1/projects | List published projects |
| GET | /api/v1/projects/:id | Get project details |
| GET | /api/v1/skills | List all skills |
| GET | /api/v1/experiences | List all experiences |
| GET | /api/v1/blog_posts | List published blog posts |
| POST | /api/v1/messages | Submit contact form |

## Deployment

### Using Kamal

```bash
# Setup secrets
kamal secrets push

# Deploy
kamal deploy
```

### Environment Variables

See `.env.example` for all required environment variables.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source under the MIT License.
