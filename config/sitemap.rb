# Sitemap Generator Configuration
# Run: rake sitemap:refresh to generate sitemap

SitemapGenerator::Sitemap.default_host = ENV.fetch('SITE_URL', 'http://localhost:3000')
SitemapGenerator::Sitemap.compress = false  # Set to true in production

SitemapGenerator::Sitemap.create do
  # Root path - highest priority
  add root_path, changefreq: 'weekly', priority: 1.0

  # Static pages
  add about_path, changefreq: 'monthly', priority: 0.8
  add contact_path, changefreq: 'monthly', priority: 0.7
  add projects_path, changefreq: 'weekly', priority: 0.9
  add blog_posts_path, changefreq: 'weekly', priority: 0.9

  # Published Projects
  Project.published.find_each do |project|
    add project_path(project),
        lastmod: project.updated_at,
        changefreq: 'monthly',
        priority: 0.8
  end

  # Published Blog Posts
  BlogPost.published.find_each do |post|
    add blog_post_path(post),
        lastmod: post.updated_at,
        changefreq: 'monthly',
        priority: 0.7
  end
end
