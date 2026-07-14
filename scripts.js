/* ==========================================================================
   WordPress Campus Connect UVG 2026 — interacciones
   --------------------------------------------------------------------------
   Para WordPress: pega este contenido dentro de una etiqueta <script> al
   FINAL del segundo bloque "HTML personalizado" (despues del footer).
   ========================================================================== */

/* ---------- reveal on scroll ---------- */
(function () {
  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (e) {
      if (e.isIntersecting) {
        e.target.classList.add('is-visible');
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.15 });

  document.querySelectorAll('.reveal').forEach(function (el) { io.observe(el); });
})();

/* ---------- typing en la terminal del hero ---------- */
(function () {
  var line = document.getElementById('type-line');
  var result = document.getElementById('type-result');
  var terminal = document.querySelector('.terminal');
  if (!line || !terminal) return;

  var cmd = 'wp community create --campus=uvg --free';
  var i = 0;

  function type() {
    if (i <= cmd.length) {
      line.textContent = cmd.slice(0, i++);
      setTimeout(type, 45 + Math.random() * 60);
    } else if (result) {
      setTimeout(function () { result.style.display = 'block'; }, 350);
    }
  }

  var heroIO = new IntersectionObserver(function (entries) {
    entries.forEach(function (e) {
      if (e.isIntersecting) { type(); heroIO.disconnect(); }
    });
  });
  heroIO.observe(terminal);
})();
