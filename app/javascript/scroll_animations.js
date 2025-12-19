// Scroll Animations - Intersection Observer based animations
// Triggers CSS animations when elements scroll into view

class ScrollAnimations {
  constructor(options = {}) {
    this.threshold = options.threshold || 0.1;
    this.rootMargin = options.rootMargin || '0px 0px -50px 0px';
    this.staggerDelay = options.staggerDelay || 100;

    // Check for reduced motion preference
    this.prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersection(entries),
      {
        threshold: this.threshold,
        rootMargin: this.rootMargin
      }
    );

    this.init();
  }

  init() {
    // Observe all elements with data-animate attribute
    const elements = document.querySelectorAll('[data-animate]');
    elements.forEach((el, index) => {
      // Store original index for stagger animations
      el.dataset.animateIndex = index;
      this.observer.observe(el);
    });

    // Observe stagger groups
    const staggerGroups = document.querySelectorAll('[data-animate-stagger]');
    staggerGroups.forEach(group => {
      this.observer.observe(group);
    });
  }

  handleIntersection(entries) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const element = entry.target;

        // Handle stagger groups (animate children sequentially)
        if (element.hasAttribute('data-animate-stagger')) {
          this.animateStaggerGroup(element);
        } else {
          // Handle single element animation
          this.animateElement(element);
        }

        // Unobserve after animation triggers
        this.observer.unobserve(element);
      }
    });
  }

  animateElement(element) {
    if (this.prefersReducedMotion) {
      // Instantly show without animation
      element.classList.add('animated');
      element.style.opacity = '1';
      element.style.transform = 'none';
      return;
    }

    const animation = element.dataset.animate;
    const delay = element.dataset.animateDelay || 0;

    setTimeout(() => {
      element.classList.add(animation, 'animated');
    }, parseInt(delay));
  }

  animateStaggerGroup(group) {
    const children = group.querySelectorAll('[data-animate-child]');
    const animation = group.dataset.animateStagger;

    children.forEach((child, index) => {
      if (this.prefersReducedMotion) {
        child.classList.add('animated');
        child.style.opacity = '1';
        child.style.transform = 'none';
        return;
      }

      setTimeout(() => {
        child.classList.add(animation, 'animated');
      }, index * this.staggerDelay);
    });
  }

  // Refresh observer (useful after dynamic content loads)
  refresh() {
    this.observer.disconnect();
    this.init();
  }

  // Cleanup
  destroy() {
    this.observer.disconnect();
  }
}

// Counter animation for statistics
class CounterAnimation {
  constructor(element) {
    this.element = element;
    this.target = parseInt(element.dataset.countTo) || 0;
    this.duration = parseInt(element.dataset.countDuration) || 2000;
    this.started = false;
  }

  start() {
    if (this.started) return;
    this.started = true;

    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (prefersReducedMotion) {
      this.element.textContent = this.target.toLocaleString();
      return;
    }

    const startTime = performance.now();
    const startValue = 0;

    const animate = (currentTime) => {
      const elapsed = currentTime - startTime;
      const progress = Math.min(elapsed / this.duration, 1);

      // Easing function (ease-out-quart)
      const easeOutQuart = 1 - Math.pow(1 - progress, 4);

      const currentValue = Math.floor(startValue + (this.target - startValue) * easeOutQuart);
      this.element.textContent = currentValue.toLocaleString();

      if (progress < 1) {
        requestAnimationFrame(animate);
      }
    };

    requestAnimationFrame(animate);
  }
}

// Parallax effect for background elements
class ParallaxEffect {
  constructor() {
    this.elements = document.querySelectorAll('[data-parallax]');
    this.prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (!this.prefersReducedMotion && this.elements.length > 0) {
      this.init();
    }
  }

  init() {
    window.addEventListener('scroll', () => this.onScroll(), { passive: true });
    this.onScroll(); // Initial position
  }

  onScroll() {
    const scrollY = window.pageYOffset;

    this.elements.forEach(element => {
      const speed = parseFloat(element.dataset.parallax) || 0.5;
      const yPos = -(scrollY * speed);
      element.style.transform = `translate3d(0, ${yPos}px, 0)`;
    });
  }
}

// Typing effect for hero text
class TypingEffect {
  constructor(element, options = {}) {
    this.element = element;
    this.texts = JSON.parse(element.dataset.typingTexts || '[]');
    this.typeSpeed = options.typeSpeed || 100;
    this.deleteSpeed = options.deleteSpeed || 50;
    this.pauseDuration = options.pauseDuration || 2000;
    this.currentIndex = 0;
    this.currentText = '';
    this.isDeleting = false;

    if (this.texts.length > 0) {
      this.type();
    }
  }

  type() {
    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (prefersReducedMotion) {
      // Just show first text without animation
      this.element.textContent = this.texts[0];
      return;
    }

    const fullText = this.texts[this.currentIndex];

    if (this.isDeleting) {
      this.currentText = fullText.substring(0, this.currentText.length - 1);
    } else {
      this.currentText = fullText.substring(0, this.currentText.length + 1);
    }

    this.element.textContent = this.currentText;

    let typeSpeed = this.isDeleting ? this.deleteSpeed : this.typeSpeed;

    if (!this.isDeleting && this.currentText === fullText) {
      typeSpeed = this.pauseDuration;
      this.isDeleting = true;
    } else if (this.isDeleting && this.currentText === '') {
      this.isDeleting = false;
      this.currentIndex = (this.currentIndex + 1) % this.texts.length;
      typeSpeed = 500;
    }

    setTimeout(() => this.type(), typeSpeed);
  }
}

// Initialize all scroll-based animations
document.addEventListener('DOMContentLoaded', () => {
  // Main scroll animations
  new ScrollAnimations();

  // Counter animations
  const counters = document.querySelectorAll('[data-count-to]');
  if (counters.length > 0) {
    const counterObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const counter = new CounterAnimation(entry.target);
          counter.start();
          counterObserver.unobserve(entry.target);
        }
      });
    }, { threshold: 0.5 });

    counters.forEach(counter => counterObserver.observe(counter));
  }

  // Parallax effect
  new ParallaxEffect();

  // Typing effect
  const typingElements = document.querySelectorAll('[data-typing-texts]');
  typingElements.forEach(element => new TypingEffect(element));
});

export { ScrollAnimations, CounterAnimation, ParallaxEffect, TypingEffect };
