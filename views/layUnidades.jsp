<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="jxmvc.models.Unidad" %>
<%
    List<Unidad> unidades = (List<Unidad>) request.getAttribute("unidadesDB");
    if (unidades == null) unidades = java.util.Collections.emptyList();
%>

<div>
    <h1> Unidades de la OTI </h1>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <div class="alert alert-primary">
            <b> Estructura Organizacional </b>
        </div>
        <p align="justify">
            La <b>Oficina de Tecnologias de la Informacion</b> esta compuesta por sub-unidades especializadas
            que brindan soporte tecnologico a toda la Universidad Nacional del Altiplano Puno.
        </p>
    </div>
</div>

<div class="row mt-4">
    <% for (Unidad u : unidades) { %>
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; transition: box-shadow 0.3s; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;"><%= u.titulo %></h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Subunidad</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 16px; flex-grow: 1;">
                    <%= u.descripcion != null ? u.descripcion : "" %>
                </p>
                <% if (u.enlaceUrl != null && !u.enlaceUrl.isEmpty()) { %>
                <a href="<%= u.enlaceUrl %>"
                   target="<%= u.enlaceNuevaPestana ? "_blank" : "_self" %>"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    <%= u.enlaceTexto != null && !u.enlaceTexto.isEmpty() ? u.enlaceTexto : "Ver mas" %>
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </a>
                <% } %>
            </div>
        </div>
    </div>
    <% } %>
</div>
