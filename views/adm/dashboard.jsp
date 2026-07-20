<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.Actividad" %>
<%@ page import="jxmvc.models.PlanaDirectiva" %>
<%@ page import="jxmvc.models.Configuracion" %>
<%@ page import="java.util.List" %>
<%
    List<Actividad> actividades = Actividad.getAll();
    List<PlanaDirectiva> directiva = PlanaDirectiva.getAll();
    List<Configuracion> configs = Configuracion.getAll();

    int totalActividades = actividades.size();
    int activasCount = 0;
    for (Actividad a : actividades) { if (a.activo) activasCount++; }

    int totalDirectiva = directiva.size();
    int totalConfig = configs.size();
%>

<!-- Stat Cards -->
<div class="stat-cards">

    <div class="stat-card">
        <div class="stat-card-icon cyan">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
        </div>
        <div>
            <div class="stat-card-value"><%= totalActividades %></div>
            <div class="stat-card-label">Total actividades</div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-icon green">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
        </div>
        <div>
            <div class="stat-card-value"><%= activasCount %></div>
            <div class="stat-card-label">Activas (visibles)</div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-icon purple">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
        </div>
        <div>
            <div class="stat-card-value"><%= totalDirectiva %></div>
            <div class="stat-card-label">Plana directiva</div>
        </div>
    </div>

    <div class="stat-card">
        <div class="stat-card-icon yellow">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
        </div>
        <div>
            <div class="stat-card-value"><%= totalConfig %></div>
            <div class="stat-card-label">Configuraciones</div>
        </div>
    </div>

</div>

<!-- Accesos rapidos + Ultima actividad -->
<div class="row g-4">

    <!-- Accesos rapidos -->
    <div class="col-lg-6">
        <div class="admin-card">
            <div class="admin-card-header">
                <h3 class="admin-card-title">Accesos rapidos</h3>
            </div>
            <div style="padding: 20px;">

                <a href="${pageContext.request.contextPath}/adm/actividades" style="display: flex; align-items: center; gap: 14px; padding: 14px; border: 1px solid var(--border-color); border-radius: 12px; text-decoration: none; color: inherit; transition: all 0.2s; margin-bottom: 10px;"
                   onmouseover="this.style.borderColor='var(--accent-color)'; this.style.background='rgba(8,145,178,0.03)'"
                   onmouseout="this.style.borderColor='var(--border-color)'; this.style.background='transparent'">
                    <div class="stat-card-icon cyan" style="margin: 0;">
                        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                    </div>
                    <div>
                        <div style="font-weight: 600; color: var(--heading-color); font-size: 0.92rem;">Gestionar actividades</div>
                        <div style="font-size: 0.8rem; color: var(--default-color);">Crear, editar y ordenar el carrusel</div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/adm/plana-directiva" style="display: flex; align-items: center; gap: 14px; padding: 14px; border: 1px solid var(--border-color); border-radius: 12px; text-decoration: none; color: inherit; transition: all 0.2s; margin-bottom: 10px;"
                   onmouseover="this.style.borderColor='var(--accent-color)'; this.style.background='rgba(8,145,178,0.03)'"
                   onmouseout="this.style.borderColor='var(--border-color)'; this.style.background='transparent'">
                    <div class="stat-card-icon purple" style="margin: 0;">
                        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                    </div>
                    <div>
                        <div style="font-weight: 600; color: var(--heading-color); font-size: 0.92rem;">Plana directiva</div>
                        <div style="font-size: 0.8rem; color: var(--default-color);">Administrar miembros del equipo</div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/adm/configuracion" style="display: flex; align-items: center; gap: 14px; padding: 14px; border: 1px solid var(--border-color); border-radius: 12px; text-decoration: none; color: inherit; transition: all 0.2s;"
                   onmouseover="this.style.borderColor='var(--accent-color)'; this.style.background='rgba(8,145,178,0.03)'"
                   onmouseout="this.style.borderColor='var(--border-color)'; this.style.background='transparent'">
                    <div class="stat-card-icon yellow" style="margin: 0;">
                        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
                    </div>
                    <div>
                        <div style="font-weight: 600; color: var(--heading-color); font-size: 0.92rem;">Configuracion general</div>
                        <div style="font-size: 0.8rem; color: var(--default-color);">Hero video, textos, SEO</div>
                    </div>
                </a>

            </div>
        </div>
    </div>

    <!-- Ultimas actividades -->
    <div class="col-lg-6">
        <div class="admin-card">
            <div class="admin-card-header">
                <h3 class="admin-card-title">Ultimas actividades</h3>
                <a href="${pageContext.request.contextPath}/adm/actividades" class="btn-admin btn-admin-secondary" style="font-size: 0.78rem; padding: 6px 12px;">Ver todo</a>
            </div>
            <div class="admin-card-body">
                <% if (actividades.isEmpty()) { %>
                    <div class="empty-state">
                        <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                        <div class="empty-state-title">Sin actividades</div>
                        <div class="empty-state-desc">Crea tu primera actividad para el carrusel</div>
                        <a href="${pageContext.request.contextPath}/adm/actividades" class="btn-admin btn-admin-primary" style="font-size: 0.85rem;">Crear actividad</a>
                    </div>
                <% } else { %>
                    <div class="table-responsive-wrapper">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Actividad</th>
                                <th>Estado</th>
                                <th>Orden</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int limit = Math.min(actividades.size(), 5); %>
                            <% for (int i = 0; i < limit; i++) { %>
                            <% Actividad act = actividades.get(i); %>
                            <tr>
                                <td data-label="Actividad" style="display: flex; align-items: center; gap: 12px;">
                                    <% if (act.imagenUrl != null && !act.imagenUrl.isEmpty()) { %>
                                        <img src="<%= act.imagenUrl %>" class="table-img" alt="">
                                    <% } else { %>
                                        <div class="table-img" style="background: var(--admin-content-bg); display: flex; align-items: center; justify-content: center;">
                                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--default-color)" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                        </div>
                                    <% } %>
                                    <div>
                                        <span class="table-title"><%= act.titulo %></span>
                                    </div>
                                </td>
                                <td data-label="Estado">
                                    <span class="badge-status <%= act.activo ? "badge-active" : "badge-inactive" %>">
                                        <%= act.activo ? "Activo" : "Inactivo" %>
                                    </span>
                                </td>
                                <td data-label="Orden" style="font-weight: 600; color: var(--default-color);"><%= act.orden %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

</div>
