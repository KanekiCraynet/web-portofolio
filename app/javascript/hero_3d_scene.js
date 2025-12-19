// Hero 3D Scene - Three.js implementation for portfolio hero section
// Uses floating geometric shapes with mouse interaction

import * as THREE from 'three';

class Hero3DScene {
  constructor(container) {
    this.container = container;
    this.mouseX = 0;
    this.mouseY = 0;
    this.targetMouseX = 0;
    this.targetMouseY = 0;

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
    this.camera.position.z = 5;

    this.renderer = new THREE.WebGLRenderer({
      antialias: true,
      alpha: true,
      powerPreference: 'high-performance'
    });
    this.renderer.setSize(width, height);
    this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    this.renderer.setClearColor(0x000000, 0);
    this.container.appendChild(this.renderer.domElement);
  }

  setupLights() {
    // Ambient light for base illumination
    const ambient = new THREE.AmbientLight(0xffffff, 0.4);
    this.scene.add(ambient);

    // Primary directional light (blue tint)
    const directional = new THREE.DirectionalLight(0x0066FF, 1.2);
    directional.position.set(5, 5, 5);
    this.scene.add(directional);

    // Secondary point light (teal accent)
    const point = new THREE.PointLight(0x00B4D8, 0.8);
    point.position.set(-5, -3, 3);
    this.scene.add(point);

    // Purple accent light
    const purple = new THREE.PointLight(0x7C3AED, 0.5);
    purple.position.set(3, -5, 2);
    this.scene.add(purple);
  }

  createObjects() {
    this.objects = [];

    // Primary cube - floating center piece
    const cubeGeo = new THREE.BoxGeometry(1.2, 1.2, 1.2);
    const cubeMat = new THREE.MeshStandardMaterial({
      color: 0x0066FF,
      metalness: 0.7,
      roughness: 0.2,
      emissive: 0x0066FF,
      emissiveIntensity: 0.1
    });
    this.cube = new THREE.Mesh(cubeGeo, cubeMat);
    this.cube.position.set(0, 0, 0);
    this.scene.add(this.cube);
    this.objects.push(this.cube);

    // Torus - orbiting ring
    const torusGeo = new THREE.TorusGeometry(2, 0.3, 16, 100);
    const torusMat = new THREE.MeshStandardMaterial({
      color: 0x00B4D8,
      metalness: 0.5,
      roughness: 0.3,
      transparent: true,
      opacity: 0.8
    });
    this.torus = new THREE.Mesh(torusGeo, torusMat);
    this.torus.rotation.x = Math.PI / 3;
    this.scene.add(this.torus);
    this.objects.push(this.torus);

    // Icosahedron - accent geometric shape
    const icoGeo = new THREE.IcosahedronGeometry(0.6, 0);
    const icoMat = new THREE.MeshStandardMaterial({
      color: 0x7C3AED,
      metalness: 0.6,
      roughness: 0.3,
      emissive: 0x7C3AED,
      emissiveIntensity: 0.15
    });
    this.icosahedron = new THREE.Mesh(icoGeo, icoMat);
    this.icosahedron.position.set(-2.5, 1.5, -1);
    this.scene.add(this.icosahedron);
    this.objects.push(this.icosahedron);

    // Octahedron - secondary accent
    const octaGeo = new THREE.OctahedronGeometry(0.5, 0);
    const octaMat = new THREE.MeshStandardMaterial({
      color: 0x00D9FF,
      metalness: 0.5,
      roughness: 0.4
    });
    this.octahedron = new THREE.Mesh(octaGeo, octaMat);
    this.octahedron.position.set(2.5, -1.5, -0.5);
    this.scene.add(this.octahedron);
    this.objects.push(this.octahedron);

    // Small spheres - floating particles
    this.particles = [];
    for (let i = 0; i < 8; i++) {
      const sphereGeo = new THREE.SphereGeometry(0.1, 16, 16);
      const sphereMat = new THREE.MeshStandardMaterial({
        color: i % 2 === 0 ? 0x0066FF : 0x00B4D8,
        metalness: 0.8,
        roughness: 0.2,
        emissive: i % 2 === 0 ? 0x0066FF : 0x00B4D8,
        emissiveIntensity: 0.3
      });
      const sphere = new THREE.Mesh(sphereGeo, sphereMat);
      sphere.position.set(
        (Math.random() - 0.5) * 6,
        (Math.random() - 0.5) * 4,
        (Math.random() - 0.5) * 3
      );
      sphere.userData = {
        originalY: sphere.position.y,
        speed: 0.5 + Math.random() * 0.5,
        offset: Math.random() * Math.PI * 2
      };
      this.scene.add(sphere);
      this.particles.push(sphere);
    }
  }

  setupResponsive() {
    window.addEventListener('resize', () => this.onWindowResize());
    this.container.addEventListener('mousemove', (e) => this.onMouseMove(e));
    this.container.addEventListener('mouseleave', () => this.onMouseLeave());
  }

  onWindowResize() {
    const width = this.container.clientWidth;
    const height = this.container.clientHeight;

    this.camera.aspect = width / height;
    this.camera.updateProjectionMatrix();
    this.renderer.setSize(width, height);
  }

  onMouseMove(event) {
    const rect = this.container.getBoundingClientRect();
    this.targetMouseX = ((event.clientX - rect.left) / rect.width) * 2 - 1;
    this.targetMouseY = -((event.clientY - rect.top) / rect.height) * 2 + 1;
  }

  onMouseLeave() {
    this.targetMouseX = 0;
    this.targetMouseY = 0;
  }

  animate() {
    requestAnimationFrame(() => this.animate());

    const time = Date.now() * 0.001;

    // Smooth mouse following
    this.mouseX += (this.targetMouseX - this.mouseX) * 0.05;
    this.mouseY += (this.targetMouseY - this.mouseY) * 0.05;

    // Cube rotation and floating
    this.cube.rotation.x += 0.003;
    this.cube.rotation.y += 0.005;
    this.cube.position.y = Math.sin(time * 0.8) * 0.3;
    this.cube.rotation.z = this.mouseX * 0.3;

    // Torus rotation
    this.torus.rotation.x += 0.002;
    this.torus.rotation.z += 0.004;

    // Icosahedron floating and rotation
    this.icosahedron.rotation.x += 0.004;
    this.icosahedron.rotation.y += 0.006;
    this.icosahedron.position.y = 1.5 + Math.sin(time * 1.2 + 1) * 0.2;

    // Octahedron floating and rotation
    this.octahedron.rotation.x -= 0.003;
    this.octahedron.rotation.z += 0.005;
    this.octahedron.position.y = -1.5 + Math.sin(time * 0.9 + 2) * 0.25;

    // Particles floating animation
    this.particles.forEach((particle) => {
      particle.position.y = particle.userData.originalY +
        Math.sin(time * particle.userData.speed + particle.userData.offset) * 0.3;
      particle.rotation.x += 0.01;
      particle.rotation.y += 0.01;
    });

    // Camera subtle movement based on mouse
    this.camera.position.x = this.mouseX * 0.5;
    this.camera.position.y = this.mouseY * 0.3;
    this.camera.lookAt(this.scene.position);

    this.renderer.render(this.scene, this.camera);
  }

  // Cleanup method
  destroy() {
    window.removeEventListener('resize', this.onWindowResize);
    this.renderer.dispose();
    this.objects.forEach(obj => {
      obj.geometry.dispose();
      obj.material.dispose();
    });
    this.particles.forEach(particle => {
      particle.geometry.dispose();
      particle.material.dispose();
    });
  }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('hero-3d');
  if (container) {
    // Check for WebGL support and reduced motion preference
    const canvas = document.createElement('canvas');
    const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (gl && !prefersReducedMotion) {
      new Hero3DScene(container);
    } else {
      // Fallback: show static gradient background
      container.classList.add('hero-3d-fallback');
    }
  }
});

export { Hero3DScene };
