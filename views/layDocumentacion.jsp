<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="jxmvc.models.Documento" %>
<%
    List<Documento> documentos = (List<Documento>) request.getAttribute("documentosDB");
    if (documentos == null) documentos = java.util.Collections.emptyList();
%>

<!-- Documentacion Hero -->
<section class="doc-hero">
  <div class="container">
    <div class="doc-hero-content" data-aos="fade-up">
      <span class="doc-badge">Normativas y Estandares</span>
      <h1>Documentacion</h1>
      <p>Documentos normativos y legales que rigen la seguridad de la informacion y proteccion de datos personales en la OTI</p>
    </div>
  </div>
</section>

<!-- Documentos Grid -->
<section class="doc-grid-section section-dark">
  <div class="container">
    <div class="doc-grid">

      <% String[] docIcons = {
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z\"></path><polyline points=\"14 2 14 8 20 8\"></polyline><line x1=\"16\" y1=\"13\" x2=\"8\" y2=\"13\"></line><line x1=\"16\" y1=\"17\" x2=\"8\" y2=\"17\"></line></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z\"></path></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><circle cx=\"12\" cy=\"12\" r=\"10\"></circle><line x1=\"12\" y1=\"16\" x2=\"12\" y2=\"12\"></line><line x1=\"12\" y1=\"8\" x2=\"12.01\" y2=\"8\"></line></svg>",
        "<svg width=\"28\" height=\"28\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"1.5\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z\"></path></svg>"
      }; %>

      <% for (int i = 0; i < documentos.size(); i++) {
           Documento d = documentos.get(i);
           int iconIdx = i % docIcons.length;
           String docLink = null;
           if (d.archivoUrl != null && !d.archivoUrl.isEmpty()) {
               docLink = d.archivoUrl;
           } else if (d.url != null && !d.url.isEmpty()) {
               docLink = d.url;
           }
      %>
      <div class="doc-card" data-aos="fade-up" data-aos-delay="<%= i * 80 %>">
        <div class="doc-card-icon">
          <%= docIcons[iconIdx] %>
        </div>
        <% if (d.tipo != null && !d.tipo.isEmpty()) { %>
        <span class="doc-card-type"><%= d.tipo %></span>
        <% } %>
        <h3 class="doc-card-title"><%= d.titulo %></h3>
        <p class="doc-card-desc"><%= d.descripcion != null ? d.descripcion : "" %></p>
        <% if (docLink != null) { %>
        <a href="<%= docLink %>"
           target="_blank"
           rel="noopener noreferrer"
           class="doc-card-link">
          Ver documento
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
        </a>
        <% } %>
      </div>
      <% } %>

    </div>
  </div>
</section>
