// public/js/main.js

document.addEventListener("DOMContentLoaded", function () {
  // Swiper ініціалізація
  const swiper = new Swiper(".swiper-container", {
    loop: true,
    pagination: {
      el: ".swiper-pagination",
    },
    autoplay: {
      delay: 4000,
    },
  });

  // Тема: світла / темна
  const themeToggle = document.getElementById("theme-toggle");
  const html = document.documentElement;

  if (localStorage.getItem("theme") === "dark") {
    html.classList.add("dark-theme");
    themeToggle.checked = true;
  }

  themeToggle?.addEventListener("change", () => {
    html.classList.toggle("dark-theme");
    localStorage.setItem("theme", html.classList.contains("dark-theme") ? "dark" : "light");
  });

  // Анімація при скролі
  const animatedEls = document.querySelectorAll(".animate__animated");
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("animate__fadeInUp");
          entry.target.style.visibility = "visible";
        }
      });
    },
    { threshold: 0.1 }
  );

  animatedEls.forEach((el) => {
    el.style.visibility = "hidden";
    observer.observe(el);
  });

  // Перемикач мови
  const langSelect = document.getElementById("language-select");
  langSelect?.addEventListener("change", (e) => {
    const lang = e.target.value;
    window.location.href = `/${lang}${window.location.pathname}`;
  });
});

