# Navbar component with active state detection and helper methods
class NavbarComponent < ViewComponent::Base
  def initialize(current_user: nil)
    @current_user = current_user
  end

  def nav_links
    [
      { name: "Home", path: "/" },
      { name: "Projects", path: "/projects" },
      { name: "Blog", path: "/blog" },
      { name: "About", path: "/about" },
      { name: "Contact", path: "/contact" }
    ]
  end

  def active_link?(path)
    # Exact match for home, prefix match for others
    if path == "/"
      helpers.request.path == "/"
    else
      helpers.request.path.start_with?(path)
    end
  end

  def link_classes(path, mobile: false)
    base = mobile ? "block px-4 py-3 rounded-lg font-medium transition-all duration-200" : "relative py-2 font-medium transition-all duration-200"

    if active_link?(path)
      mobile ? "#{base} bg-blue-50 text-blue-600" : "#{base} text-blue-600"
    else
      mobile ? "#{base} text-gray-600 hover:text-blue-600 hover:bg-gray-50" : "#{base} text-gray-600 hover:text-blue-600"
    end
  end
end
