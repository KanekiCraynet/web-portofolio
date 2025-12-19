# 🎯 PROMPT ENGINEERING LENGKAP: Personal Portfolio Website
## Ruby on Rails + UI/UX Profesional dengan 3D Modern

---

## 📋 DAFTAR ISI
1. [Ruby on Rails Foundation](#ruby-on-rails-foundation)
2. [UI/UX Design System](#uiux-design-system)
3. [3D Design Implementation](#3d-design-implementation)
4. [Responsive Layout Architecture](#responsive-layout-architecture)
5. [Micro-interactions & Animations](#micro-interactions--animations)
6. [Component Library](#component-library)
7. [Performance Optimization](#performance-optimization)

---

## 🏗️ RUBY ON RAILS FOUNDATION

### Tech Stack Rekomendasi
```
Frontend:
  - Rails 8.0+ (dengan esbuild)
  - Tailwind CSS 4
  - Stimulus JS untuk interaksi
  - ViewComponent untuk reusable UI

Backend:
  - Ruby 3.3+
  - PostgreSQL (database)
  - Redis (caching)
  - Sidekiq (background jobs)

DevOps:
  - Docker & Docker Compose
  - GitHub Actions (CI/CD)
  - Kamal (deployment)
  - Render/Railway/DigitalOcean
```

### Project Structure
```
portfolio-app/
├── app/
│   ├── components/       # ViewComponents + 3D elements
│   ├── controllers/      # Thin, RESTful
│   ├── models/           # Business logic
│   ├── services/         # Service objects
│   ├── jobs/             # Background processing
│   ├── javascript/       # 3D scenes, animations
│   └── views/            # ERB templates
├── config/               # Environment config
├── db/                   # Migrations
├── spec/                 # Tests (RSpec)
├── docker/               # Docker files
└── .github/workflows/    # CI/CD pipelines
```

---

## 🎨 UI/UX DESIGN SYSTEM

### A. Color Palette (Modern Professional)

#### Primary Colors
```
Primary Blue: #0066FF         (Action, CTAs, key elements)
Secondary Teal: #00B4D8       (Accents, highlights)
Accent Purple: #7C3AED        (Premium features, gradients)
Dark Neutral: #0F1419         (Text, headers)
Light Neutral: #F8F9FA        (Backgrounds)

Gradients:
  - Dynamic: #0066FF → #00B4D8 (modern, energetic)
  - Premium: #7C3AED → #0066FF (sophisticated)
  - Fresh: #00B4D8 → #00D9FF (vibrant)
```

#### Dark Mode
```
Background: #0F1419
Surface: #1A1F2E
Border: #3A4452
Text Primary: #F8F9FA
Text Secondary: #A0A8B8
```

### B. Typography System

#### Font Stack
```
Headers: Inter, system-ui, -apple-system
Body: Inter, Segoe UI, Roboto
Monospace: 'Fira Code', 'JetBrains Mono'
```

#### Responsive Sizing
```
Mobile (< 768px):
  - Hero Title: 32px, font-weight: 700
  - H1: 28px, font-weight: 600
  - H2: 24px, font-weight: 600
  - H3: 20px, font-weight: 500
  - Body: 16px, font-weight: 400, line-height: 1.6

Tablet (768px - 1024px):
  - Hero Title: 40px
  - H1: 32px
  - H2: 28px
  - H3: 24px
  - Body: 17px

Desktop (1024px+):
  - Hero Title: 48px
  - H1: 36px
  - H2: 32px
  - H3: 28px
  - Body: 18px
```

### C. Spacing System (8px Grid)

```
Spacing Scale:
  - xs: 4px    (micro spacing)
  - sm: 8px    (small gaps)
  - md: 16px   (standard spacing)
  - lg: 24px   (section spacing)
  - xl: 32px   (major sections)
  - 2xl: 48px  (hero sections)
  - 3xl: 64px  (page sections)

Mobile Container Padding: 16px
Desktop Container Padding: 32px
```

---

## 🎭 3D DESIGN IMPLEMENTATION

### A. Technology Stack

```html
Libraries:
  1. Three.js (Primary 3D library)
     - Mature, extensive docs
     - Great WebGL abstraction
     
  2. Babylon.js (Alternative)
     - Physics engine built-in
     - More features out-of-box
     
  3. Spline (No-code 3D design)
     - Visual 3D scene builder
     - Direct web export
     
  4. TresJS / Vue 3 Three
     - For Vue-based projects

Compatibility:
  ✓ WebGL 2.0 (98%+ browsers)
  ✓ Progressive enhancement
  ✓ Mobile optimization
  ✓ Fallback images available
```

### B. Hero 3D Scene Implementation

```javascript
// app/javascript/hero-3d-scene.js
import * as THREE from 'three';

class Hero3DScene {
  constructor(container) {
    this.container = container;
    this.setupScene();
    this.setupLights();
    this.createObjects();
    this.setupResponsive();
    this.animate();
  }

  setupScene() {
    const width = this.container.clientWidth;
    const height = this.container.clientHeight;
    
    this.scene = new THREE.Scene();
    this.camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
    this.camera.position.z = 3;
    
    this.renderer = new THREE.WebGLRenderer({
      antialias: true,
      alpha: true,
      powerPreference: 'high-performance'
    });
    this.renderer.setSize(width, height);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.container.appendChild(this.renderer.domElement);
  }

  setupLights() {
    const ambient = new THREE.AmbientLight(0xffffff, 0.6);
    this.scene.add(ambient);

    const directional = new THREE.DirectionalLight(0x0066FF, 1);
    directional.position.set(5, 5, 5);
    directional.castShadow = true;
    this.scene.add(directional);

    const point = new THREE.PointLight(0x00B4D8, 0.8);
    point.position.set(-5, -5, 2);
    this.scene.add(point);
  }

  createObjects() {
    // Floating cube
    const cubeGeo = new THREE.BoxGeometry(1, 1, 1);
    const cubeMat = new THREE.MeshStandardMaterial({
      color: 0x0066FF,
      metalness: 0.7,
      roughness: 0.2,
      emissive: 0x0066FF,
      emissiveIntensity: 0.3
    });
    this.cube = new THREE.Mesh(cubeGeo, cubeMat);
    this.scene.add(this.cube);

    // Rotating torus
    const torusGeo = new THREE.TorusGeometry(1.5, 0.4, 16, 100);
    const torusMat = new THREE.MeshStandardMaterial({
      color: 0x00B4D8,
      metalness: 0.5,
      roughness: 0.3
    });
    this.torus = new THREE.Mesh(torusGeo, torusMat);
    this.scene.add(this.torus);
  }

  setupResponsive() {
    window.addEventListener('resize', () => this.onWindowResize());
    this.container.addEventListener('mousemove', (e) => this.onMouseMove(e));
  }

  onWindowResize() {
    const width = this.container.clientWidth;
    const height = this.container.clientHeight;
    
    this.camera.aspect = width / height;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(width, height);
  }

  onMouseMove(event) {
    const x = (event.clientX / window.innerWidth) * 2 - 1;
    const y = -(event.clientY / window.innerHeight) * 2 + 1;
    
    this.cube.rotation.x += y * 0.01;
    this.cube.rotation.y += x * 0.01;
  }

  animate() {
    requestAnimationFrame(() => this.animate());

    this.cube.rotation.x += 0.001;
    this.cube.rotation.y += 0.002;
    this.torus.rotation.z += 0.003;
    
    this.cube.position.y = Math.sin(Date.now() * 0.0005) * 0.2;
    
    this.renderer.render(this.scene, this.camera);
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('hero-3d');
  if (container) new Hero3DScene(container);
});
```

### C. 3D Project Card (Flip Effect)

```erb
<!-- app/components/project_card_3d_component.html.erb -->
<div class="project-card-3d" data-project-id="<%= @project.id %>">
  <div class="card-inner">
    <!-- Front -->
    <div class="card-front">
      <div class="card-image-container">
        <img src="<%= featured_image_path %>" alt="<%= @project.title %>" 
             class="card-image" loading="lazy">
        <div class="image-overlay"></div>
      </div>
      
      <div class="card-content">
        <h3 class="card-title"><%= @project.title %></h3>
        <p class="card-description"><%= truncate(@project.description, length: 80) %></p>
        
        <div class="card-technologies">
          <% technologies.each do |tech| %>
            <span class="tech-badge"><%= tech %></span>
          <% end %>
        </div>
      </div>
    </div>

    <!-- Back -->
    <div class="card-back">
      <div class="back-content">
        <h4>Quick Links</h4>
        <div class="back-links">
          <%= link_to 'View Project', project_path(@project), class: 'back-link' %>
          <% if @project.github_url %>
            <%= link_to 'GitHub', @project.github_url, target: '_blank', class: 'back-link' %>
          <% end %>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .project-card-3d {
    perspective: 1000px;
    cursor: pointer;
    height: 400px;
  }

  .card-inner {
    position: relative;
    width: 100%;
    height: 100%;
    transition: transform 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
    transform-style: preserve-3d;
  }

  .project-card-3d:hover .card-inner {
    transform: rotateY(180deg) rotateX(5deg);
  }

  .card-front, .card-back {
    position: absolute;
    width: 100%;
    height: 100%;
    backface-visibility: hidden;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 10px 40px rgba(0, 102, 255, 0.1);
  }

  .card-front {
    background: white;
    display: flex;
    flex-direction: column;
    z-index: 2;
  }

  .card-back {
    background: linear-gradient(135deg, #0066FF 0%, #00B4D8 100%);
    color: white;
    transform: rotateY(180deg);
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .card-image-container {
    position: relative;
    height: 60%;
    overflow: hidden;
  }

  .card-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.6s ease;
  }

  .project-card-3d:hover .card-image {
    transform: scale(1.05) rotateZ(2deg);
  }

  .card-content {
    padding: 20px;
    flex: 1;
    display: flex;
    flex-direction: column;
  }

  .card-title {
    font-size: 20px;
    font-weight: 600;
    margin: 0 0 8px 0;
  }

  .card-technologies {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }

  .tech-badge {
    background: #F0F4FF;
    color: #0066FF;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 500;
  }

  .project-card-3d:hover .tech-badge {
    background: #0066FF;
    color: white;
    transform: translateY(-2px);
  }

  /* Mobile: disable 3D flip */
  @media (max-width: 768px) {
    .project-card-3d:hover .card-inner {
      transform: none;
    }

    .card-back {
      position: static;
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.3s ease;
    }

    .project-card-3d:active .card-back {
      max-height: 200px;
    }
  }

  @media (prefers-reduced-motion: reduce) {
    .card-inner, .card-image, .tech-badge {
      transition: none !important;
    }
  }
</style>
```

---

## 📱 RESPONSIVE LAYOUT ARCHITECTURE

### A. Breakpoint Strategy

```scss
// Mobile-First Breakpoints
$sm: 480px;    // Small phones
$md: 768px;    // Tablets
$lg: 1024px;   // Desktops
$xl: 1280px;   // Large desktops

@mixin md { @media (min-width: $md) { @content; } }
@mixin lg { @media (min-width: $lg) { @content; } }
@mixin xl { @media (min-width: $xl) { @content; } }
```

### B. Responsive Grid Examples

```erb
<!-- 3-2-1 Grid Layout -->
<div class="projects-grid">
  <% @projects.each do |project| %>
    <%= render ProjectCard3DComponent.new(project: project) %>
  <% end %>
</div>

<style>
  .projects-grid {
    display: grid;
    grid-template-columns: 1fr;            /* Mobile: 1 column */
    gap: 16px;

    @media (min-width: 768px) {
      grid-template-columns: repeat(2, 1fr);  /* Tablet: 2 columns */
      gap: 20px;
    }

    @media (min-width: 1024px) {
      grid-template-columns: repeat(3, 1fr);  /* Desktop: 3 columns */
      gap: 24px;
    }
  }
</style>
```

### C. Responsive Section Component

```erb
<!-- app/components/responsive_section_component.html.erb -->
<section class="responsive-section">
  <div class="section-container">
    <div class="section-header">
      <h2 class="section-title"><%= title %></h2>
      <p class="section-subtitle"><%= subtitle %></p>
    </div>

    <div class="section-content">
      <%= yield %>
    </div>
  </div>
</section>

<style>
  .responsive-section {
    padding: 24px 16px;  /* Mobile */

    @media (min-width: 768px) {
      padding: 40px 24px;  /* Tablet */
    }

    @media (min-width: 1024px) {
      padding: 60px 32px;  /* Desktop */
    }
  }

  .section-container {
    max-width: 1200px;
    margin: 0 auto;
  }

  .section-title {
    font-size: 28px;  /* Mobile */

    @media (min-width: 768px) {
      font-size: 32px;  /* Tablet */
    }

    @media (min-width: 1024px) {
      font-size: 36px;  /* Desktop */
    }
  }

  .section-content {
    display: grid;
    grid-template-columns: 1fr;  /* Mobile */
    gap: 16px;

    @media (min-width: 768px) {
      grid-template-columns: repeat(2, 1fr);  /* Tablet */
      gap: 20px;
    }

    @media (min-width: 1024px) {
      grid-template-columns: repeat(3, 1fr);  /* Desktop */
      gap: 24px;
    }
  }
</style>
```

---

## ✨ MICRO-INTERACTIONS & ANIMATIONS

### A. CSS Animations Library

```scss
@keyframes slideInUp {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

/* Apply animations */
.fade-in {
  animation: fadeIn 0.6s ease-out forwards;
}

.slide-in-up {
  animation: slideInUp 0.6s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
  opacity: 0;
}

.float {
  animation: float 3s ease-in-out infinite;
}

/* Hover effects */
@mixin hover-lift {
  transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1),
              box-shadow 0.3s ease;
  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 20px 40px rgba(0, 102, 255, 0.15);
  }
}
```

### B. Scroll Animations (Intersection Observer)

```javascript
// app/javascript/scroll-animations.js
class ScrollAnimations {
  constructor() {
    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersection(entries),
      { threshold: 0.1, rootMargin: '0px 0px -50px 0px' }
    );
    this.init();
  }

  init() {
    const elements = document.querySelectorAll('[data-animate]');
    elements.forEach(el => this.observer.observe(el));
  }

  handleIntersection(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const animation = entry.target.dataset.animate;
        entry.target.classList.add(animation);
        this.observer.unobserve(entry.target);
      }
    });
  }
}

document.addEventListener('DOMContentLoaded', () => {
  new ScrollAnimations();
});
```

---

## 🎨 COMPONENT LIBRARY

### Button Component

```erb
<!-- app/components/button_component.html.erb -->
<button class="btn btn--<%= variant %> btn--<%= size %>" <%= html_attributes %>>
  <%= text %>
</button>

<style>
  .btn {
    border: none;
    border-radius: 8px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
  }

  .btn--primary {
    background: linear-gradient(135deg, #0066FF 0%, #0052CC 100%);
    color: white;
    padding: 12px 24px;
    box-shadow: 0 4px 15px rgba(0, 102, 255, 0.2);

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(0, 102, 255, 0.3);
    }
  }

  .btn--secondary {
    background: rgba(0, 102, 255, 0.1);
    color: #0066FF;
    border: 2px solid #0066FF;

    &:hover {
      background: rgba(0, 102, 255, 0.2);
    }
  }

  .btn--lg {
    padding: 16px 32px;
    font-size: 18px;
  }

  .btn--md {
    padding: 12px 24px;
    font-size: 16px;
  }

  .btn--sm {
    padding: 8px 16px;
    font-size: 14px;
  }
</style>
```

### Card Component

```erb
<!-- app/components/card_component.html.erb -->
<div class="card">
  <% if image_url %>
    <img src="<%= image_url %>" alt="<%= title %>" class="card-image">
  <% end %>
  
  <div class="card-body">
    <h3 class="card-title"><%= title %></h3>
    <p class="card-description"><%= description %></p>
  </div>
</div>

<style>
  .card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
    transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);

    &:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 30px rgba(0, 102, 255, 0.15);
    }
  }

  .card-image {
    width: 100%;
    height: 200px;
    object-fit: cover;
  }

  .card-body {
    padding: 24px;
  }

  .card-title {
    font-size: 18px;
    font-weight: 600;
    margin: 0 0 8px 0;
  }

  .card-description {
    font-size: 14px;
    color: #A0A8B8;
    margin: 0;
  }

  @media (prefers-color-scheme: dark) {
    .card {
      background: #1A1F2E;
    }
  }
</style>
```

---

## 📊 PERFORMANCE OPTIMIZATION

### A. Image Optimization

```erb
<!-- Responsive Images -->
<img 
  src="<%= image_path('project-300.jpg') %>"
  srcset="
    <%= image_path('project-300.jpg') %> 300w,
    <%= image_path('project-600.jpg') %> 600w,
    <%= image_path('project-900.jpg') %> 900w,
    <%= image_path('project-1200.jpg') %> 1200w
  "
  sizes="(max-width: 480px) 100vw,
         (max-width: 768px) 90vw,
         (max-width: 1024px) 80vw,
         60vw"
  alt="Project"
  loading="lazy"
/>

<!-- WebP with Fallback -->
<picture>
  <source srcset="<%= image_path('project.webp') %>" type="image/webp">
  <img src="<%= image_path('project.jpg') %>" alt="Project" loading="lazy">
</picture>
```

### B. CSS Performance

```scss
/* Mobile-first minimal CSS */
.component {
  padding: 16px;
  font-size: 14px;
  
  @media (min-width: 768px) {
    padding: 24px;
    font-size: 16px;
  }
}

/* Defer non-critical animations */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## ✅ RESPONSIVE TESTING CHECKLIST

```markdown
### Devices
- [ ] iPhone SE (375px)
- [ ] iPhone 14 Pro Max (430px)
- [ ] Samsung Galaxy S21 (360px)
- [ ] iPad (768px)
- [ ] iPad Pro (1024px)
- [ ] Desktop (1280px+)
- [ ] Ultra-wide (1920px+)

### Features
- [ ] Navigation responsive
- [ ] Touch targets 44x44px+
- [ ] Images scale proportionally
- [ ] Text readable without zoom
- [ ] No horizontal scroll
- [ ] Performance < 3s load (4G)

### Accessibility
- [ ] Color contrast 4.5:1
- [ ] Keyboard navigation works
- [ ] Screen reader compatible
- [ ] Focus states visible
```

---

## 📞 NEXT STEPS

1. **Implementasi Phase 1-2**: Foundation & Database
2. **Build Phase 3-5**: Controllers, Services, Views
3. **Add 3D Elements**: Hero scene, cards
4. **Test Responsiveness**: All breakpoints
5. **Deploy**: Render/Railway/VPS
6. **Extend**: Trading analytics features

**Semuanya bisa di-maintain dan di-scale dengan struktur modular ini! 🚀**

---

**Created: December 2024**
**Version: 2.0 (Complete with UI/UX)**
**License: MIT**
