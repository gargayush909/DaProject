// DOM elements
const nav = document.querySelector('nav');
const navToggle = document.querySelector('#nav-toggle');
const services = document.querySelectorAll('#services li');

// Toggle mobile menu
navToggle.addEventListener('click', () => {
  nav.classList.toggle('show');
});

// Smooth scroll to section
document.querySelectorAll('nav a').forEach((link) => {
  link.addEventListener('click', (e) => {
    e.preventDefault();

    const target = document.querySelector(link.getAttribute('href'));

    window.scrollTo({
      top: target.offsetTop,
      behavior: 'smooth'
    });
  });
});

// Animate on scroll
window.addEventListener('scroll', () => {
  const top = window.pageYOffset + window.innerHeight;

  services.forEach((service) => {
    if (top > service.offsetTop + service.offsetHeight / 2) {
      service.classList.add('show');
    } else {
      service.classList.remove('show');
    }
  });
});
