<%-- 
    Document   : Web panel
    Created on : 14 de mayo 2025
    Author     : Sr. Jose luis cari
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="jx" uri="http://example.com/jx" %>
<%@ page import="jxmvc.Jx" %>
<%@ page import="jxmvc.models.Actividad" %>
<%@ page import="jxmvc.models.Documento" %>
<%@ page import="jxmvc.models.PlanaDirectiva" %>
<%@ page import="jxmvc.models.Configuracion" %>
<%@ page import="jxmvc.models.Servicio" %>
<%@ page import="jxmvc.models.Unidad" %>
<%@ page import="java.util.List" %>
<%
    List<Actividad> actividadesDB = Actividad.getActivas();
    List<PlanaDirectiva> planaDirectivaDB = PlanaDirectiva.getAll();
    List<Servicio> serviciosDB = Servicio.getActivas();
    List<Unidad> unidadesDB = Unidad.getActivas();
    List<Documento> documentosDB = Documento.getActivos();

    // --- Pre-compute slide 1 ---
    String slide1Img = "";
    String slide1Alt = "Actividad OTI";
    String slide1Title = "Bienvenidos a la OTI";
    String slide1Rol = "Institucional";
    String slide1Desc = "Oficina de Tecnologias de la Informacion - UNA Puno";
    String slide1Link = request.getContextPath() + "/";
    if (actividadesDB.size() > 0) {
        for (Actividad a : actividadesDB) {
            if (a.activo) {
                if (a.imagenUrl != null && !a.imagenUrl.isEmpty()) slide1Img = a.imagenUrl;
                slide1Alt = a.titulo != null ? a.titulo : "";
                slide1Title = a.titulo != null ? a.titulo : "";
                slide1Rol = (a.tipo != null && !a.tipo.isEmpty()) ? a.tipo : "Actividad";
                slide1Desc = a.descripcion != null ? a.descripcion : "";
                slide1Link = (a.enlaceUrl != null && !a.enlaceUrl.isEmpty()) ? a.enlaceUrl : request.getContextPath() + "/";
                break;
            }
        }
    }

    // --- Pre-compute slide 2 ---
    String slide2Img = "";
    String slide2Alt = "Actividad OTI";
    boolean foundFirst = false;
    for (Actividad a : actividadesDB) {
        if (!a.activo) continue;
        if (!foundFirst) { foundFirst = true; continue; }
        if (a.imagenUrl != null && !a.imagenUrl.isEmpty()) slide2Img = a.imagenUrl;
        slide2Alt = a.titulo != null ? a.titulo : "";
        break;
    }

    // --- Pre-compute slide styles and image tags ---
    String slide1Style = slide1Img.isEmpty() ? "background: linear-gradient(135deg, #0891B2, #0E7490);" : "";
    String slide2Style = slide2Img.isEmpty() ? "background: linear-gradient(135deg, #0E7490, #0F766E);" : "";
    String slide1ImgTag = slide1Img.isEmpty() ? "" : "<img src=\"" + slide1Img + "\" alt=\"" + slide1Alt + "\">";
    String slide2ImgTag = slide2Img.isEmpty() ? "" : "<img src=\"" + slide2Img + "\" alt=\"" + slide2Alt + "\">";
    request.setAttribute("_slide1Style", slide1Style);
    request.setAttribute("_slide2Style", slide2Style);
    request.setAttribute("_slide1ImgTag", slide1ImgTag);
    request.setAttribute("_slide2ImgTag", slide2ImgTag);

    // --- Pre-compute JS actividades array ---
    StringBuilder actJS = new StringBuilder();
    boolean firstAct = true;
    for (Actividad a : actividadesDB) {
        if (!a.activo) continue;
        if (!firstAct) actJS.append(",");
        firstAct = false;
        actJS.append("{");
        actJS.append("titulo:\"").append(a.titulo != null ? a.titulo.replace("\"", "\\\"") : "").append("\",");
        actJS.append("rol:\"").append(a.tipo != null && !a.tipo.isEmpty() ? a.tipo.replace("\"", "\\\"") : "Actividad").append("\",");
        actJS.append("desc:\"").append(a.descripcion != null ? a.descripcion.replace("\"", "\\\"") : "").append("\",");
        actJS.append("img:\"").append(a.imagenUrl != null && !a.imagenUrl.isEmpty() ? a.imagenUrl : "").append("\",");
        actJS.append("link:\"").append(a.enlaceUrl != null && !a.enlaceUrl.isEmpty() ? a.enlaceUrl : request.getContextPath() + "/").append("\"");
        actJS.append("}");
    }

    // Store in request for EL access
    request.setAttribute("_slide1Img", slide1Img);
    request.setAttribute("_slide1Alt", slide1Alt);
    request.setAttribute("_slide1Title", slide1Title);
    request.setAttribute("_slide1Rol", slide1Rol);
    request.setAttribute("_slide1Desc", slide1Desc);
    request.setAttribute("_slide1Link", slide1Link);
    request.setAttribute("_slide2Img", slide2Img);
    request.setAttribute("_slide2Alt", slide2Alt);
    request.setAttribute("_actJS", actJS.toString());

    // --- Pre-compute team data as JS array for cylinder carousel ---
    StringBuilder teamJS = new StringBuilder();
    boolean firstMember = true;
    for (PlanaDirectiva p : planaDirectivaDB) {
        if (!p.activo) continue;
        if (!firstMember) teamJS.append(",");
        firstMember = false;
        String foto = (p.fotoUrl != null && !p.fotoUrl.isEmpty()) ? p.fotoUrl : "";
        String nombre = p.nombre != null ? p.nombre.replace("\"", "\\\"") : "";
        String cargo = p.cargo != null ? p.cargo.replace("\"", "\\\"") : "";
        String linkedin = (p.linkedinUrl != null && !p.linkedinUrl.isEmpty()) ? p.linkedinUrl : "";
        String twitter = (p.twitterUrl != null && !p.twitterUrl.isEmpty()) ? p.twitterUrl : "";
        teamJS.append("{");
        teamJS.append("foto:\"").append(foto).append("\",");
        teamJS.append("nombre:\"").append(nombre).append("\",");
        teamJS.append("cargo:\"").append(cargo).append("\",");
        teamJS.append("linkedin:\"").append(linkedin).append("\",");
        teamJS.append("twitter:\"").append(twitter).append("\"");
        teamJS.append("}");
    }
    request.setAttribute("_teamJS", teamJS.toString());

    // --- Pre-compute services data as JS array for wheel carousel ---
    StringBuilder svcJS = new StringBuilder();
    boolean firstSvc = true;
    for (Servicio svc : serviciosDB) {
        if (!firstSvc) svcJS.append(",");
        firstSvc = false;
        String img = (svc.imagenUrl != null && !svc.imagenUrl.isEmpty()) ? svc.imagenUrl : "";
        String titulo = svc.titulo != null ? svc.titulo.replace("\"", "\\\"") : "";
        String desc = svc.descripcion != null ? svc.descripcion.replace("\"", "\\\"") : "";
        String enlace = (svc.enlaceUrl != null && !svc.enlaceUrl.isEmpty()) ? svc.enlaceUrl : "#";
        svcJS.append("{");
        svcJS.append("img:\"").append(img).append("\",");
        svcJS.append("titulo:\"").append(titulo).append("\",");
        svcJS.append("desc:\"").append(desc).append("\",");
        svcJS.append("enlace:\"").append(enlace).append("\"");
        svcJS.append("}");
    }
    request.setAttribute("_svcJS", svcJS.toString());
    request.setAttribute("unidadesDB", unidadesDB);
    request.setAttribute("documentosDB", documentosDB);

    String userAgent = request.getHeader("User-Agent");
    boolean IsMobile = false;

    if (userAgent != null)
    {
        userAgent = userAgent.toLowerCase();
        IsMobile = (userAgent.contains("mobile") ||
                   userAgent.contains("android") ||
                   userAgent.contains("iphone") ||
                   userAgent.contains("ipad") ||
                   userAgent.contains("windows phone") ||
                   userAgent.contains("iemobile"));
    }
%>

<%!
    // esto es para variables globales
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title> <%= Configuracion.getValue("site_title", "OTI - UNA Puno") %> </title>
  <meta name="description" content="">
  <meta name="keywords" content="">

  <!-- Favicons -->
  <link href="<%= Configuracion.getValue("site_favicon", "https://oti.unap.edu.pe/recursos/oti-icon.png") %>" rel="icon">
  <link href="<%= Configuracion.getValue("site_favicon", "https://oti.unap.edu.pe/recursos/oti-icon.png") %>" rel="apple-touch-icon">

  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700;800&family=Raleway:wght@400;500;600;700&display=swap" rel="stylesheet">

  <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  
  <link href="/assets/css/main.css?t=2" rel="stylesheet">
  <link href="/assets/css/menu.css?t=2" rel="stylesheet">
  
  <!-- <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.7.2/css/all.css">  -->
</head>


<body class="index-page">

  <header id="header" class="header d-flex align-items-center fixed-top">
    <div class="container position-relative d-flex align-items-center justify-content-between">

      <a href="/" class="logo d-flex align-items-center me-auto me-xl-0">
        <img src="<%= Configuracion.getValue("site_logo", "https://oti.unap.edu.pe/recursos/oti-ofic.png") %>" alt="Ir al inicio" style="max-height: 40px;">
      </a>
      
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMenu" aria-label="Menú">
                <span class="navbar-toggler-icon" style="background-image: url(&quot;data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='%230891B2' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e&quot;);"></span>
            </button>            
            <!--
            <img src="<%= Configuracion.getValue("site_logo", "https://oti.unap.edu.pe/recursos/oti-ofic.png") %>" height=32 alt="">
            -->

            <div class="collapse navbar-collapse" id="navbarMenu">
                <ul class="navbar-nav me-auto">
                
                    <!-- Elementos NO desplegables -->
                    <li class="nav-item">
                        <a class="nav-link" href="/">
                            Inicio
                        </a>
                    </li>
                
                    <!-- Elementos NO desplegables -->
                    <li class="nav-item">
                        <a class="nav-link" href="/unidades.jsp">
                            Unidades
                        </a>
                    </li>

                    <!-- Elementos NO desplegables -->
                    <li class="nav-item">
                        <a class="nav-link" href="/!/historia-oti">
                            Reseña Histórica
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="http://cursosoti.unap.edu.pe">
                            Cursos
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="/documentacion.jsp">
                            Documentacion
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        
    </nav>

      <!--
      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="#hero" class="active">Home</a></li>
          <li><a href="#about">About</a></li>
          <li><a href="#services">Services</a></li>
          <li><a href="#team">Team</a></li>
          <li class="dropdown"><a href="#"><span>Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
            <ul>
              <li><a href="#">Dropdown 1</a></li>
              <li class="dropdown"><a href="#"><span>Deep Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                <ul>
                  <li><a href="#">Deep Dropdown 1</a></li>
                  <li><a href="#">Deep Dropdown 2</a></li>
                </ul>
              </li>
              <li><a href="#">Dropdown 2</a></li>
              <li><a href="#">Dropdown 3</a></li>
            </ul>
          </li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>
      -->

      <!-- con Jx falla con vars locales -->
      <% if( ! IsMobile ) { %>
        <a class="btn-getstarted" href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#dlgAviso" style="background: linear-gradient(135deg, #0891B2, #06B6D4); color: white; font-size: 13px; padding: 8px 20px; border-radius: 8px; font-weight: 600; text-decoration: none; transition: all 0.3s; box-shadow: 0 4px 15px rgba(8, 145, 178, 0.25);"> 
          FirmaUNA 
        </a>
      <% } %> 
      


    </div>
  </header>

  <main class="main">
      
    <!-- Layered web page, don't need send args all of them are in 'request' -->
    <jx:if test="${IsLayerFile}">
    
        <section class="section" style="padding-top: 200px; background: white">
            <div class="container" data-aos="fade-up" data-aos-delay="100">

                <jsp:include page="/views/${ChildLayer}.jsp" />
                
            </div>
        </section>
    
    </jx:if>
        
    <!-- web page by default -->
    <jx:if test="${ ! IsLayerFile}">

    <!-- Hero Section -->
    <section id="hero" class="hero section">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row align-items-center mb-5">
          <div class="col-lg-6 mb-4 mb-lg-0">
            <div class="badge-wrapper mb-3">
              <div class="d-inline-flex align-items-center rounded-pill" style="padding: 8px 20px; background: linear-gradient(135deg, rgba(8, 145, 178, 0.1), rgba(34, 211, 238, 0.1)); border: 1px solid rgba(8, 145, 178, 0.2); backdrop-filter: blur(10px);">
                <div style="height: 28px; width: 28px; border-radius: 50%; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 10px;">
                   <img src="assets/img/unap.png" width="18" style="filter: brightness(0) invert(1);">
                </div>
                <span style="font-size: 0.85rem; font-weight: 600; color: #0891B2; letter-spacing: 0.5px;"> <%= Configuracion.getValue("hero_subtitle", "UNIVERSIDAD NACIONAL DEL ALTIPLANO") %> </span>
              </div>
            </div>

            <h1 class="hero-title mb-4" style="background: linear-gradient(135deg, #0891B2, #06B6D4); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
              <%= Configuracion.getValue("hero_title", "OTI - UNA Puno") %>
            </h1>

            <p class="hero-description mb-4">
              <%= Configuracion.getValue("hero_description", "Más de 24 años desarrollando soluciones informáticas y de telecomunicaciones para la comunidad universitaria. Impulsados por la Transformación Digital.") %>
            </p>
          </div>
          
            



          <div class="col-lg-6">
            <div class="hero-image" style="position: relative;">
              <div style="position: absolute; top: -30px; right: -30px; width: 250px; height: 250px; background: radial-gradient(circle, rgba(34, 211, 238, 0.15) 0%, transparent 70%); border-radius: 50%; pointer-events: none;"></div>
              <div style="position: absolute; bottom: -20px; left: -20px; width: 180px; height: 180px; background: radial-gradient(circle, rgba(8, 145, 178, 0.1) 0%, transparent 70%); border-radius: 50%; pointer-events: none;"></div>
              <div id="heroMediaContainer" style="position: relative; background: linear-gradient(135deg, rgba(8, 145, 178, 0.05), rgba(34, 211, 238, 0.05)); border-radius: 24px; padding: 20px; border: 1px solid rgba(224, 242, 254, 0.6);">
                <img id="heroImage" src="<%= Configuracion.getValue("hero_image", "/assets/res/oti-1.jpg") %>" style="width: 100%; border-radius: 16px; box-shadow: 0 25px 60px rgba(8, 145, 178, 0.2); transition: opacity 0.5s;" alt="OTI UNAP" loading="lazy">
                <iframe id="heroVideo" src="" allowfullscreen style="position: absolute; top: 20px; left: 20px; width: calc(100% - 40px); height: calc(100% - 40px); border: none; border-radius: 16px; box-shadow: 0 25px 60px rgba(8, 145, 178, 0.2); display: none;"></iframe>
              </div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Hero Section -->

    <!-- Nuestras Actividades - Overlap Carousel -->
    <section id="notis" class="section" style="background: linear-gradient(135deg, #F0F9FF 0%, #E0F2FE 50%, #F0FDFA 100%);">
      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="oti-overlap-wrap">
          <div class="oti-overlap-stage" id="otiStage">

            <!-- Slide 1 (dynamic from DB) -->
            <div class="oti-overlap-slide active" id="otiSlide0" data-style="${_slide1Style}">
              ${_slide1ImgTag}
            </div>
            <!-- Slide 2 (dynamic from DB) -->
            <div class="oti-overlap-slide" id="otiSlide1" data-style="${_slide2Style}">
              ${_slide2ImgTag}
            </div>

            <!-- Card oscuro -->
            <div class="oti-overlap-card" id="otiCard">
              <span class="oti-overlap-label">Conoce lo que hacemos</span>
              <h3 class="oti-overlap-card-title" id="otiTitle">${_slide1Title}</h3>
              <p class="oti-overlap-card-role" id="otiRole">${_slide1Rol}</p>
              <p class="oti-overlap-card-desc" id="otiDesc">${_slide1Desc}</p>
              <a href="${_slide1Link}" class="oti-overlap-card-link" id="otiLink">
                <span>Ver mas</span>
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
              </a>
            </div>

            <!-- Flechas -->
            <button class="oti-overlap-arrow prev" id="otiPrev">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
            </button>
            <button class="oti-overlap-arrow next" id="otiNext">
              <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
            </button>

          </div>

          <!-- Dots -->
          <div class="oti-overlap-dots" id="otiDots"></div>
        </div>

      </div>
    </section>

    <script>
    (function() {
      document.querySelectorAll('[data-style]').forEach(function(el) {
        var s = el.getAttribute('data-style');
        if (s) el.style.cssText = s;
      });
      var actividades = [${_actJS}];

      if (actividades.length === 0) {
        actividades = [{
          titulo: "Bienvenidos a la OTI",
          rol: "Institucional",
          desc: "Oficina de Tecnologias de la Informacion - UNA Puno",
          img: "",
          link: "${pageContext.request.contextPath}/"
        }];
      }

      var current = 0;
      var slides = [];
      var dots = [];
      var stage = document.getElementById("otiStage");
      var title = document.getElementById("otiTitle");
      var role = document.getElementById("otiRole");
      var desc = document.getElementById("otiDesc");
      var link = document.getElementById("otiLink");
      var dotsContainer = document.getElementById("otiDots");

      // Crear slides y dots
      actividades.forEach(function(s, i) {
        // Crear slide dinamico si hay mas de 2
        if (i >= 2) {
          var slideDiv = document.createElement("div");
          slideDiv.className = "oti-overlap-slide";
          slideDiv.id = "otiSlide" + i;
          if (s.img) {
            slideDiv.innerHTML = '<img src="' + s.img + '" alt="' + s.titulo + '">';
          } else {
            slideDiv.style.background = "linear-gradient(135deg, #0891B2, #0E7490)";
          }
          document.getElementById("otiStage").appendChild(slideDiv);
        }
        slides.push(document.getElementById("otiSlide" + i));

        // Dot
        var dot = document.createElement("button");
        dot.className = "oti-overlap-dot" + (i === 0 ? " active" : "");
        dot.addEventListener("click", function() { activar(i); });
        dotsContainer.appendChild(dot);
        dots.push(dot);
      });

      function activar(index) {
        slides[current].classList.remove("active");
        dots[current].classList.remove("active");

        current = index;

        slides[current].classList.add("active");
        dots[current].classList.add("active");

        // Intercambiar posiciones: par = normal, impar = invertido
        stage.classList.toggle("dir-swapped", current % 2 !== 0);

        // Reiniciar animaciones del card
        var label = document.querySelector(".oti-overlap-label");
        [label, title, role, desc, link].forEach(function(el) {
          el.style.animation = "none";
          void el.offsetWidth;
          el.style.animation = null;
        });

        var s = actividades[current];
        title.textContent = s.titulo;
        role.textContent = s.rol;
        desc.textContent = s.desc;
        link.href = s.link;
      }

      // Flechas
      document.getElementById("otiPrev").addEventListener("click", function() {
        activar((current - 1 + actividades.length) % actividades.length);
      });
      document.getElementById("otiNext").addEventListener("click", function() {
        activar((current + 1) % actividades.length);
      });

      // Swipe tactil para mobile
      var touchStartX = 0;
      var touchStartY = 0;
      var swiping = false;

      stage.addEventListener("touchstart", function(e) {
        touchStartX = e.touches[0].clientX;
        touchStartY = e.touches[0].clientY;
        swiping = true;
      }, { passive: true });

      stage.addEventListener("touchmove", function(e) {
        if (!swiping) return;
        var dx = e.touches[0].clientX - touchStartX;
        var dy = e.touches[0].clientY - touchStartY;
        if (Math.abs(dx) > Math.abs(dy)) {
          e.preventDefault();
        }
      }, { passive: false });

      stage.addEventListener("touchend", function(e) {
        if (!swiping) return;
        swiping = false;
        var dx = e.changedTouches[0].clientX - touchStartX;
        var threshold = 50;
        if (dx < -threshold) {
          activar((current + 1) % actividades.length);
        } else if (dx > threshold) {
          activar((current - 1 + actividades.length) % actividades.length);
        }
      });

      // Auto-rotacion cada 5 segundos
      setInterval(function() {
        activar((current + 1) % actividades.length);
      }, 5000);
    })();
    </script>

    

    
    
    <!-- Services Alt Section -->
    

    <section id="servs" class="services-alt section" style="background: linear-gradient(180deg, #F8FAFF 0%, #F0F9FF 100%);">

      <div class="container" data-aos="fade-up" data-aos-delay="100">

        <div class="row align-items-start">
          <!-- Izquierda: Titulo + Card Tramitar solicitud -->
          <div class="col-lg-5" data-aos="fade-up" data-aos-delay="100">
            <div style="display: inline-flex; align-items: center; gap: 8px; padding: 6px 14px; background: rgba(8, 145, 178, 0.08); border-radius: 8px; margin-bottom: 16px;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#0891B2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
              <span style="font-size: 0.8rem; font-weight: 600; color: #0891B2; text-transform: uppercase; letter-spacing: 1px;"> Gestión de Tecnologías de la Información </span>
            </div>
            <h2 style="font-size: 2.25rem; font-weight: 800; margin-bottom: 20px; line-height: 1.2; color: #0F172A;"> Servicios </h2>
            <p style="color: #64748B; line-height: 1.8; font-size: 1rem; margin-bottom: 28px;">
              Accede a los servicios digitales diseñados para la comunidad universitaria de la UNA Puno.
            </p>

            <div style="background: linear-gradient(135deg, #0891B2, #06B6D4); border-radius: 20px; padding: 32px; color: white; box-shadow: 0 20px 50px rgba(8, 145, 178, 0.3);">
              <div style="width: 64px; height: 64px; border-radius: 16px; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; margin-bottom: 20px;">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
              </div>
              <h3 style="font-size: 1.5rem; font-weight: 800; margin-bottom: 12px;">Tramitar Solicitud</h3>
              <p style="opacity: 0.9; font-size: 0.95rem; line-height: 1.7; margin-bottom: 24px;">
                Realiza tu solicitud de soporte técnico, correo institucional, firma digital y otros trámites de forma rápida y efectiva.
              </p>
              <a href="solicitud.jsp" style="display: inline-flex; align-items: center; gap: 8px; background: white; color: #0891B2; padding: 12px 24px; border-radius: 10px; font-weight: 700; font-size: 0.95rem; text-decoration: none; transition: all 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.1);"
                 onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 8px 25px rgba(0,0,0,0.15)'"
                 onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 15px rgba(0,0,0,0.1)'">
                Ir a solicitud
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
              </a>
            </div>
          </div>

          <!-- Derecha: Carrusel vertical tipo rueda 3D -->
          <div class="col-lg-7 d-flex align-items-center" data-aos="fade-up" data-aos-delay="200">
            <div class="svc-wheel-wrap" id="svcWheelWrap">
              <div class="svc-wheel" id="svcWheel"></div>
              <button class="svc-wheel-arrow up" id="svcUp">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="18 15 12 9 6 15"></polyline></svg>
              </button>
              <button class="svc-wheel-arrow down" id="svcDown">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
              </button>
              <div class="svc-wheel-dots" id="svcDots"></div>
            </div>
          </div>
        </div>

      </div>

    </section><!-- /Services Alt Section -->

    
    <!-- /Faq Section -->

    <!-- Team Section -->
    <section id="team" class="team section" style="background: linear-gradient(180deg, #F0F9FF 0%, #F8FAFF 100%);">

      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <h2> Plana Directiva OTI </h2>
      </div>

      <!-- Cylinder 3D Carousel -->
      <div class="container" data-aos="fade-up" data-aos-delay="100">
        <div class="oti-cylinder-wrap" id="cylinderWrap">
          <div class="oti-cylinder" id="cylinder"></div>

          <!-- Flechas -->
          <button class="oti-cylinder-arrow prev" id="cylPrev">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
          </button>
          <button class="oti-cylinder-arrow next" id="cylNext">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
          </button>
        </div>

        <!-- Dots -->
        <div class="oti-cylinder-dots" id="cylDots"></div>
      </div>

      <!-- Overlay de imagen ampliada -->
      <div class="oti-cylinder-overlay" id="cylOverlay">
        <button class="oti-cylinder-overlay-close" id="cylOverlayClose">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
        </button>
        <img id="cylOverlayImg" src="" alt="">
      </div>

    </section><!-- /Team Section -->

<!-- Cylinder 3D Carousel - Plana Directiva -->
    <script>
    (function() {
      var members = [${_teamJS}];
      if (members.length === 0) return;

      var wrap = document.getElementById("cylinderWrap");
      var cylinder = document.getElementById("cylinder");
      var dotsContainer = document.getElementById("cylDots");
      var overlay = document.getElementById("cylOverlay");
      var overlayImg = document.getElementById("cylOverlayImg");
      var overlayClose = document.getElementById("cylOverlayClose");

      var faceCount = members.length;
      var currentIndex = 0;
      var faceWidth = 260;
      var isDragging = false;
      var startX = 0;
      var startRotation = 0;
      var autoPlayTimer = null;

      function updateFaces() {
        var faces = cylinder.querySelectorAll(".oti-cylinder-face");
        faces.forEach(function(face, i) {
          var diff = i - currentIndex;
          var n = faceCount;
          var half = Math.floor(n / 2);
          if (diff > half) diff -= n;
          if (diff < -half) diff += n;
          var absDiff = Math.abs(diff);
          face.classList.remove("face-center", "face-near", "face-far", "face-hidden");
          var tx = diff * (faceWidth + 30);
          var rotY = diff * 20;
          var tz = absDiff === 0 ? 0 : -absDiff * 80;
          var sc = absDiff === 0 ? 1 : absDiff === 1 ? 0.85 : absDiff === 2 ? 0.7 : 0.55;
          var op = absDiff === 0 ? 1 : absDiff === 1 ? 0.95 : absDiff === 2 ? 0.7 : 0;
          var zi = absDiff === 0 ? 5 : absDiff === 1 ? 4 : absDiff === 2 ? 3 : 1;
          if (absDiff === 0) face.classList.add("face-center");
          else if (absDiff === 1) face.classList.add("face-near");
          else if (absDiff === 2) face.classList.add("face-far");
          else face.classList.add("face-hidden");
          face.style.transform = "translateY(-50%) translateX(" + tx + "px) translateZ(" + tz + "px) rotateY(" + rotY + "deg) scale(" + sc + ")";
          face.style.zIndex = zi;
          face.style.opacity = op;
        });
        var dots = dotsContainer.querySelectorAll(".oti-cylinder-dot");
        dots.forEach(function(dot, i) { dot.classList.toggle("active", i === currentIndex); });
      }

      function rotateTo(index) {
        currentIndex = ((index % faceCount) + faceCount) % faceCount;
        updateFaces();
      }

      function computeFaceWidth() {
        var w = wrap.clientWidth;
        if (w <= 480) faceWidth = 140;
        else if (w <= 768) faceWidth = 180;
        else faceWidth = 280;
        var faces = cylinder.querySelectorAll(".oti-cylinder-face");
        faces.forEach(function(f) { f.style.width = faceWidth + "px"; f.style.marginLeft = "-" + (faceWidth / 2) + "px"; });
      }

      function computeWrapHeight() {
        var maxH = 0;
        var faces = cylinder.querySelectorAll(".oti-cylinder-face");
        faces.forEach(function(f) { if (f.offsetHeight > maxH) maxH = f.offsetHeight; });
        if (maxH > 0) wrap.style.height = (maxH + 40) + "px";
      }

      function init() {
        computeFaceWidth();
        cylinder.innerHTML = "";
        var imagesLoaded = 0;
        var totalImages = members.filter(function(m) { return m.foto; }).length;

        members.forEach(function(m, i) {
          var face = document.createElement("div");
          face.className = "oti-cylinder-face";
          face.style.width = faceWidth + "px";
          face.style.marginLeft = "-" + (faceWidth / 2) + "px";

          var imgWrap = document.createElement("div");
          imgWrap.className = "oti-cylinder-face-img";

          if (m.foto) {
            var img = document.createElement("img");
            img.src = m.foto; img.alt = m.nombre; img.draggable = false;
            img.onload = function() {
              imagesLoaded++;
              if (imagesLoaded === totalImages) computeWrapHeight();
            };
            img.onerror = function() {
              imagesLoaded++;
              if (imagesLoaded === totalImages) computeWrapHeight();
            };
            imgWrap.appendChild(img);
          } else {
            var initials = m.nombre ? m.nombre.charAt(0).toUpperCase() : "?";
            imgWrap.style.background = "linear-gradient(135deg, rgba(8,145,178,0.15), rgba(34,211,238,0.15))";
            imgWrap.style.display = "flex"; imgWrap.style.alignItems = "center"; imgWrap.style.justifyContent = "center";
            imgWrap.style.fontSize = "2rem"; imgWrap.style.fontWeight = "700"; imgWrap.style.color = "#0891B2";
            imgWrap.textContent = initials;
          }
          face.appendChild(imgWrap);

          var info = document.createElement("div");
          info.className = "oti-cylinder-face-info";
          info.innerHTML = '<div class="oti-cylinder-face-name">' + (m.nombre || "") + '</div>' +
                           '<div class="oti-cylinder-face-role">' + (m.cargo || "") + '</div>';
          face.appendChild(info);

          face.addEventListener("click", function() {
            if (m.foto) { overlayImg.src = m.foto; overlayImg.alt = m.nombre; overlay.classList.add("visible"); }
          });
          cylinder.appendChild(face);
        });
        if (totalImages === 0) computeWrapHeight();
        dotsContainer.innerHTML = "";
        members.forEach(function(_, i) {
          var dot = document.createElement("button");
          dot.className = "oti-cylinder-dot" + (i === 0 ? " active" : "");
          dot.addEventListener("click", function() { rotateTo(i); resetAutoPlay(); });
          dotsContainer.appendChild(dot);
        });
        rotateTo(0);
        startAutoPlay();
      }

      function onDragStart(e) { isDragging = true; startX = e.type.includes("mouse") ? e.clientX : e.touches[0].clientX; startRotation = currentIndex; cylinder.classList.add("dragging"); stopAutoPlay(); }
      function onDragMove(e) { if (!isDragging) return; e.preventDefault(); var x = e.type.includes("mouse") ? e.clientX : e.touches[0].clientX; var dx = x - startX; var step = faceWidth + 24; var indexShift = Math.round(-dx / step); var target = ((startRotation + indexShift) % faceCount + faceCount) % faceCount; if (target !== currentIndex) { currentIndex = target; updateFaces(); } }
      function onDragEnd(e) { if (!isDragging) return; isDragging = false; cylinder.classList.remove("dragging"); updateFaces(); startAutoPlay(); }

      wrap.addEventListener("mousedown", onDragStart);
      document.addEventListener("mousemove", onDragMove);
      document.addEventListener("mouseup", onDragEnd);
      wrap.addEventListener("touchstart", onDragStart, { passive: true });
      wrap.addEventListener("touchmove", onDragMove, { passive: false });
      wrap.addEventListener("touchend", onDragEnd);

      document.getElementById("cylPrev").addEventListener("click", function() { rotateTo(currentIndex - 1); resetAutoPlay(); });
      document.getElementById("cylNext").addEventListener("click", function() { rotateTo(currentIndex + 1); resetAutoPlay(); });
      overlayClose.addEventListener("click", function() { overlay.classList.remove("visible"); });
      overlay.addEventListener("click", function(e) { if (e.target === overlay) overlay.classList.remove("visible"); });

      function startAutoPlay() { stopAutoPlay(); autoPlayTimer = setInterval(function() { rotateTo(currentIndex + 1); }, 4000); }
      function stopAutoPlay() { if (autoPlayTimer) { clearInterval(autoPlayTimer); autoPlayTimer = null; } }
      function resetAutoPlay() { stopAutoPlay(); startAutoPlay(); }

      window.addEventListener("resize", function() { computeFaceWidth(); computeWrapHeight(); updateFaces(); });
      init();
    })();
    </script>

    </jx:if>
    
  </main>

  <footer id="footer" class="footer" style="background: linear-gradient(180deg, #0F172A 0%, #1E293B 100%);">

    <div class="container footer-top">
      <div class="row gy-4">
        <div class="col-lg-4 col-md-6 footer-about">
          <a href="/" class="logo d-flex align-items-center" style="text-decoration: none;">
            <span style="color: #F8FAFF; font-family: var(--heading-font); font-size: 24px; font-weight: 700; letter-spacing: 1px;">Portal OTI</span>
          </a>
          <div class="footer-contact pt-3">
            <p style="color: #94A3B8; margin-bottom: 4px;"><%= Configuracion.getValue("contact_address", "Ciudad Universitaria") %></p>
            <p style="color: #94A3B8; margin-bottom: 4px;"><%= Configuracion.getValue("contact_address_2", "Av. Floral S/N") %></p>
            <% String _ce = Configuracion.getValue("contact_email", ""); if (!_ce.isEmpty()) { %><p style="color: #94A3B8; margin-bottom: 4px;"><a href="mailto:<%= _ce %>" style="color: #94A3B8; text-decoration: none;"><%= _ce %></a></p><% } %>
            <% String _cp = Configuracion.getValue("contact_phone", ""); if (!_cp.isEmpty()) { %><p style="color: #94A3B8; margin-bottom: 4px;"><%= _cp %></p><% } %>
            <% String _ch = Configuracion.getValue("contact_hours", ""); if (!_ch.isEmpty()) { %><p style="color: #94A3B8; margin-bottom: 4px;"><%= _ch %></p><% } %>
          </div>
          <div class="social-links d-flex mt-4">
            <% String _tw = Configuracion.getValue("social_twitter", ""); if (!_tw.isEmpty()) { %>
            <a href="<%= _tw %>" aria-label="Twitter" target="_blank" style="width: 40px; height: 40px; border-radius: 50%; border: 1px solid rgba(148, 163, 184, 0.3); display: flex; align-items: center; justify-content: center; color: #94A3B8; margin-right: 10px; transition: 0.3s; text-decoration: none;" onmouseover="this.style.color='#22D3EE'; this.style.borderColor='#22D3EE'; this.style.background='rgba(34, 211, 238, 0.1)'" onmouseout="this.style.color='#94A3B8'; this.style.borderColor='rgba(148, 163, 184, 0.3)'; this.style.background='transparent'"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z"></path></svg></a>
            <% } %>
            <% String _fb = Configuracion.getValue("social_facebook", ""); if (!_fb.isEmpty()) { %>
            <a href="<%= _fb %>" aria-label="Facebook" target="_blank" style="width: 40px; height: 40px; border-radius: 50%; border: 1px solid rgba(148, 163, 184, 0.3); display: flex; align-items: center; justify-content: center; color: #94A3B8; margin-right: 10px; transition: 0.3s; text-decoration: none;" onmouseover="this.style.color='#22D3EE'; this.style.borderColor='#22D3EE'; this.style.background='rgba(34, 211, 238, 0.1)'" onmouseout="this.style.color='#94A3B8'; this.style.borderColor='rgba(148, 163, 184, 0.3)'; this.style.background='transparent'"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path></svg></a>
            <% } %>
            <% String _ig = Configuracion.getValue("social_instagram", ""); if (!_ig.isEmpty()) { %>
            <a href="<%= _ig %>" aria-label="Instagram" target="_blank" style="width: 40px; height: 40px; border-radius: 50%; border: 1px solid rgba(148, 163, 184, 0.3); display: flex; align-items: center; justify-content: center; color: #94A3B8; margin-right: 10px; transition: 0.3s; text-decoration: none;" onmouseover="this.style.color='#22D3EE'; this.style.borderColor='#22D3EE'; this.style.background='rgba(34, 211, 238, 0.1)'" onmouseout="this.style.color='#94A3B8'; this.style.borderColor='rgba(148, 163, 184, 0.3)'; this.style.background='transparent'"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg></a>
            <% } %>
            <% String _li = Configuracion.getValue("social_linkedin", ""); if (!_li.isEmpty()) { %>
            <a href="<%= _li %>" aria-label="LinkedIn" target="_blank" style="width: 40px; height: 40px; border-radius: 50%; border: 1px solid rgba(148, 163, 184, 0.3); display: flex; align-items: center; justify-content: center; color: #94A3B8; margin-right: 10px; transition: 0.3s; text-decoration: none;" onmouseover="this.style.color='#22D3EE'; this.style.borderColor='#22D3EE'; this.style.background='rgba(34, 211, 238, 0.1)'" onmouseout="this.style.color='#94A3B8'; this.style.borderColor='rgba(148, 163, 184, 0.3)'; this.style.background='transparent'"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg></a>
            <% } %>
          </div>
        </div>

        <div class="col-lg-2 col-md-3 footer-links">
          <h4 style="color: #F8FAFF; font-size: 16px; font-weight: 600; position: relative; padding-bottom: 12px;"> Links </h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="padding: 8px 0;"><a href="/" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> Inicio </a></li>
            <li style="padding: 8px 0;"><a href="/!/historia-oti" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> Historia </a></li>
          </ul>
        </div>

        <div class="col-lg-2 col-md-3 footer-links">
          <h4 style="color: #F8FAFF; font-size: 16px; font-weight: 600; position: relative; padding-bottom: 12px;">Servicios</h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="padding: 8px 0;"><a href="/firmaUNA.jsp" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> Firma Digital </a></li>
            <li style="padding: 8px 0;"><a href="http://oti.servicios.unap.edu.pe/" target="_blank" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> Correo institucional </a></li>
          </ul>
        </div>

        <div class="col-lg-2 col-md-3 footer-links">
          <h4 style="color: #F8FAFF; font-size: 16px; font-weight: 600; position: relative; padding-bottom: 12px;"> Soporte </h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="padding: 8px 0;"><a href="solicitud.jsp" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> Solicitar soporte </a></li>
            <li style="padding: 8px 0;"><a href="/unidades.jsp" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> Nuestro personal </a></li>
          </ul>
        </div>

        <div class="col-lg-2 col-md-3 footer-links">
          <h4 style="color: #F8FAFF; font-size: 16px; font-weight: 600; position: relative; padding-bottom: 12px;"> Softwares </h4>
          <ul style="list-style: none; padding: 0; margin: 0;">
            <li style="padding: 8px 0;"><a href="/firmaUNA.jsp" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> FirmaUNA </a></li>
            <li style="padding: 8px 0;"><a href="<%= Configuracion.getValue("url_firmaperu", "https://apps.firmaperu.gob.pe/web") %>" target="_blank" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> FirmaPeru de PCM </a></li>
            <li style="padding: 8px 0;"><a href="/recursos/JDK-8u202-x64.exe" style="color: #94A3B8; text-decoration: none; transition: 0.3s; font-size: 14px;" onmouseover="this.style.color='#22D3EE'" onmouseout="this.style.color='#94A3B8'"> JDK 1.8 para RENIEC </a></li>
          </ul> 
        </div>

      </div>
    </div>

    <div class="container copyright text-center mt-4" style="border-top: 1px solid rgba(148, 163, 184, 0.15); padding-top: 25px;">
      <p style="color: #94A3B8; margin-bottom: 0;">© <span>Copyright</span> <strong class="px-1" style="color: #F8FAFF;"> <%= Configuracion.getValue("footer_brand", "Portal OTI") %> </strong> <span> <%= java.time.Year.now() %> </span></p>
      <div style="margin-top: 8px; font-size: 13px; color: #64748B;">
        Desarrollado por <span style="color: #22D3EE;"><%= Configuracion.getValue("footer_developer", "Subunidad de Gobierno Electrónico") %></span>
      </div>
    </div>

  </footer>

      
    <!-- Botón para abrir el modal -->
    <!--
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#dlgAviso">
      Abrir modal
    </button>
    -->

    <!-- Estructura del modal -->
    <div class="modal fade" id="dlgAviso" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl">
        <div class="modal-content">
          <!-- Encabezado del modal -->
          <div class="modal-header" style="background: linear-gradient(135deg, #0891B2, #06B6D4); color: white;">
            <h5 class="modal-title" id="exampleModalLabel"> FirmaUNA - Software de Firma Digital </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
          </div>
          
          <div class="modal-body">
            <%
              String cfgWinUrl = Configuracion.getValue("firma_windows_url", "");
              String cfgLinuxUrl = Configuracion.getValue("firma_linux_url", "");
              String cfgMacUrl = Configuracion.getValue("firma_mac_url", "");
              String cfgVideoWin = Configuracion.getValue("firma_video_windows", "");
              String cfgVideoLinux = Configuracion.getValue("firma_video_linux", "");
              String cfgVideoMac = Configuracion.getValue("firma_video_mac", "");
              String cfgFirmaPeru = Configuracion.getValue("url_firmaperu", "");
              String modalWinFile = cfgWinUrl.isEmpty() ? "No disponible" : cfgWinUrl.substring(cfgWinUrl.lastIndexOf('/') + 1);
              String modalLinuxFile = cfgLinuxUrl.isEmpty() ? "No disponible" : cfgLinuxUrl.substring(cfgLinuxUrl.lastIndexOf('/') + 1);
              String modalMacFile = cfgMacUrl.isEmpty() ? "No disponible" : cfgMacUrl.substring(cfgMacUrl.lastIndexOf('/') + 1);
            %>
            <div class="row">
              <!-- Columna izquierda: Descargas -->
              <div class="col-md-5" style="border-right: 1px solid #e2e8f0; padding-right: 24px;">
                <h6 style="font-weight: 700; color: #0F172A; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 2px solid #0891B2;">
                  Descargar Instalador
                </h6>
                
                <div class="d-grid gap-2">
                  <a class="btn btn-success d-flex align-items-center justify-content-start" target="_blank"
                     href="<%= cfgWinUrl.isEmpty() ? '#' : cfgWinUrl %>"
                     style="border-radius: 8px; padding: 12px 16px; text-decoration: none; <%= cfgWinUrl.isEmpty() ? "opacity:0.5; pointer-events:none;" : "" %>">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 12px;"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                    <div style="text-align: left;">
                      <div style="font-weight: 600;">Windows</div>
                      <small style="opacity: 0.8;"><%= modalWinFile %></small>
                    </div>
                  </a>
                  
                  <a class="btn btn-outline-info d-flex align-items-center justify-content-start" target="_blank"
                     href="<%= cfgLinuxUrl.isEmpty() ? '#' : cfgLinuxUrl %>"
                     style="border-radius: 8px; padding: 12px 16px; text-decoration: none; <%= cfgLinuxUrl.isEmpty() ? "opacity:0.5; pointer-events:none;" : "" %>">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 12px;"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                    <div style="text-align: left;">
                      <div style="font-weight: 600;">Linux</div>
                      <small style="opacity: 0.8;"><%= modalLinuxFile %></small>
                    </div>
                  </a>
                  
                  <a class="btn btn-outline-warning d-flex align-items-center justify-content-start" target="_blank"
                     href="<%= cfgMacUrl.isEmpty() ? '#' : cfgMacUrl %>"
                     style="border-radius: 8px; padding: 12px 16px; text-decoration: none; <%= cfgMacUrl.isEmpty() ? "opacity:0.5; pointer-events:none;" : "" %>">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 12px;"><path d="M12 20.94c1.5 0 2.75 1.06 4 1.06 3 0 6-8 6-12.22A4.91 4.91 0 0 0 17 5c-2.22 0-4 1.44-5 2-1-.56-2.78-2-5-2a4.9 4.9 0 0 0-5 4.78C2 14 5 22 8 22c1.25 0 2.5-1.06 4-1.06Z"></path><path d="M10 2c1 .5 2 2 2 5"></path></svg>
                    <div style="text-align: left;">
                      <div style="font-weight: 600;">MacOS</div>
                      <small style="opacity: 0.8;"><%= modalMacFile %></small>
                    </div>
                  </a>
                </div>
                
                <div style="margin-top: 20px; padding: 12px; background: #F0F9FF; border-radius: 8px; font-size: 12px; color: #0369A1;">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px; vertical-align: middle;"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                  Seleccione segun su sistema operativo
                </div>
                <% if (!cfgFirmaPeru.isEmpty()) { %>
                <a href="<%= cfgFirmaPeru %>" target="_blank" class="btn btn-outline-dark d-flex align-items-center justify-content-start" style="border-radius: 8px; padding: 12px 16px; text-decoration: none; margin-top: 12px;">
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 12px;"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                  <div style="text-align: left;">
                    <div style="font-weight: 600;">FirmaPeru (PCM)</div>
                    <small style="opacity: 0.8;">Portal oficial</small>
                  </div>
                </a>
                <% } %>
              </div>
              
              <!-- Columna derecha: Tutoriales -->
              <div class="col-md-7" style="padding-left: 24px;">
                <h6 style="font-weight: 700; color: #0F172A; margin-bottom: 16px; padding-bottom: 8px; border-bottom: 2px solid #EF4444;">
                  Video Tutoriales
                </h6>
                
                <!-- Reproductor de video -->
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 8px; background: #000; margin-bottom: 16px;" id="videoContainer">
                  <iframe id="modalVideoFrame" src="" allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none; display: none;"></iframe>
                  <div id="videoPlaceholder" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; flex-direction: column; color: #64748B;">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-bottom: 8px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                    <small>Seleccione un video tutorial</small>
                  </div>
                </div>
                
                <!-- Botones de seleccion -->
                <div class="d-flex gap-2">
                  <button type="button" class="btn btn-outline-danger btn-sm flex-fill"
                          <%= cfgVideoWin.isEmpty() ? "disabled" : "onclick=\"playModalVideo('windows')\"" %>
                          style="border-radius: 6px; <%= cfgVideoWin.isEmpty() ? "opacity:0.5;" : "" %>">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                    Windows
                  </button>
                  <button type="button" class="btn btn-outline-danger btn-sm flex-fill"
                          <%= cfgVideoLinux.isEmpty() ? "disabled" : "onclick=\"playModalVideo('linux')\"" %>
                          style="border-radius: 6px; <%= cfgVideoLinux.isEmpty() ? "opacity:0.5;" : "" %>">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                    Linux
                  </button>
                  <button type="button" class="btn btn-outline-danger btn-sm flex-fill"
                          <%= cfgVideoMac.isEmpty() ? "disabled" : "onclick=\"playModalVideo('mac')\"" %>
                          style="border-radius: 6px; <%= cfgVideoMac.isEmpty() ? "opacity:0.5;" : "" %>">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                    MacOS
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

  <!-- Notification Modal -->
  <div class="modal fade" id="notifModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
      <div class="modal-content" style="border-radius: 12px; border: none; overflow: hidden;">
        <div class="modal-body text-center p-4">
          <div id="notifIcon" style="font-size: 48px; margin-bottom: 12px;"></div>
          <h5 id="notifTitle" style="font-size: 16px; font-weight: 600; margin-bottom: 8px;"></h5>
          <p id="notifMsg" style="font-size: 13px; color: #64748B; margin-bottom: 16px;"></p>
          <button type="button" class="btn btn-sm w-100" id="notifBtn" data-bs-dismiss="modal" style="border-radius: 8px;">Aceptar</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Floating Support Bubble -->
  <div class="floating-bubble-wrapper" id="floatingBubble">
    <div class="floating-bubble-msg" id="bubbleMsg">
      <div class="msg-title">Generar solicitud</div>
      <p class="msg-text">Eres personal, estudiante y tienes problemas, quieres realizar una solicitud de creación, eliminación, u otro motivo.</p>
    </div>
    <button class="floating-bubble-btn" id="bubbleBtn" aria-label="Generar solicitud" onclick="location.href='solicitud.jsp'">
      <span class="pulse-ring"></span>
      <svg viewBox="0 0 24 24"><path d="M3 18v-6a9 9 0 0 1 18 0v6"></path><path d="M21 19a2 2 0 0 1-2 2h-1a2 2 0 0 1-2-2v-3a2 2 0 0 1 2-2h3zM3 19a2 2 0 0 0 2 2h1a2 2 0 0 0 2-2v-3a2 2 0 0 0-2-2H3z"></path></svg>
    </button>
  </div>

  <!-- <div id="preloader"></div> -->

  
  <!-- Vendor JS Files -->
  <script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- <script src="assets/vendor/php-email-form/validate.js"></script> -->
  <script src="/assets/vendor/aos/aos.js"></script>
  <script src="/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="/assets/vendor/swiper/swiper-bundle.min.js"></script>

  <script src="/assets/js/main.js"></script>
</body>

<script>
function playModalVideo(os) {
    var iframe = document.getElementById('modalVideoFrame');
    var placeholder = document.getElementById('videoPlaceholder');
    var videoIds = {
        windows: '<%= cfgVideoWin %>',
        linux: '<%= cfgVideoLinux %>',
        mac: '<%= cfgVideoMac %>'
    };
    var id = videoIds[os];
    if (id) {
        iframe.src = 'https://www.youtube.com/embed/' + id + '?autoplay=1&rel=0';
        iframe.style.display = 'block';
        placeholder.style.display = 'none';
    }
}

// Reset video when modal closes
document.getElementById('dlgAviso').addEventListener('hidden.bs.modal', function () {
    var iframe = document.getElementById('modalVideoFrame');
    var placeholder = document.getElementById('videoPlaceholder');
    iframe.src = '';
    iframe.style.display = 'none';
    placeholder.style.display = 'flex';
});
</script>

<script>
// Hero video auto-play
(function() {
    var heroImage = document.getElementById('heroImage');
    var heroVideo = document.getElementById('heroVideo');
    if (!heroImage || !heroVideo) return;

    var videoId = '<%= Configuracion.getValue("hero_video_id", "") %>';
    if (!videoId) return;

    var videoUrl = 'https://www.youtube.com/embed/' + videoId + '?autoplay=1&mute=1&rel=0&enablejsapi=1';
    var delayBeforePlay = 5000;
    
    function playHeroVideo() {
        heroVideo.src = videoUrl;
        heroVideo.style.display = 'block';
        heroImage.style.opacity = '0.3';
    }
    
    function showHeroImage() {
        heroVideo.style.display = 'none';
        heroVideo.src = '';
        heroImage.style.opacity = '1';
    }
    
    // Auto-play after delay
    setTimeout(playHeroVideo, delayBeforePlay);
    
    // Listen for video end using YouTube API
    window.addEventListener('message', function(event) {
        if (event.origin !== 'https://www.youtube.com') return;
        try {
            var data = JSON.parse(event.data);
            if (data.event === 'onStateChange' && data.info === 0) {
                showHeroImage();
            }
        } catch(e) {}
    });
    
    // Fallback: show image after video duration (OTI intro is ~60s)
    setTimeout(showHeroImage, delayBeforePlay + 65000);
})();
</script>


<script>
(function() {
  const btn = document.getElementById('bubbleBtn');
  const msg = document.getElementById('bubbleMsg');
  if (!btn || !msg) return;

  let bubbleInterval;

  function showBubble() {
    msg.classList.add('show');
    setTimeout(function() {
      msg.classList.remove('show');
    }, 6000);
  }

  // Show after 1.5s on page load
  setTimeout(function() {
    showBubble();
    // Then repeat every 30s
    bubbleInterval = setInterval(showBubble, 30000);
  }, 1500);

  // Close when clicking outside
  document.addEventListener('click', function(e) {
    if (!btn.contains(e.target) && !msg.contains(e.target)) {
      msg.classList.remove('show');
    }
  });
})();
</script>

<script>
(function() {
  var services = [${_svcJS}];
  if (services.length === 0) return;

  var wrap = document.getElementById("svcWheelWrap");
  var wheel = document.getElementById("svcWheel");
  var dotsContainer = document.getElementById("svcDots");
  var btnUp = document.getElementById("svcUp");
  var btnDown = document.getElementById("svcDown");

  var count = services.length;
  var current = 0;
  var isDragging = false;
  var startY = 0;
  var startIdx = 0;
  var autoTimer = null;

  function buildFaces() {
    wheel.innerHTML = "";
    dotsContainer.innerHTML = "";
    services.forEach(function(s, i) {
      var a = document.createElement("a");
      a.className = "svc-wheel-face";
      a.href = s.enlace;
      a.target = "_blank";

      var icon = document.createElement("div");
      icon.className = "svc-wheel-icon";
      if (s.img) {
        var img = document.createElement("img");
        img.src = s.img; img.alt = s.titulo; img.draggable = false;
        icon.appendChild(img);
      } else {
        icon.innerHTML = '<svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#0891B2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>';
      }

      var txt = document.createElement("div");
      txt.className = "svc-wheel-text";
      txt.innerHTML = '<h4>' + s.titulo + '</h4><p>' + s.desc + '</p>';

      a.appendChild(icon);
      a.appendChild(txt);
      wheel.appendChild(a);

      var dot = document.createElement("button");
      dot.className = "svc-wheel-dot" + (i === 0 ? " active" : "");
      dot.onclick = function() { rotateTo(i); };
      dotsContainer.appendChild(dot);
    });
  }

  function updateFaces() {
    var faces = wheel.querySelectorAll(".svc-wheel-face");
    faces.forEach(function(face, i) {
      var diff = i - current;
      var n = count;
      var half = Math.floor(n / 2);
      if (diff > half) diff -= n;
      if (diff < -half) diff += n;
      var absDiff = Math.abs(diff);

      face.classList.remove("face-center", "face-near", "face-hidden");

      var ty = diff * 110;
      var sc = absDiff === 0 ? 1 : absDiff === 1 ? 0.88 : 0;
      var op = absDiff === 0 ? 1 : absDiff === 1 ? 0.5 : 0;
      var zi = absDiff === 0 ? 5 : absDiff === 1 ? 3 : 0;

      if (absDiff === 0) face.classList.add("face-center");
      else if (absDiff === 1) face.classList.add("face-near");
      else face.classList.add("face-hidden");

      face.style.transform = "translateX(-50%) translateY(calc(-50% + " + ty + "px)) scale(" + sc + ")";
      face.style.zIndex = zi;
      face.style.opacity = op;
    });

    var dots = dotsContainer.querySelectorAll(".svc-wheel-dot");
    dots.forEach(function(d, i) { d.classList.toggle("active", i === current); });
  }

  function rotateTo(idx) {
    current = ((idx % count) + count) % count;
    updateFaces();
  }

  function rotateNext() { rotateTo(current + 1); }
  function rotatePrev() { rotateTo(current - 1); }

  function startAuto() { stopAuto(); autoTimer = setInterval(rotateNext, 4000); }
  function stopAuto() { if (autoTimer) { clearInterval(autoTimer); autoTimer = null; } }

  // Flechas
  btnUp.onclick = function() { stopAuto(); rotatePrev(); startAuto(); };
  btnDown.onclick = function() { stopAuto(); rotateNext(); startAuto(); };

  // Drag vertical
  function onDragStart(e) {
    isDragging = true;
    startY = e.type.includes("mouse") ? e.clientY : e.touches[0].clientY;
    startIdx = current;
    wheel.classList.add("dragging");
    stopAuto();
  }
  function onDragMove(e) {
    if (!isDragging) return;
    var y = e.type.includes("mouse") ? e.clientY : e.touches[0].clientY;
    var delta = Math.round((startY - y) / 110);
    var target = ((startIdx + delta) % count + count) % count;
    if (target !== current) rotateTo(target);
  }
  function onDragEnd() {
    if (!isDragging) return;
    isDragging = false;
    wheel.classList.remove("dragging");
    startAuto();
  }

  wheel.addEventListener("mousedown", onDragStart);
  wheel.addEventListener("touchstart", onDragStart, { passive: true });
  document.addEventListener("mousemove", onDragMove);
  document.addEventListener("touchmove", onDragMove, { passive: true });
  document.addEventListener("mouseup", onDragEnd);
  document.addEventListener("touchend", onDragEnd);

  // Init
  buildFaces();
  updateFaces();
  if (count > 1) startAuto();
})();
</script>

</html>