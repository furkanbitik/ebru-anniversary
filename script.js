// ============================================
// BİR AY — Ebru'ya
// Reveal on scroll + side-nav active state
// ============================================

(function () {
  "use strict";

  // ---------- Page loader: hold body locked, then fade ----------
  // The CSS draws the rose over ~1.8s; we give it a beat to settle (total ~2s)
  // then fade the overlay out. If the page is taking longer to load, we still
  // wait for the window 'load' event before starting the fade.
  document.body.classList.add("is-loading");

  const loader = document.getElementById("loader");

  function hideLoader() {
    if (!loader || loader.classList.contains("is-hidden")) return;
    loader.classList.add("is-hidden");
    document.body.classList.remove("is-loading");
    // remove from the DOM once the fade transition ends (clean accessibility tree)
    loader.addEventListener(
      "transitionend",
      () => loader.parentNode && loader.parentNode.removeChild(loader),
      { once: true }
    );
  }

  // Earliest-possible hide: window 'load' AND minimum 2s have both passed.
  let loadedFired = false;
  let minTimeElapsed = false;
  const tryHide = () => { if (loadedFired && minTimeElapsed) hideLoader(); };

  window.addEventListener("load", () => { loadedFired = true; tryHide(); });
  setTimeout(() => { minTimeElapsed = true; tryHide(); }, 2000);

  // Safety net: if 'load' never fires (e.g. a missing font CDN), bail at 4.5s
  setTimeout(hideLoader, 4500);

  // Respect reduced-motion: snap-hide immediately
  if (window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    setTimeout(hideLoader, 300);
  }

  // ---------- Reveal on scroll ----------
  const reveals = document.querySelectorAll(".reveal");

  if ("IntersectionObserver" in window) {
    const io = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("in-view");
            io.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.12, rootMargin: "0px 0px -60px 0px" }
    );
    reveals.forEach((el) => io.observe(el));
  } else {
    reveals.forEach((el) => el.classList.add("in-view"));
  }

  // ---------- Memory cards: staggered scroll-triggered fade-in ----------
  const memoryCards = document.querySelectorAll(".memories .card");
  if ("IntersectionObserver" in window && memoryCards.length) {
    const cardIo = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const idx = Array.prototype.indexOf.call(memoryCards, entry.target);
            // gentle stagger so each memory unfolds after the last
            entry.target.style.transitionDelay = (idx * 220) + "ms";
            entry.target.classList.add("in-view");
            cardIo.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.2, rootMargin: "0px 0px -40px 0px" }
    );
    memoryCards.forEach((c) => cardIo.observe(c));
  }

  // ---------- Side-nav active dot ----------
  const sections = document.querySelectorAll(".section");
  const dots = document.querySelectorAll(".side-nav .dot");

  if ("IntersectionObserver" in window && dots.length) {
    const navIo = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const id = entry.target.id;
            dots.forEach((d) => {
              d.classList.toggle("active", d.getAttribute("href") === "#" + id);
            });
          }
        });
      },
      { threshold: 0.5 }
    );
    sections.forEach((s) => navIo.observe(s));
  }

  // ---------- Graceful image fallback ----------
  // If a photo placeholder is missing, paint a soft burgundy gradient with a script monogram
  // so the layout still feels intentional before real photos are dropped in.
  document.querySelectorAll(".tile img").forEach((img) => {
    img.addEventListener("error", () => {
      const tile = img.closest(".tile");
      if (!tile) return;
      img.style.display = "none";
      if (tile.querySelector(".tile-placeholder")) return;
      const ph = document.createElement("div");
      ph.className = "tile-placeholder";
      ph.style.cssText = `
        position:absolute; inset:0;
        display:flex; align-items:center; justify-content:center;
        background:
          radial-gradient(ellipse at center, #6b1f33 0%, #2a0a12 100%);
        color:#d4af37;
        font-family:"Dancing Script", cursive;
        font-size:3.2rem;
        letter-spacing:0.05em;
      `;
      ph.textContent = "F & E";
      tile.prepend(ph);
    });
  });

  // ---------- Smooth scroll for nav dots (older browsers) ----------
  document.querySelectorAll('.side-nav a[href^="#"]').forEach((a) => {
    a.addEventListener("click", (e) => {
      const id = a.getAttribute("href");
      const target = document.querySelector(id);
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: "smooth", block: "start" });
      }
    });
  });

  // ---------- Subtle parallax on hero quote ----------
  const hero = document.getElementById("hero");
  const heroQuote = document.querySelector(".hero-quote");
  if (hero && heroQuote && !window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    window.addEventListener(
      "scroll",
      () => {
        const y = window.scrollY;
        if (y < window.innerHeight) {
          heroQuote.style.transform = `translateY(${y * 0.15}px)`;
          heroQuote.style.opacity = String(Math.max(0, 1 - y / (window.innerHeight * 0.7)));
        }
      },
      { passive: true }
    );
  }
})();
