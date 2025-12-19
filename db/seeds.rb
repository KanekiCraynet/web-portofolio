# Seeds file for Portfolio Application
# Run: rails db:seed

puts "🌱 Seeding database..."

# Create Admin User
admin = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Portfolio Admin"
  user.password = "password123"
  user.password_confirmation = "password123"
  user.role = :admin
  user.bio = "Full-stack developer passionate about building elegant, scalable solutions."
  user.tagline = "Building the future, one line at a time"
  user.github_url = "https://github.com/yourusername"
  user.linkedin_url = "https://linkedin.com/in/yourusername"
  user.twitter_url = "https://twitter.com/yourusername"
end
puts "✅ Admin user created: #{admin.email}"

# Create Skills
skills_data = [
  { category: "Frontend", name: "React", proficiency: 5 },
  { category: "Frontend", name: "TypeScript", proficiency: 4 },
  { category: "Frontend", name: "Tailwind CSS", proficiency: 5 },
  { category: "Frontend", name: "Vue.js", proficiency: 3 },
  { category: "Backend", name: "Ruby on Rails", proficiency: 5 },
  { category: "Backend", name: "Node.js", proficiency: 4 },
  { category: "Backend", name: "Python", proficiency: 4 },
  { category: "Backend", name: "Go", proficiency: 3 },
  { category: "Database", name: "PostgreSQL", proficiency: 5 },
  { category: "Database", name: "Redis", proficiency: 4 },
  { category: "Database", name: "MongoDB", proficiency: 3 },
  { category: "DevOps", name: "Docker", proficiency: 4 },
  { category: "DevOps", name: "Kubernetes", proficiency: 3 },
  { category: "DevOps", name: "AWS", proficiency: 4 },
  { category: "Tools", name: "Git", proficiency: 5 },
  { category: "Tools", name: "Linux", proficiency: 4 }
]

skills_data.each do |skill_attrs|
  Skill.find_or_create_by!(user: admin, name: skill_attrs[:name]) do |skill|
    skill.category = skill_attrs[:category]
    skill.proficiency = skill_attrs[:proficiency]
  end
end
puts "✅ #{skills_data.count} skills created"

# Create Experiences
experiences_data = [
  {
    company: "Tech Startup Inc",
    role: "Senior Full-Stack Developer",
    description: "Led development of microservices architecture. Implemented CI/CD pipelines and mentored junior developers.",
    start_date: Date.new(2022, 1, 1),
    end_date: nil,
    location: "Remote"
  },
  {
    company: "Digital Agency Co",
    role: "Full-Stack Developer",
    description: "Built custom web applications for clients using Ruby on Rails and React.",
    start_date: Date.new(2020, 3, 1),
    end_date: Date.new(2021, 12, 31),
    location: "San Francisco, CA"
  },
  {
    company: "Software Solutions Ltd",
    role: "Junior Developer",
    description: "Developed and maintained web applications. Collaborated with team on agile projects.",
    start_date: Date.new(2018, 6, 1),
    end_date: Date.new(2020, 2, 28),
    location: "New York, NY"
  }
]

experiences_data.each do |exp_attrs|
  Experience.find_or_create_by!(user: admin, company: exp_attrs[:company], role: exp_attrs[:role]) do |exp|
    exp.description = exp_attrs[:description]
    exp.start_date = exp_attrs[:start_date]
    exp.end_date = exp_attrs[:end_date]
    exp.location = exp_attrs[:location]
  end
end
puts "✅ #{experiences_data.count} experiences created"

# Create Projects
projects_data = [
  {
    title: "E-Commerce Platform",
    description: "A full-featured e-commerce platform with payment processing, inventory management, and admin dashboard.",
    technologies: "Ruby on Rails, React, PostgreSQL, Stripe, Redis",
    live_url: "https://example-ecommerce.com",
    github_url: "https://github.com/yourusername/ecommerce",
    published: true,
    featured: true
  },
  {
    title: "Task Management App",
    description: "Real-time collaborative task management application with team features and notifications.",
    technologies: "Rails, Hotwire, Tailwind CSS, ActionCable",
    live_url: "https://example-tasks.com",
    github_url: "https://github.com/yourusername/taskman",
    published: true,
    featured: true
  },
  {
    title: "API Gateway Service",
    description: "Microservices API gateway with rate limiting, authentication, and request routing.",
    technologies: "Go, Redis, Docker, Kubernetes",
    live_url: nil,
    github_url: "https://github.com/yourusername/api-gateway",
    published: true,
    featured: false
  }
]

projects_data.each do |proj_attrs|
  Project.find_or_create_by!(user: admin, title: proj_attrs[:title]) do |project|
    project.description = proj_attrs[:description]
    project.technologies = proj_attrs[:technologies]
    project.live_url = proj_attrs[:live_url]
    project.github_url = proj_attrs[:github_url]
    project.published = proj_attrs[:published]
    project.featured = proj_attrs[:featured]
  end
end
puts "✅ #{projects_data.count} projects created"

# Create Blog Posts
blog_posts_data = [
  {
    title: "Building Scalable Rails Applications",
    content: "In this article, we explore best practices for building scalable Ruby on Rails applications...",
    excerpt: "Learn how to build Rails apps that scale to millions of users.",
    published: true,
    published_at: 1.week.ago
  },
  {
    title: "Getting Started with Hotwire",
    content: "Hotwire is a new approach to building modern web applications without much JavaScript...",
    excerpt: "A beginner's guide to Hotwire and Turbo in Rails.",
    published: true,
    published_at: 2.weeks.ago
  }
]

blog_posts_data.each do |post_attrs|
  BlogPost.find_or_create_by!(user: admin, title: post_attrs[:title]) do |post|
    post.content = post_attrs[:content]
    post.excerpt = post_attrs[:excerpt]
    post.published = post_attrs[:published]
    post.published_at = post_attrs[:published_at]
  end
end
puts "✅ #{blog_posts_data.count} blog posts created"

puts "🎉 Seeding completed!"
puts ""
puts "Login credentials:"
puts "  Email: admin@example.com"
puts "  Password: password123"
