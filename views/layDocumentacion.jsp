<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="jxmvc.models.Documento" %>
<%
    List<Documento> documentos = (List<Documento>) request.getAttribute("documentosDB");
    if (documentos == null) documentos = java.util.Collections.emptyList();
%>

<div>
    <h1> Documentacion </h1>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <div class="alert alert-primary">
            <b> Normativas y Estandares de Seguridad de la Informacion </b> 
        </div>
        <p align="justify">
            A continuacion se proporcionan los documentos normativos y legales que rigen 
            la seguridad de la informacion y proteccion de datos personales en la 
            <b>Oficina de Tecnologias de la Informacion</b> de la Universidad Nacional del Altiplano Puno.
        </p>
    </div>
</div>

<div class="row mt-4">
    <% for (Documento d : documentos) { 
        String docLink = null;
        if (d.archivoUrl != null && !d.archivoUrl.isEmpty()) {
            docLink = d.archivoUrl;
        } else if (d.url != null && !d.url.isEmpty()) {
            docLink = d.url;
        }
    %>
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; transition: box-shadow 0.3s; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;"><%= d.titulo %></h5>
                        <% if (d.tipo != null && !d.tipo.isEmpty()) { %>
                            <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;"><%= d.tipo %></p>
                        <% } %>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 16px; flex-grow: 1;">
                    <%= d.descripcion != null ? d.descripcion : "" %>
                </p>
                <% if (docLink != null) { %>
                <a href="<%= docLink %>"
                   target="_blank"
                   rel="noopener noreferrer"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                    Ver documento
                </a>
                <% } %>
            </div>
        </div>
    </div>
    <% } %>
</div>
