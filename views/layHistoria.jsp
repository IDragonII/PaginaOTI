<%-- 
    Document   : layHistoria
    Rediseño: Timeline moderno de la historia OTI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- Historia Hero -->
<section class="historia-hero">
  <div class="container">
    <div class="historia-hero-content" data-aos="fade-up">
      <span class="historia-badge">Reseña Histórica</span>
      <h1>1999 — 2025</h1>
      <p>Más de dos décadas construyendo la infraestructura tecnológica de la UNA Puno</p>
    </div>
  </div>
</section>

<!-- Timeline Section -->
<section class="historia-timeline-section section-dark">
  <div class="container">
    <div class="row align-items-start">

      <!-- Timeline -->
      <div class="col-lg-7">
        <div class="historia-timeline">

          <!-- 1999: Inicios -->
          <div class="timeline-item" data-aos="fade-up">
            <div class="timeline-dot">
              <span class="timeline-year">1999</span>
            </div>
            <div class="timeline-card">
              <div class="timeline-card-header">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                <h3>Inicios de TI en la UNA</h3>
              </div>
              <p>El equipo de <strong>Desarrollo de Software y de Redes</strong> inició sus funciones en el Centro de Cómputo e Informática en el año 1999, sito en el edificio de la Facultad de Derecho en el último piso junto al profesor <strong>Cesar Rosales Maquera</strong> (actual Subdirector de Servicios de Certificación Digital en RENIEC) y alumnos destacados.</p>
              <p>Fruto del trabajo sin descanso 24x7, se desarrolló el <strong>primer sistema de matrículas</strong> para la UNA Puno que administraba los pagos de matrículas realizados en la Biblioteca Central y se revisaban en las diferentes facultades. La interconectividad se realizó sobre <strong>Novell Netware</strong>.</p>
            </div>
          </div>

          <!-- 2001: Fundación -->
          <div class="timeline-item" data-aos="fade-up" data-aos-delay="100">
            <div class="timeline-dot">
              <span class="timeline-year">2001</span>
            </div>
            <div class="timeline-card">
              <div class="timeline-card-header">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
                <h3>Fundación de OTI</h3>
              </div>
              <p>El <strong>29 de agosto de 2001</strong> se funda oficialmente el <strong>Centro de Tecnología Informática</strong>, teniendo como primer Jefe al ilustre Ingeniero Agrónomo <strong>Tiófilo Guilfredo Zegarra Martinez (QEPD)</strong>, quien trasladó amablemente al equipo de Desarrollo de Sistemas de Información que residía en el Centro de Cómputo de la Facultad de Derecho.</p>
              <p>Posteriormente el nombre se cambió a <strong>Oficina de Tecnologías de Información</strong>. Desde sus inicios la OTI ha brindado soporte en Redes y Sistemas de Información a toda la Universidad.</p>
            </div>
          </div>

          <!-- Autoridades -->
          <div class="timeline-item" data-aos="fade-up" data-aos-delay="200">
            <div class="timeline-dot dot-accent">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
            </div>
            <div class="timeline-card timeline-card-highlight">
              <p>Entre las autoridades que han dejado su legado, destacados profesionales han impulsado a <strong>OTI</strong> a lo largo de más de dos décadas de servicio a la universidad.</p>
            </div>
          </div>

        </div>
      </div>

      <!-- Imagen lateral -->
      <div class="col-lg-5">
        <div class="historia-image-wrapper" data-aos="fade-left" data-aos-delay="200">
          <img src="/assets/res/stone-1.jpg" alt="Placa conmemorativa OTI" class="historia-image">
          <div class="historia-image-caption">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
            Placa rompecabezas de Cuarzo del viejo pabellón de OTI
          </div>
        </div>
      </div>

    </div>
  </div>
</section>

<!-- Jefaturas Timeline Interactiva -->
<section class="historia-jefaturas-section section-dark">
  <div class="container">
    <div class="section-title" data-aos="fade-up">
      <h2>Jefaturas y Períodos</h2>
      <p>Líderes que han dirigido la OTI a lo largo de su historia</p>
    </div>

    <div class="jef-timeline-wrap" data-aos="fade-up" data-aos-delay="100">

      <!-- Barra de timeline -->
      <div class="jef-timeline-track">
        <div class="jef-timeline-line"></div>
        <div class="jef-timeline-progress" id="jefProgress"></div>

        <button class="jef-dot active" data-index="0">
          <span class="jef-dot-year">1999</span>
        </button>
        <button class="jef-dot" data-index="1">
          <span class="jef-dot-year">2007</span>
        </button>
        <button class="jef-dot" data-index="2">
          <span class="jef-dot-year">2008</span>
        </button>
        <button class="jef-dot" data-index="3">
          <span class="jef-dot-year">2015</span>
        </button>
        <button class="jef-dot" data-index="4">
          <span class="jef-dot-year">—</span>
        </button>
        <button class="jef-dot" data-index="5">
          <span class="jef-dot-year">—</span>
        </button>
        <button class="jef-dot" data-index="6">
          <span class="jef-dot-year">—</span>
        </button>
        <button class="jef-dot" data-index="7">
          <span class="jef-dot-year">—</span>
        </button>
        <button class="jef-dot" data-index="8">
          <span class="jef-dot-year">2020</span>
        </button>
        <button class="jef-dot" data-index="9">
          <span class="jef-dot-year">2023</span>
        </button>
        <button class="jef-dot" data-index="10">
          <span class="jef-dot-year">2024</span>
        </button>
      </div>

      <!-- Panel de detalle -->
      <div class="jef-detail-panel" id="jefPanel">
        <div class="jef-detail-inner" id="jefDetail">
          <!-- JS llena esto -->
        </div>
      </div>

      <!-- Flechas -->
      <div class="jef-nav">
        <button class="jef-nav-btn" id="jefPrev" aria-label="Anterior">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
        </button>
        <span class="jef-nav-label" id="jefLabel">1 de 11</span>
        <button class="jef-nav-btn" id="jefNext" aria-label="Siguiente">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
        </button>
      </div>

    </div>
  </div>
</section>

<script>
(function() {
  var data = [
    { year:'1999', name:'Tiófilo Guilfredo Zegarra Martinez', extra:'(QEPD)', role:'Ingeniero Agrónomo', current:false },
    { year:'2007', name:'Henry Ivan Condori Alejo', extra:'', role:'Doctor de Ingeniería de Sistemas · Ingeniero de Sistemas', current:false },
    { year:'2008', name:'Edelfre Flores Velasquez', extra:'', role:'Doctor de Ingeniería de Sistemas · Ingeniero de Sistemas', current:false },
    { year:'2015', name:'Robert Antonio Romero Flores', extra:'', role:'Ing. Sistemas UNA-Puno · Mag. Administración UNSAAC · Mag. Ing. Sistemas UANCV · Dr. Ing. Sistemas UNFV · Drto. Estadística e Informática UNA-Puno (E)', current:false },
    { year:'—', name:'Gavino Jose Flores Chipana', extra:'', role:'Ingeniero Electrónico', current:false },
    { year:'—', name:'Hugo Josef Gomez Quispe', extra:'', role:'Magister Scientia en Informática · Ingeniero de Sistemas', current:false },
    { year:'—', name:'Fredy Collanqui Martinez', extra:'', role:'Magister Scientia en Informática · Ingeniero de Sistemas', current:false },
    { year:'—', name:'Vilma Crist Palli Apaza', extra:'', role:'Ingeniero de Sistemas · Contador Público', current:false },
    { year:'2020', name:'Rene Leonidas Araujo Cotacallapa', extra:'', role:'Ingeniero de Sistemas · Magister Scientiae en Informática', current:false },
    { year:'2023', name:'Vladimir Ilich Ascue Lovón', extra:'', role:'Ingeniero Informático · Universidad Andina del Cusco UAC', current:false },
    { year:'2024', name:'Rudy Alvaro Arpasi Pancca', extra:'', role:'Ingeniero Estadístico e Informático · Doctor en Ciencias de la Computación', current:true }
  ];

  var dots = document.querySelectorAll('.jef-dot');
  var panel = document.getElementById('jefDetail');
  var progress = document.getElementById('jefProgress');
  var label = document.getElementById('jefLabel');
  var prevBtn = document.getElementById('jefPrev');
  var nextBtn = document.getElementById('jefNext');
  var current = 0;

  function render(i) {
    var d = data[i];
    var extraHtml = d.extra ? '<span class="jef-extra">' + d.extra + '</span>' : '';
    var currentBadge = d.current ? '<span class="jef-current-badge">Actual</span>' : '';
    panel.innerHTML =
      '<div class="jef-detail-year">' + d.year + '</div>' +
      '<h3 class="jef-detail-name">' + d.name + ' ' + extraHtml + ' ' + currentBadge + '</h3>' +
      '<p class="jef-detail-role">' + d.role + '</p>';

    dots.forEach(function(dot, idx) {
      dot.classList.toggle('active', idx === i);
      dot.classList.toggle('visited', idx < i);
    });

    var pct = (i / (dots.length - 1)) * 100;
    progress.style.width = pct + '%';

    label.textContent = (i + 1) + ' de ' + data.length;

    prevBtn.disabled = i === 0;
    nextBtn.disabled = i === data.length - 1;
  }

  dots.forEach(function(dot) {
    dot.addEventListener('click', function() {
      current = parseInt(this.dataset.index);
      render(current);
    });
  });

  prevBtn.addEventListener('click', function() {
    if (current > 0) { current--; render(current); }
  });

  nextBtn.addEventListener('click', function() {
    if (current < data.length - 1) { current++; render(current); }
  });

  render(0);
})();
</script>
