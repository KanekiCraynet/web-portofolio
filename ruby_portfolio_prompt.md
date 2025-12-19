# 🎯 PROMPT ENGINEERING: Personal Portfolio Website dengan Ruby on Rails
## Struktur Lengkap & Production-Ready

---

## 📋 DAFTAR ISI
1. [Overview & Tech Stack](#overview--tech-stack)
2. [Arsitektur Proyek](#arsitektur-proyek)
3. [Kebutuhan Fungsional](#kebutuhan-fungsional)
4. [Panduan Implementasi](#panduan-implementasi)
5. [Testing & Quality Assurance](#testing--quality-assurance)
6. [Deployment Strategy](#deployment-strategy)
7. [Maintenance & Scaling](#maintenance--scaling)

---

## 🏗️ OVERVIEW & TECH STACK

### Tech Stack Rekomendasi
```
Frontend:
  - Rails 8.0+ (dengan importmap atau esbuild)
  - Tailwind CSS 4
  - HTMX/Stimulus JS untuk interaksi
  - Alpine.js untuk component dinamis

Backend:
  - Ruby 3.3+
  - PostgreSQL (database)
  - Redis (caching & jobs)
  - ActiveJob (background processing)
  - ActionMailer (email notifications)

DevOps & Hosting:
  - Docker & Docker Compose (development)
  - GitHub Actions (CI/CD)
  - Kamal (deployment orchestration)
  - Render / Railway / DigitalOcean App Platform / VPS
  - CloudFlare (DNS & CDN)

Gems Essensial:
  - pundit (authorization)
  - pagy (pagination)
  - kaminari (alternative pagination)
  - image_processing (image optimization)
  - sidekiq (background jobs)
  - bulletproof (N+1 query detection)
  - rubocop (code style)
  - rspec (testing)
  - factory_bot (fixtures)
```

### Pertimbangan Arsitektur
- **Modular Monolith**: Single codebase dengan module-module terpisah
- **Low Coupling, High Cohesion**: Setiap feature independence
- **Service Objects**: Business logic di layer terpisah
- **RESTful API**: Siap untuk mobile/extension di masa depan

---

## 📁 ARSITEKTUR PROYEK

### Struktur Direktori Production-Ready
```
portfolio-app/
├── app/
│   ├── components/          # ViewComponents untuk reusable UI
│   │   ├── card_component.html.erb
│   │   ├── navbar_component.html.erb
│   │   └── project_card_component.html.erb
│   ├── controllers/         # REST controllers (thin, dengan logic di service)
│   │   ├── admin/
│   │   ├── api/
│   │   └── public/
│   ├── models/              # ActiveRecord models + concerns
│   │   ├── concerns/
│   │   │   ├── timestampable.rb
│   │   │   ├── slugifiable.rb
│   │   │   └── publishable.rb
│   │   ├── user.rb
│   │   ├── project.rb
│   │   ├── skill.rb
│   │   ├── experience.rb
│   │   └── blog_post.rb
│   ├── views/              # Rails view templates (ERB/Hotwire)
│   │   ├── admin/
│   │   ├── public/
│   │   └── layouts/
│   ├── jobs/               # Sidekiq background jobs
│   │   ├── image_processing_job.rb
│   │   ├── send_email_job.rb
│   │   └── cache_warming_job.rb
│   ├── services/           # Service objects (business logic)
│   │   ├── projects/
│   │   │   ├── create_service.rb
│   │   │   ├── update_service.rb
│   │   │   └── delete_service.rb
│   │   ├── skills/
│   │   ├── experiences/
│   │   └── notifications/
│   ├── policies/           # Pundit authorization policies
│   │   ├── application_policy.rb
│   │   ├── project_policy.rb
│   │   └── user_policy.rb
│   ├── decorators/         # Presenter objects (view logic)
│   │   ├── project_decorator.rb
│   │   └── experience_decorator.rb
│   ├── mailers/            # ActionMailer
│   │   └── notification_mailer.rb
│   └── helpers/            # View helpers (utilities)
│
├── config/
│   ├── database.yml        # Database configuration
│   ├── secrets.yml         # Environment secrets (git-ignored)
│   ├── routes.rb           # API & web routes
│   ├── environments/
│   │   ├── production.rb   # Production config
│   │   ├── staging.rb
│   │   └── development.rb
│   └── initializers/
│       ├── carrierwave.rb  # File upload config
│       ├── sidekiq.rb      # Job processing config
│       ├── redis.rb        # Caching config
│       └── cors.rb         # CORS configuration
│
├── db/
│   ├── migrate/            # Database migrations
│   ├── seeds.rb            # Development seeds
│   └── schema.rb           # Generated schema
│
├── lib/
│   ├── tasks/              # Rake tasks
│   │   ├── portfolio.rake
│   │   └── maintenance.rake
│   └── modules/            # Reusable service modules
│
├── spec/                   # RSpec tests
│   ├── models/
│   ├── controllers/
│   ├── services/
│   ├── jobs/
│   ├── requests/
│   └── support/
│
├── public/                 # Static assets (fallback)
├── storage/                # Active Storage files (production)
├── tmp/                    # Temporary files
│
├── docker/                 # Docker configurations
│   ├── Dockerfile          # Production Dockerfile
│   ├── Dockerfile.dev      # Development Dockerfile
│   └── entrypoint.sh
│
├── deploy/                 # Deployment configuration
│   ├── kamal.yml           # Kamal orchestration
│   ├── capistrano/         # Alternative: Capistrano config
│   └── kubernetes/         # Optional: K8s manifests
│
├── .github/
│   └── workflows/          # CI/CD pipelines
│       ├── test.yml
│       ├── lint.yml
│       └── deploy.yml
│
├── .env.example            # Environment template
├── .dockerignore
├── Gemfile                 # Dependency management
├── Gemfile.lock            # Locked versions
├── Dockerfile              # Multi-stage production build
├── docker-compose.yml      # Local development setup
├── Rakefile                # Rails tasks
├── Procfile                # Process types (Heroku/Render compatible)
├── .rubocop.yml            # Code style rules
├── .eslintrc.yml           # JavaScript linting
└── README.md               # Project documentation

```

---

## ✅ KEBUTUHAN FUNGSIONAL

### 1️⃣ FITUR UMUM (Harus Ada)

#### A. Halaman Publik (Landing Page)
- **Hero Section**
  - Profile photo dengan optimization
  - Bio singkat & tagline
  - Social media links (GitHub, LinkedIn, Twitter, etc.)
  - CTA buttons (View Work, Get in Touch)

- **Featured Projects Section**
  - Grid display dengan project cards
  - Filtering by category/technology
  - Project detail modal atau single page view
  - Links ke GitHub repository & live demo

- **Skills Showcase**
  - Category-based skills (Frontend, Backend, DevOps, etc.)
  - Progress bar atau skill levels
  - Technology icons

- **Experience Timeline**
  - Chronological work/education history
  - Company/institution names & descriptions
  - Roles, duration, & key achievements

- **Contact Section**
  - Contact form dengan validation
  - Email notifications
  - Social links
  - Optional: Calendly integration untuk meetings

- **Blog/Articles** (Optional tapi recommended)
  - Article listing dengan pagination
  - Search & filtering by tags
  - Reading time estimate
  - Comments (via Disqus atau built-in)

#### B. Admin Dashboard
- **Authentication & Authorization**
  - Secure login dengan password hash
  - Session management
  - Role-based access (admin/editor)

- **Content Management**
  - CRUD untuk Projects, Skills, Experience, Blog Posts
  - Rich text editor (Trix, Quill, atau markdown)
  - Image upload & optimization
  - SEO meta tags editor
  - Preview functionality

- **Analytics Dashboard**
  - Page view statistics
  - Form submission logs
  - Popular projects/articles
  - Traffic trends

- **Settings**
  - Profile information editor
  - Social media links configuration
  - Email notification preferences
  - Backup & export data

#### C. Technical Features
- **SEO Optimization**
  - Meta tags (title, description, og:image, etc.)
  - Sitemap generation
  - Robots.txt
  - Structured data (JSON-LD)
  - Open Graph support

- **Performance**
  - Image lazy loading & optimization
  - CSS/JS bundling & minification
  - Caching strategy (Redis, HTTP caching)
  - CDN integration (CloudFlare)
  - Database query optimization

- **Security**
  - CSRF protection
  - XSS prevention
  - SQL injection prevention
  - Rate limiting pada contact form
  - HTTPS everywhere
  - Security headers (CSP, X-Frame-Options, etc.)

- **Monitoring & Logging**
  - Error tracking (Sentry optional)
  - Request logging
  - Background job monitoring
  - Performance metrics

---

## 🛠️ PANDUAN IMPLEMENTASI

### FASE 1: Setup & Foundation (1-2 hari)

#### Step 1.1: Create Rails Project dengan Template Modern
```bash
# Create project dengan minimal dependencies
rails new portfolio-app \
  --css=tailwind \
  --javascript=esbuild \
  --database=postgresql \
  --skip-bundle

cd portfolio-app

# Atau dengan custom template (recommended)
rails new portfolio-app -m template.rb
```

#### Step 1.2: Essential Gems Setup
```ruby
# Gemfile

source 'https://rubygems.org'
ruby '3.3.0'

gem 'rails', '~> 8.0.0'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.0'

# Frontend
gem 'tailwindcss-rails', '~> 2.0'
gem 'jsbundling-rails', '~> 1.0'
gem 'importmap-rails', '~> 1.0'
gem 'stimulus-rails', '~> 1.0'
gem 'view_component', '~> 3.0'  # Reusable components

# Image processing
gem 'image_processing', '~> 1.2'
gem 'ruby-vips', '~> 2.1'
gem 'aws-sdk-s3', '~> 1.0'  # AWS S3 support

# Authorization & Authentication
gem 'devise', '~> 4.9'  # atau 'omniauth-rails_csrf_protection'
gem 'pundit', '~> 2.3'   # Authorization policies

# Pagination
gem 'pagy', '~> 6.0'

# Background jobs
gem 'sidekiq', '~> 7.0'
gem 'sidekiq-scheduler', '~> 5.0'

# SEO & Sitemap
gem 'sitemap_generator', '~> 6.3'
gem 'friendly_id', '~> 5.4'  # SEO-friendly URLs

# Admin panel (optional)
gem 'activeadmin', '~> 2.14'

# Email
gem 'sendgrid-ruby'  # atau sendgrid-actionmailer

# Caching & Performance
gem 'redis', '~> 5.0'
gem 'hiredis', '~> 0.6'  # Redis connection optimization

# Monitoring
gem 'sentry-rails', '~> 5.0'  # Error tracking
gem 'newrelic_rpm', '~> 9.0'  # Performance monitoring (optional)

# Testing
group :development, :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.2'
end

group :test do
  gem 'capybara', '~> 3.39'
  gem 'selenium-webdriver', '~> 4.0'
  gem 'webdrivers', '~> 5.2'
end

# Development tools
group :development do
  gem 'web-console', '~> 4.2'
  gem 'bullet', '~> 7.1'      # N+1 query detection
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rubocop', '~> 1.50', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

# Utilities
gem 'dotenv-rails', '~> 2.8'
gem 'kaminari', '~> 1.2'  # Alternative pagination
gem 'pagy_cursor_nav', '~> 0.3'  # Cursor-based pagination
```

#### Step 1.3: Initialize Database & Migrations
```bash
bundle install
rails db:create
rails db:migrate

# Generate models
rails generate model User email:string encrypted_password:string admin:boolean
rails generate model Project title:string slug:string description:text featured_image:string live_url:string github_url:string technologies:text published:boolean user:references
rails generate model Skill name:string category:string proficiency:integer user:references
rails generate model Experience company:string role:string description:text start_date:date end_date:date user:references
rails generate model BlogPost title:string slug:string content:text excerpt:string published_at:datetime user:references

# Run migrations
rails db:migrate
```

#### Step 1.4: Configure Environments
```ruby
# config/environments/production.rb
Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  
  config.cache_store = :redis_cache_store, {
    url: ENV['REDIS_URL'],
    namespace: 'portfolio_cache',
    connect_timeout: 30,
    read_timeout: 1,
    write_timeout: 1
  }
  
  config.session_store :cookie_store
  config.secret_key_base = ENV['SECRET_KEY_BASE']
  
  config.force_ssl = true
  config.ssl_options = { redirect: { status: 307 } }
  
  # Security headers
  config.secure_hsts_max_age = 31536000
  config.secure_hsts_include_subdomains = true
  config.secure_content_security_policy = {
    default_src: :self,
    script_src: [:self, 'cdn.tailwindcss.com'],
    style_src: [:self, 'cdn.tailwindcss.com'],
    img_src: [:self, :data, :https],
    font_src: :self
  }
  
  # Active Storage
  config.active_storage.service = :amazon
  
  # Sidekiq
  config.active_job.queue_adapter = :sidekiq
  
  # Logger
  config.log_level = :info
  config.log_to_stdout = true
end

# config/storage.yml
amazon:
  service: S3
  access_key_id: <%= ENV['AWS_ACCESS_KEY_ID'] %>
  secret_access_key: <%= ENV['AWS_SECRET_ACCESS_KEY'] %>
  region: <%= ENV['AWS_REGION'] %>
  bucket: <%= ENV['AWS_BUCKET'] %>
```

---

### FASE 2: Model & Database Layer (2-3 hari)

#### Step 2.1: Design Database Schema dengan Concerns
```ruby
# app/models/concerns/timestampable.rb
module Timestampable
  extend ActiveSupport::Concern
  
  included do
    scope :recent, -> { order(created_at: :desc) }
    scope :older, -> { order(created_at: :asc) }
  end
end

# app/models/concerns/slugifiable.rb
module Slugifiable
  extend ActiveSupport::Concern
  
  included do
    extend FriendlyId
    friendly_id :name, use: :slugged
  end
end

# app/models/concerns/publishable.rb
module Publishable
  extend ActiveSupport::Concern
  
  included do
    scope :published, -> { where(published: true) }
    scope :draft, -> { where(published: false) }
  end
end

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  
  has_many :projects, dependent: :destroy
  has_many :skills, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :blog_posts, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  
  enum role: { user: 0, editor: 1, admin: 2 }
  
  def admin?
    role == 'admin'
  end
end

# app/models/project.rb
class Project < ApplicationRecord
  include Timestampable
  include Slugifiable
  include Publishable
  
  belongs_to :user
  has_one_attached :featured_image, dependent: :purge_later
  
  validates :title, :description, presence: true
  
  scope :featured, -> { where(featured: true) }
  
  def featured_image_url
    featured_image.attached? ? url_for(featured_image) : nil
  end
  
  def technologies_array
    technologies&.split(',')&.map(&:strip) || []
  end
end

# app/models/skill.rb
class Skill < ApplicationRecord
  include Timestampable
  
  belongs_to :user
  
  validates :name, :category, presence: true
  
  CATEGORIES = ['Frontend', 'Backend', 'DevOps', 'Database', 'Tools'].freeze
  PROFICIENCIES = (1..5).to_a  # 1-5 scale
  
  enum proficiency: { beginner: 1, intermediate: 2, advanced: 3, expert: 4, master: 5 }
  
  scope :by_category, ->(cat) { where(category: cat) }
end

# app/models/experience.rb
class Experience < ApplicationRecord
  include Timestampable
  
  belongs_to :user
  
  validates :company, :role, :start_date, presence: true
  
  scope :current, -> { where(end_date: nil) }
  
  def duration_in_months
    end_date ||= Date.current
    ((end_date.year - start_date.year) * 12 + 
     end_date.month - start_date.month).abs
  end
end

# app/models/blog_post.rb
class BlogPost < ApplicationRecord
  include Timestampable
  include Slugifiable
  include Publishable
  
  belongs_to :user
  
  validates :title, :content, presence: true
  
  scope :sorted, -> { order(published_at: :desc) }
  
  def reading_time
    word_count = content.split.size
    (word_count / 200.0).ceil
  end
end
```

#### Step 2.2: Create Migrations
```ruby
# db/migrate/xxx_create_projects.rb
class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title, null: false, index: true
      t.string :slug, null: false, index: true
      t.text :description
      t.text :technologies
      t.string :live_url
      t.string :github_url
      t.boolean :published, default: false, index: true
      t.boolean :featured, default: false
      t.references :user, null: false, foreign_key: true, index: true
      
      t.timestamps
    end
    
    add_index :projects, [:slug, :user_id], unique: true
  end
end
```

---

### FASE 3: Controllers & Routes (2-3 hari)

#### Step 3.1: Routes Architecture
```ruby
# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'
  
  namespace :admin do
    authenticate :user, ->(user) { user.admin? } do
      root 'dashboard#index'
      
      resources :projects do
        member do
          patch :publish
          patch :unpublish
        end
      end
      
      resources :skills
      resources :experiences
      resources :blog_posts
      resources :users, only: [:index, :show]
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :show]
      resources :skills, only: [:index]
      resources :experiences, only: [:index]
      resources :blog_posts, only: [:index, :show]
    end
  end
  
  # Public routes
  resources :projects, only: [:index, :show]
  resources :blog_posts, only: [:index, :show]
  get 'about', to: 'pages#about'
  post 'contact', to: 'messages#create'
end
```

#### Step 3.2: Thin Controllers with Service Layer
```ruby
# app/controllers/admin/projects_controller.rb
module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: [:edit, :update, :destroy, :publish, :unpublish]
    
    def index
      @projects = current_user.projects.page(params[:page]).per(10)
    end
    
    def new
      @project = Project.new
    end
    
    def create
      @project = Projects::CreateService.call(
        user: current_user,
        params: project_params
      )
      
      if @project.persisted?
        redirect_to admin_project_url(@project), notice: 'Project created successfully'
      else
        render :new, status: :unprocessable_entity
      end
    end
    
    def update
      @project = Projects::UpdateService.call(
        project: @project,
        params: project_params
      )
      
      if @project.valid?
        redirect_to admin_project_url(@project), notice: 'Project updated successfully'
      else
        render :edit, status: :unprocessable_entity
      end
    end
    
    private
    
    def set_project
      @project = current_user.projects.find(params[:id])
      authorize @project
    end
    
    def project_params
      params.require(:project).permit(:title, :description, :technologies, :live_url, :github_url, :featured_image, :published)
    end
  end
end

# app/controllers/admin/base_controller.rb
module Admin
  class BaseController < ApplicationController
    include Pundit::Authorization
    
    before_action :authenticate_user!
    before_action :check_admin!
    
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    private
    
    def check_admin!
      redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
    end
    
    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || admin_root_path)
    end
  end
end
```

---

### FASE 4: Service Layer & Business Logic (2-3 hari)

#### Step 4.1: Service Objects Pattern
```ruby
# app/services/projects/create_service.rb
module Projects
  class CreateService
    def self.call(user:, params:)
      new(user, params).call
    end
    
    def initialize(user, params)
      @user = user
      @params = params
    end
    
    def call
      project = @user.projects.build(project_attributes)
      
      if project.save
        ImageProcessingJob.perform_later(project.id) if project.featured_image.attached?
        project
      else
        project
      end
    end
    
    private
    
    def project_attributes
      @params.slice(:title, :description, :technologies, :live_url, :github_url, :featured_image)
    end
  end
end

# app/services/projects/update_service.rb
module Projects
  class UpdateService
    def self.call(project:, params:)
      new(project, params).call
    end
    
    def initialize(project, params)
      @project = project
      @params = params
    end
    
    def call
      if @project.update(project_attributes)
        ImageProcessingJob.perform_later(@project.id) if @params[:featured_image].present?
        @project
      else
        @project
      end
    end
    
    private
    
    def project_attributes
      @params.slice(:title, :description, :technologies, :live_url, :github_url)
    end
  end
end
```

#### Step 4.2: Background Jobs Setup
```ruby
# app/jobs/image_processing_job.rb
class ImageProcessingJob < ApplicationJob
  queue_as :default
  
  def perform(project_id)
    project = Project.find(project_id)
    return unless project.featured_image.attached?
    
    project.featured_image.variant(resize_to_limit: [800, 600]).processed
  end
end

# app/jobs/send_contact_notification_job.rb
class SendContactNotificationJob < ApplicationJob
  queue_as :default
  
  def perform(message_id)
    message = Message.find(message_id)
    NotificationMailer.contact_message(message).deliver_later
  end
end

# config/sidekiq.yml
:concurrency: 10
:timeout: 25
:verbose: false
:queues:
  - [default, 5]
  - [mailers, 3]
  - [background, 1]

production:
  :concurrency: 20
```

---

### FASE 5: Frontend & Views (3-4 hari)

#### Step 5.1: ViewComponent Architecture
```ruby
# app/components/project_card_component.rb
class ProjectCardComponent < ViewComponent::Base
  def initialize(project:)
    @project = project
  end
  
  def featured_image_path
    @project.featured_image.attached? ? 
      url_for(@project.featured_image.variant(resize_to_limit: [400, 300])) : 
      'placeholder.jpg'
  end
  
  def technologies
    @project.technologies_array
  end
end

# app/components/project_card_component.html.erb
<div class="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition-shadow">
  <img src="<%= featured_image_path %>" alt="<%= @project.title %>" 
       class="w-full h-48 object-cover">
  
  <div class="p-6">
    <h3 class="text-lg font-semibold mb-2"><%= @project.title %></h3>
    <p class="text-gray-600 text-sm mb-4"><%= truncate(@project.description, length: 100) %></p>
    
    <div class="flex flex-wrap gap-2 mb-4">
      <% technologies.each do |tech| %>
        <span class="bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded">
          <%= tech %>
        </span>
      <% end %>
    </div>
    
    <div class="flex gap-3">
      <%= link_to 'View Project', project_path(@project), class: 'text-blue-600 hover:text-blue-800' %>
      <% if @project.github_url %>
        <%= link_to 'GitHub', @project.github_url, target: '_blank', rel: 'noopener', class: 'text-gray-600 hover:text-gray-800' %>
      <% end %>
    </div>
  </div>
</div>

# app/components/navbar_component.rb
class NavbarComponent < ViewComponent::Base
  def initialize(current_user: nil)
    @current_user = current_user
  end
end

# app/components/navbar_component.html.erb
<nav class="bg-white shadow-md">
  <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-4 flex justify-between items-center">
    <div>
      <%= link_to 'Portfolio', root_path, class: 'text-2xl font-bold text-blue-600' %>
    </div>
    
    <div class="flex items-center gap-6">
      <%= link_to 'Projects', projects_path %>
      <%= link_to 'Blog', blog_posts_path %>
      <%= link_to 'About', about_path %>
      
      <% if @current_user&.admin? %>
        <%= link_to 'Admin', admin_root_path, class: 'px-4 py-2 bg-blue-600 text-white rounded' %>
      <% end %>
      
      <% if @current_user %>
        <%= button_to 'Logout', destroy_user_session_path, method: :delete %>
      <% end %>
    </div>
  </div>
</nav>
```

#### Step 5.2: Main Layout & Pages
```erb
<!-- app/views/layouts/application.html.erb -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= page_title %></title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>
    
    <!-- SEO Meta Tags -->
    <meta name="description" content="<%= page_description %>">
    <meta name="keywords" content="<%= page_keywords %>">
    <meta property="og:title" content="<%= page_title %>">
    <meta property="og:description" content="<%= page_description %>">
    <meta property="og:image" content="<%= page_image %>">
    
    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_importmap_tags %>
  </head>

  <body class="antialiased">
    <%= render NavbarComponent.new(current_user: current_user) %>
    
    <div class="min-h-screen">
      <%= render 'shared/flash' %>
      <%= yield %>
    </div>
    
    <%= render FooterComponent.new %>
  </body>
</html>

<!-- app/views/home/index.html.erb -->
<div class="hero bg-gradient-to-r from-blue-600 to-indigo-600 text-white py-24">
  <div class="max-w-4xl mx-auto text-center px-4">
    <h1 class="text-5xl font-bold mb-4">Your Name</h1>
    <p class="text-xl mb-8">Full-stack Developer | Quantitative Trading Enthusiast | Tech Innovator</p>
    <div class="flex gap-4 justify-center">
      <%= link_to 'View My Work', projects_path, class: 'px-8 py-3 bg-white text-blue-600 rounded-lg font-semibold hover:bg-gray-100' %>
      <%= link_to 'Get in Touch', '#contact', class: 'px-8 py-3 border-2 border-white rounded-lg font-semibold hover:bg-blue-700' %>
    </div>
  </div>
</div>

<!-- Featured Projects -->
<section class="py-16 max-w-6xl mx-auto px-4">
  <h2 class="text-3xl font-bold mb-12">Featured Projects</h2>
  <div class="grid md:grid-cols-3 gap-8">
    <% @featured_projects.each do |project| %>
      <%= render ProjectCardComponent.new(project: project) %>
    <% end %>
  </div>
</section>

<!-- Skills Section -->
<section class="py-16 bg-gray-50">
  <div class="max-w-6xl mx-auto px-4">
    <h2 class="text-3xl font-bold mb-12">Skills</h2>
    <div class="grid md:grid-cols-4 gap-8">
      <% @skills_by_category.each do |category, skills| %>
        <div>
          <h3 class="font-semibold mb-4"><%= category %></h3>
          <% skills.each do |skill| %>
            <div class="mb-4">
              <div class="flex justify-between mb-2">
                <span><%= skill.name %></span>
                <span class="text-sm text-gray-600"><%= skill.proficiency %>/5</span>
              </div>
              <div class="w-full bg-gray-300 rounded-full h-2">
                <div class="bg-blue-600 h-2 rounded-full" style="width: <%= skill.proficiency * 20 %>%"></div>
              </div>
            </div>
          <% end %>
        </div>
      <% end %>
    </div>
  </div>
</section>

<!-- Contact Section -->
<section id="contact" class="py-16">
  <div class="max-w-2xl mx-auto px-4">
    <h2 class="text-3xl font-bold mb-8 text-center">Get in Touch</h2>
    <%= form_with local: true, url: messages_path, method: :post, class: "space-y-6" do |f| %>
      <% if @message&.errors.any? %>
        <div class="bg-red-50 border border-red-200 rounded p-4">
          <h3 class="font-semibold text-red-800"><%= pluralize(@message.errors.count, "error") %></h3>
          <ul>
            <% @message.errors.full_messages.each do |msg| %>
              <li class="text-red-700"><%= msg %></li>
            <% end %>
          </ul>
        </div>
      <% end %>
      
      <div>
        <%= f.label :name, "Name" %>
        <%= f.text_field :name, class: "w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500", required: true %>
      </div>
      
      <div>
        <%= f.label :email, "Email" %>
        <%= f.email_field :email, class: "w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500", required: true %>
      </div>
      
      <div>
        <%= f.label :subject, "Subject" %>
        <%= f.text_field :subject, class: "w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500", required: true %>
      </div>
      
      <div>
        <%= f.label :message, "Message" %>
        <%= f.text_area :message, rows: 6, class: "w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500", required: true %>
      </div>
      
      <%= f.submit "Send Message", class: "w-full px-6 py-3 bg-blue-600 text-white rounded-lg font-semibold hover:bg-blue-700 transition" %>
    <% end %>
  </div>
</section>
```

---

### FASE 6: Authorization & Security (1-2 hari)

#### Step 6.1: Pundit Policies
```ruby
# app/policies/application_policy.rb
class ApplicationPolicy
  attr_reader :user, :record
  
  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def index?
    false
  end
  
  def show?
    false
  end
  
  def create?
    @user&.admin?
  end
  
  def new?
    create?
  end
  
  def update?
    @user&.admin? && (@user == @record.user || @user.admin?)
  end
  
  def edit?
    update?
  end
  
  def destroy?
    @user&.admin? && (@user == @record.user || @user.admin?)
  end
end

# app/policies/project_policy.rb
class ProjectPolicy < ApplicationPolicy
  def show?
    @record.published? || @user == @record.user
  end
  
  def create?
    @user&.admin? || @user&.editor?
  end
end
```

#### Step 6.2: Security Configuration
```ruby
# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost', 'yourdomain.com'
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete]
  end
end

# config/initializers/content_security_policy.rb
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self
  policy.script_src :self, 'cdn.tailwindcss.com'
  policy.style_src :self, 'cdn.tailwindcss.com'
  policy.img_src :self, :data, :https
  policy.font_src :self
  policy.connect_src :self, ENV['API_ENDPOINT']
end
```

---

### FASE 7: Testing & Quality Assurance (2-3 hari)

#### Step 7.1: RSpec Setup & Model Tests
```ruby
# spec/spec_helper.rb
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

# spec/models/project_spec.rb
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe '#featured_image_url' do
    let(:project) { build(:project) }
    
    it 'returns nil when no image attached' do
      expect(project.featured_image_url).to be_nil
    end
  end

  describe 'scopes' do
    let(:user) { create(:user) }
    let!(:published) { create(:project, user: user, published: true) }
    let!(:draft) { create(:project, user: user, published: false) }
    
    it 'returns only published projects' do
      expect(Project.published).to include(published)
      expect(Project.published).not_to include(draft)
    end
  end
end

# spec/services/projects/create_service_spec.rb
require 'rails_helper'

RSpec.describe Projects::CreateService, type: :service do
  let(:user) { create(:user) }
  let(:params) do
    {
      title: 'New Project',
      description: 'Description',
      technologies: 'Ruby, Rails'
    }
  end
  
  describe '.call' do
    it 'creates a new project' do
      expect {
        Projects::CreateService.call(user: user, params: params)
      }.to change(Project, :count).by(1)
    end
    
    it 'returns the created project' do
      project = Projects::CreateService.call(user: user, params: params)
      expect(project.title).to eq('New Project')
    end
  end
end

# spec/factories/project_factory.rb
FactoryBot.define do
  factory :project do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    technologies { 'Ruby, Rails, PostgreSQL' }
    published { false }
    user
  end
end

# spec/rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  
  config.include FactoryBot::Syntax::Methods
end
```

#### Step 7.2: RuboCop Configuration
```yaml
# .rubocop.yml
AllCops:
  NewCops: enable
  Exclude:
    - 'db/schema.rb'
    - 'db/migrate/*'
    - 'node_modules/**/*'
    - 'vendor/**/*'

Style/StringLiterals:
  Enabled: true
  EnforcedStyle: single_quotes

Metrics/LineLength:
  Max: 100

Metrics/MethodLength:
  Max: 15

Metrics/ClassLength:
  Max: 300

Layout/MultilineHashBraceLayout:
  Enabled: true

Metrics/AbcSize:
  Max: 20

Rails:
  Enabled: true

Rake:
  Enabled: true
```

#### Step 7.3: CI/CD Pipeline
```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
      
      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.3'
          bundler-cache: true
      
      - name: Setup database
        run: bundle exec rails db:create db:schema:load
        env:
          DATABASE_URL: postgres://postgres:postgres@localhost:5432/portfolio_test
          REDIS_URL: redis://localhost:6379/1
      
      - name: Run tests
        run: bundle exec rspec
        env:
          DATABASE_URL: postgres://postgres:postgres@localhost:5432/portfolio_test
          REDIS_URL: redis://localhost:6379/1
      
      - name: Run linter
        run: bundle exec rubocop

# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Deploy with Kamal
        run: |
          curl -fsSL https://get.kamal-deploy.org | sh
          kamal deploy
        env:
          KAMAL_AUTH_TOKEN: ${{ secrets.KAMAL_AUTH_TOKEN }}
```

---

### FASE 8: Docker & Deployment (1-2 hari)

#### Step 8.1: Docker Configuration
```dockerfile
# Dockerfile (Multi-stage Production Build)
FROM ruby:3.3-alpine AS builder

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    libxslt-dev \
    libxml2-dev \
    git \
    nodejs \
    yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --frozen --without development test

COPY . .

RUN bundle exec rails assets:precompile
RUN bundle exec rails tailwindcss:build

# Runtime stage
FROM ruby:3.3-alpine

RUN apk add --no-cache \
    postgresql-client \
    libxslt \
    libxml2 \
    nodejs \
    ca-certificates \
    curl

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/public /app/public
COPY . .

ENV RAILS_ENV=production
ENV BUNDLE_PATH=/usr/local/bundle

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["bundle", "exec", "puma", "-b", "0.0.0.0:3000"]
```

```yaml
# docker-compose.yml (Development)
version: '3.9'

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile.dev
    ports:
      - "3000:3000"
    environment:
      DATABASE_URL: postgresql://postgres:password@db:5432/portfolio_dev
      REDIS_URL: redis://redis:6379/0
      RAILS_ENV: development
    volumes:
      - .:/app
    depends_on:
      - db
      - redis
    command: bin/dev

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: password
      POSTGRES_DB: portfolio_dev
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  sidekiq:
    build:
      context: .
      dockerfile: Dockerfile.dev
    environment:
      DATABASE_URL: postgresql://postgres:password@db:5432/portfolio_dev
      REDIS_URL: redis://redis:6379/0
      RAILS_ENV: development
    volumes:
      - .:/app
    depends_on:
      - db
      - redis
    command: bundle exec sidekiq

volumes:
  postgres_data:
  redis_data:
```

#### Step 8.2: Kamal Deployment Configuration
```yaml
# config/deploy.kamal.yml
service: portfolio
image: yourusername/portfolio:latest

servers:
  web:
    hosts:
      - 192.168.1.10  # Replace with your server IP
  job:
    hosts:
      - 192.168.1.10
    cmd: bundle exec sidekiq

registry:
  server: ghcr.io
  username: <%= ENV['REGISTRY_USERNAME'] %>
  password: <%= ENV['REGISTRY_PASSWORD'] %>

env:
  clear:
    RAILS_ENV: production
    RAILS_LOG_TO_STDOUT: true
  secret:
    - DATABASE_URL
    - REDIS_URL
    - SECRET_KEY_BASE
    - AWS_ACCESS_KEY_ID
    - AWS_SECRET_ACCESS_KEY
    - AWS_BUCKET
    - AWS_REGION

builder:
  remote: true
  args:
    RUBY_VERSION: "3.3"

volumes:
  - "storage:/app/storage"

healthcheck:
  path: /health
  interval: 30s
  timeout: 5s

logging:
  driver: awslogs
  options:
    awslogs-group: portfolio-production
    awslogs-region: us-east-1

accessories:
  db:
    image: postgres:15-alpine
    host: db.example.com
    port: 5432
    env:
      clear:
        POSTGRES_DB: portfolio_prod
      secret:
        - POSTGRES_PASSWORD
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    host: redis.example.com
    port: 6379
```

---

### FASE 9: SEO & Analytics (1 hari)

#### Step 9.1: SEO Configuration
```ruby
# config/initializers/seo.rb
SitemapGenerator::Sitemap.default_host = ENV['SITE_URL'] || 'https://portfolio.com'

# lib/tasks/sitemap.rake
namespace :sitemap do
  desc 'Generate XML sitemap'
  task generate: :environment do
    SitemapGenerator::Sitemap.create do
      add root_path, changefreq: 'weekly', priority: 1.0
      
      Project.published.each do |project|
        add project_path(project), lastmod: project.updated_at, changefreq: 'monthly'
      end
      
      BlogPost.published.each do |post|
        add blog_post_path(post), lastmod: post.updated_at, changefreq: 'weekly'
      end
    end
  end
end

# app/helpers/meta_tags_helper.rb
module MetaTagsHelper
  def set_meta_tags(title: nil, description: nil, image: nil, url: nil)
    @page_title = title || 'My Portfolio'
    @page_description = description || 'Full-stack Developer Portfolio'
    @page_image = image || image_url('og-image.jpg')
    @page_url = url || request.original_url
  end
  
  def page_title
    @page_title || 'Portfolio | Your Name'
  end
  
  def page_description
    @page_description || 'Full-stack Developer Portfolio'
  end
end

# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  def show
    @project = Project.friendly.find(params[:id])
    set_meta_tags(
      title: @project.title,
      description: @project.description,
      image: url_for(@project.featured_image) if @project.featured_image.attached?,
      url: project_url(@project)
    )
  end
end
```

#### Step 9.2: Analytics Setup
```erb
<!-- app/views/layouts/_analytics.html.erb -->
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=<%= ENV['GOOGLE_ANALYTICS_ID'] %>"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '<%= ENV["GOOGLE_ANALYTICS_ID"] %>');
</script>

<!-- Plausible Analytics (Privacy-friendly) -->
<script defer data-domain="<%= ENV['DOMAIN'] %>" src="https://plausible.io/js/script.js"></script>
```

---

## 🧪 TESTING & QUALITY ASSURANCE

### Test Coverage Checklist
```ruby
# Model Tests (70% coverage)
- [ ] Validations
- [ ] Associations
- [ ] Callbacks
- [ ] Scopes
- [ ] Custom methods

# Service Tests (80% coverage)
- [ ] Success path
- [ ] Failure paths
- [ ] Edge cases
- [ ] Side effects (jobs, mailers)

# Controller Tests (60% coverage)
- [ ] Happy path
- [ ] Authorization
- [ ] Error handling
- [ ] Response formats

# Integration Tests (40% coverage)
- [ ] User flows
- [ ] Admin workflows
- [ ] API endpoints

# Run tests
bundle exec rspec
bundle exec rspec --coverage
```

---

## 🚀 DEPLOYMENT STRATEGY

### Pre-deployment Checklist
```bash
# 1. Environment Configuration
export DATABASE_URL=postgresql://...
export REDIS_URL=redis://...
export SECRET_KEY_BASE=$(rails secret)
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...

# 2. Build & Test
docker build -t portfolio:latest .
docker compose up --build
bundle exec rspec
bundle exec rubocop

# 3. Database Migrations
bundle exec rails db:migrate:status
bundle exec rails db:migrate --verbose

# 4. Assets Precompilation
bundle exec rails assets:precompile
```

### Deployment Options

#### Option 1: Render.com (Recommended untuk Portfolio)
```bash
# 1. Connect GitHub repo ke Render
# 2. Setup environment variables di Render Dashboard
# 3. Configure build command:
bin/render-build.sh

# 4. Configure pre-deploy command:
bin/rails db:migrate

# 5. Custom health check:
/health
```

#### Option 2: DigitalOcean App Platform
```yaml
# app.yaml
name: portfolio
services:
  - name: web
    github:
      repo: username/portfolio
      branch: main
    build_command: bundle install && rails assets:precompile
    run_command: bundle exec puma
    http_port: 3000
    health_check:
      http_path: /health
    envs:
      - key: RAILS_ENV
        value: production
      - key: SECRET_KEY_BASE
        scope: RUN_TIME

  - name: worker
    github:
      repo: username/portfolio
      branch: main
    build_command: bundle install
    run_command: bundle exec sidekiq
    envs:
      - key: RAILS_ENV
        value: production

databases:
  - name: portfolio_db
    engine: PG
    version: "15"

static_sites:
  - name: cdn
    github:
      repo: username/portfolio
      branch: main
    build_command: echo "CDN"
```

#### Option 3: VPS dengan Kamal (Full Control)
```bash
# 1. SSH ke server
ssh root@your-server-ip

# 2. Install Docker & Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 3. Deploy dengan Kamal
kamal setup
kamal deploy
```

#### Option 4: Railway.app
```yaml
# railway.json
{
  "build": {
    "builder": "nixpacks"
  },
  "deploy": {
    "startCommand": "bundle exec puma -b 0.0.0.0:3000",
    "numReplicas": 1,
    "environmentVariables": {
      "RAILS_ENV": "production"
    }
  }
}
```

---

## 📊 MAINTENANCE & SCALING

### Regular Maintenance Tasks
```ruby
# Scheduled Tasks (Sidekiq Scheduler)
schedule:
  # Weekly sitemap generation
  sitemap_generation:
    cron: '0 0 * * 0'
    class: 'SitemapGenerationJob'
  
  # Daily cache warming
  cache_warming:
    cron: '0 1 * * *'
    class: 'CacheWarmingJob'
  
  # Database optimization
  vacuum_database:
    cron: '0 2 * * *'
    class: 'VacuumDatabaseJob'

# Database Maintenance
rails db:optimize                    # Analyze tables
rails db:pg_statement_limit:sync    # Reset connections

# Cache Management
rails cache:clear
redis-cli FLUSHDB
```

### Monitoring & Logging
```ruby
# config/initializers/sentry.rb
Sentry.init do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.environment = Rails.env
  config.traces_sample_rate = Rails.env.production? ? 0.1 : 1.0
  config.release = ENV['APP_VERSION']
end

# NewRelic Configuration
config/newrelic.yml
app_name: Portfolio
license_key: <%= ENV['NEWRELIC_LICENSE_KEY'] %>
```

### Backup Strategy
```bash
# Automated Daily Backups
0 2 * * * pg_dump portfolio_prod | gzip > /backups/$(date +\%Y\%m\%d).sql.gz

# S3 Backup Upload
0 3 * * * aws s3 cp /backups/ s3://portfolio-backups/ --recursive --delete
```

### Scaling Considerations
```
CPU/Memory > 80% →  Upgrade server instance
Database Queries > 100ms → Add indexes, query optimization
API Response Time > 500ms → Implement caching, CDN
Concurrent Users > 1000 → Load balancing, horizontal scaling
```

---

## 📝 IMPLEMENTATION CHECKLIST

### Phase 1-2 (Foundation & Database)
- [ ] Rails project setup with Tailwind + esbuild
- [ ] PostgreSQL & Redis configuration
- [ ] Models & associations created
- [ ] Database migrations validated
- [ ] Seeds created for testing

### Phase 3-4 (Controllers & Services)
- [ ] Thin controllers implemented
- [ ] Service objects for business logic
- [ ] Background jobs setup
- [ ] Authorization with Pundit
- [ ] API routes structured

### Phase 5 (Frontend)
- [ ] ViewComponents created
- [ ] Tailwind CSS styling complete
- [ ] Responsive design verified
- [ ] Interactive features with Stimulus JS
- [ ] Admin dashboard functional

### Phase 6-7 (Testing & Security)
- [ ] Unit tests (70%+ coverage)
- [ ] Integration tests written
- [ ] RuboCop linting passed
- [ ] Security headers configured
- [ ] CSRF/XSS protections active

### Phase 8-9 (Deployment & SEO)
- [ ] Docker image builds successfully
- [ ] CI/CD pipeline configured
- [ ] Deployment tested in staging
- [ ] SEO optimization complete
- [ ] Analytics integrated

### Production Readiness
- [ ] Environment variables configured
- [ ] Database backups scheduled
- [ ] Monitoring setup (Sentry/NewRelic)
- [ ] Logging configured
- [ ] Health checks working
- [ ] SSL/TLS certificates valid
- [ ] CDN configured
- [ ] Rate limiting active

---

## 🎓 ADDITIONAL RESOURCES

### Learning Path
1. **Ruby Fundamentals**: [Ruby Docs](https://ruby-doc.org)
2. **Rails Architecture**: [Rails Guides](https://guides.rubyonrails.org)
3. **Advanced Patterns**: [Code Climate Blog](https://blog.codeclimate.com)
4. **DevOps & Deployment**: [Kamal Docs](https://kamal-deploy.org)
5. **Testing Best Practices**: [RSpec Wiki](https://relishapp.com/rspec)

### Recommended Tools
- **IDE**: VS Code + Ruby extensions
- **API Testing**: Postman / Insomnia
- **Database GUI**: pgAdmin / DBeaver
- **Monitoring**: Sentry, NewRelic, DataDog
- **CDN**: CloudFlare, AWS CloudFront
- **Hosting**: Render, Railway, DigitalOcean, Linode

### Community & Support
- [Ruby Forum](https://forum.ruby-lang.org)
- [Rails Discussion](https://discuss.rubyonrails.org)
- [Stack Overflow Rails](https://stackoverflow.com/questions/tagged/ruby-on-rails)
- [Reddit r/rails](https://reddit.com/r/rails)

---

## 📞 SUPPORT & NEXT STEPS

Setelah mengikuti prompt ini, Anda akan memiliki:

✅ Production-ready Ruby on Rails portfolio
✅ Modular, maintainable code structure
✅ Comprehensive testing suite
✅ CI/CD pipeline otomatis
✅ Multiple deployment options
✅ SEO optimized & analytics ready
✅ Scalable architecture

**Untuk Anda khususnya**: Karena background Anda di quantitative trading, Anda bisa extend ini dengan:
- Integrasi data market sentiment ke portfolio dashboard
- Showcase trading algorithms/backtest results
- Real-time API untuk data finansial
- Custom analytics untuk trading projects

Semua bisa di-maintain dengan mudah dengan struktur modular ini!

---

**Created: December 2024**
**Version: 1.0**
**License: MIT**
