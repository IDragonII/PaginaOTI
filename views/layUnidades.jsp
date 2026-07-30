<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="jxmvc.models.Unidad" %>
<%
    List<Unidad> unidades = (List<Unidad>) request.getAttribute("unidadesDB");
    if (unidades == null) unidades = java.util.Collections.emptyList();
%>

<!-- Unidades Hero -->
<section class="unidades-hero">
  <div class="container">
    <div class="unidades-hero-content" data-aos="fade-up">
      <span class="unidades-badge">Estructura Organizacional</span>
      <h1>Unidades de la OTI</h1>
      <p>Sub-unidades especializadas que brindan soporte tecnológico a toda la Universidad Nacional del Altiplano Puno</p>
    </div>
  </div>
</section>

<!-- Unidades Grid -->
<section class="unidades-grid-section section-dark">
  <div class="container">
    <div class="unidades-grid">

      <% String[] icons = {
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><rect x=\"2\" y=\"3\" width=\"20\" height=\"14\" rx=\"2\" ry=\"2\"></rect><line x1=\"8\" y1=\"21\" x2=\"16\" y2=\"21\"></line><line x1=\"12\" y1=\"17\" x2=\"12\" y2=\"21\"></line></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z\"></path></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M22 12h-4l-3 9L9 3l-3 9H2\"></path></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><polyline points=\"16 18 22 12 16 6\"></polyline><polyline points=\"8 6 2 12 8 18\"></polyline></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2\"></path><circle cx=\"9\" cy=\"7\" r=\"4\"></circle><path d=\"M23 21v-2a4 4 0 0 0-3-3.87\"></path><path d=\"M16 3.13a4 4 0 0 1 0 7.75\"></path></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><circle cx=\"12\" cy=\"12\" r=\"10\"></circle><line x1=\"2\" y1=\"12\" x2=\"22\" y2=\"12\"></line><path d=\"M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z\"></path></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z\"></path><polyline points=\"3.27 6.96 12 12.01 20.73 6.96\"></polyline><line x1=\"12\" y1=\"22.08\" x2=\"12\" y2=\"12\"></line></svg>"
      }; %>

      <% for (int i = 0; i < unidades.size(); i++) {
           Unidad u = unidades.get(i);
           int iconIdx = i % icons.length;
      %>
      <div class="unidad-card" data-aos="fade-up" data-aos-delay="<%= i * 80 %>">
        <div class="unidad-card-icon">
          <%= icons[iconIdx] %>
        </div>
        <h3 class="unidad-card-title"><%= u.titulo %></h3>
        <p class="unidad-card-desc"><%= u.descripcion != null ? u.descripcion : "" %></p>
        <% if (u.enlaceUrl != null && !u.enlaceUrl.isEmpty()) { %>
        <a href="<%= u.enlaceUrl %>"
           target="<%= u.enlaceNuevaPestana ? "_blank" : "_self" %>"
           class="unidad-card-link">
          <%= u.enlaceTexto != null && !u.enlaceTexto.isEmpty() ? u.enlaceTexto : "Ver más" %>
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
        </a>
        <% } %>
      </div>
      <% } %>

    </div>
  </div>
</section>
