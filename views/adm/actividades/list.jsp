<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.Actividad" %>
<%@ page import="java.util.List" %>
<%
    List<Actividad> actividades = Actividad.getAll();
%>

<!-- Toolbar -->
<div class="admin-toolbar" style="margin-bottom: 20px;">
    <div class="toolbar-search">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        <input type="text" id="searchInput" placeholder="Buscar actividad..." oninput="filterTable()">
    </div>
    <div class="toolbar-filter">
        <button class="filter-btn active" onclick="filterStatus('all', this)">Todas</button>
        <button class="filter-btn" onclick="filterStatus('active', this)">Activas</button>
        <button class="filter-btn" onclick="filterStatus('inactive', this)">Inactivas</button>
    </div>
    <button class="btn-admin btn-admin-primary" onclick="openModal()">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        Nueva actividad
    </button>
</div>

<!-- Table Card -->
<div class="admin-card">
    <div class="admin-card-body">
        <% if (actividades.isEmpty()) { %>
            <div class="empty-state">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                <div class="empty-state-title">Sin actividades</div>
                <div class="empty-state-desc">Crea tu primera actividad para el carrusel del home</div>
                <button class="btn-admin btn-admin-primary" onclick="openModal()">
                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                    Crear actividad
                </button>
            </div>
        <% } else { %>
            <div class="table-responsive-wrapper">
            <table class="admin-table" id="actividadesTable">
                <thead>
                    <tr>
                        <th style="width: 32px;"></th>
                        <th style="width: 56px;">Img</th>
                        <th>Titulo</th>
                        <th style="width: 110px;">Tipo</th>
                        <th class="col-desc">Descripcion</th>
                        <th class="col-enlace" style="width: 70px;">Enlace</th>
                        <th style="width: 80px;">Estado</th>
                        <th style="width: 72px;">Acc</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <% for (Actividad a : actividades) { %>
                    <tr data-id="<%= a.id %>" data-active="<%= a.activo %>">
                        <td data-label="">
                            <span class="drag-handle" title="Arrastrar para ordenar">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="5" r="1"></circle><circle cx="15" cy="5" r="1"></circle><circle cx="9" cy="12" r="1"></circle><circle cx="15" cy="12" r="1"></circle><circle cx="9" cy="19" r="1"></circle><circle cx="15" cy="19" r="1"></circle></svg>
                            </span>
                        </td>
                        <td data-label="Imagen">
                            <% if (a.imagenUrl != null && !a.imagenUrl.isEmpty()) { %>
                                <img src="<%= a.imagenUrl %>" class="table-img" alt="" style="width: 48px; height: 34px;">
                            <% } else { %>
                                <div class="table-img" style="width: 48px; height: 34px; background: var(--admin-content-bg); display: flex; align-items: center; justify-content: center;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--default-color)" stroke-width="1.5"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                </div>
                            <% } %>
                        </td>
                        <td data-label="Titulo">
                            <span class="table-title" style="font-size: 0.85rem;"><%= a.titulo %></span>
                        </td>
                        <td data-label="Tipo">
                            <span class="badge-status badge-active" style="font-size: 0.65rem; padding: 2px 8px;"><%= a.tipo != null ? a.tipo : "inst." %></span>
                        </td>
                        <td data-label="Descripcion" class="col-desc">
                            <span class="table-text-truncate" style="max-width: 220px; display: block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--default-color);"><%= a.descripcion != null ? a.descripcion : "" %></span>
                        </td>
                        <td data-label="Enlace" class="col-enlace">
                            <% if (a.enlaceUrl != null && !a.enlaceUrl.isEmpty()) { %>
                                <a href="<%= a.enlaceUrl %>" target="_blank" class="table-link" style="font-size: 0.78rem; white-space: nowrap;">
                                    <%= a.enlaceTexto != null && !a.enlaceTexto.isEmpty() ? a.enlaceTexto : "Ver" %>
                                </a>
                            <% } else { %>
                                <span style="color: var(--default-color); opacity: 0.4;">-</span>
                            <% } %>
                        </td>
                        <td data-label="Estado">
                            <span class="badge-status <%= a.activo ? "badge-active" : "badge-inactive" %>" style="font-size: 0.65rem; padding: 2px 8px;">
                                <%= a.activo ? "Activo" : "Inactivo" %>
                            </span>
                        </td>
                        <td data-label="Acciones">
                            <div class="action-btn-group" style="gap: 4px;">
                                <button class="action-btn" title="Editar" style="width: 28px; height: 28px;"
                                    data-id="<%= a.id %>"
                                    data-titulo="<%= a.titulo != null ? a.titulo : "" %>"
                                    data-tipo="<%= a.tipo != null ? a.tipo : "" %>"
                                    data-descripcion="<%= a.descripcion != null ? a.descripcion : "" %>"
                                    data-imagen-url="<%= a.imagenUrl != null ? a.imagenUrl : "" %>"
                                    data-enlace-url="<%= a.enlaceUrl != null ? a.enlaceUrl : "" %>"
                                    data-enlace-texto="<%= a.enlaceTexto != null ? a.enlaceTexto : "" %>"
                                    data-enlace-nueva-pestana="<%= a.enlaceNuevaPestana %>"
                                    data-orden="<%= a.orden %>"
                                    data-activo="<%= a.activo %>"
                                    onclick="openModal(this)">
                                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
                                </button>
                                <button class="action-btn danger" title="Eliminar" style="width: 28px; height: 28px;" onclick="confirmDelete('${pageContext.request.contextPath}/adm/actividades/delete?id=<%= a.id %>')">
                                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            </div>
        <% } %>
    </div>
</div>

<!-- Modal Form -->
<div class="modal fade modal-admin" id="actividadModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Nueva actividad</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="${pageContext.request.contextPath}/adm/actividades/save" class="form-admin" id="actividadForm">
                <div class="modal-body">
                    <input type="hidden" name="id" id="formId" value="">

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label" for="formTitulo">Titulo *</label>
                                <input type="text" class="form-control" id="formTitulo" name="titulo" required placeholder="Titulo de la actividad">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label" for="formTipo">Tipo</label>
                                <input type="text" class="form-control" id="formTipo" name="tipo" placeholder="ej: Evento, Capacitacion">
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label" for="formDescripcion">Descripcion</label>
                                <textarea class="form-control" id="formDescripcion" name="descripcion" rows="3" placeholder="Descripcion breve de la actividad"></textarea>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label" for="formOrden">Orden</label>
                                <input type="number" class="form-control" id="formOrden" name="orden" value="0" min="0">
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label" for="formEnlace">Enlace URL</label>
                                <input type="url" class="form-control" id="formEnlace" name="enlace" placeholder="https://...">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label" for="formEnlaceTexto">Texto del boton</label>
                                <input type="text" class="form-control" id="formEnlaceTexto" name="enlace_texto" placeholder="Ver mas" value="Ver mas">
                            </div>
                            <div class="form-group" style="margin-top: 8px;">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="formEnlaceNuevaPestana" name="enlace_nueva_pestana">
                                    <label class="form-check-label form-switch-label" for="formEnlaceNuevaPestana">Abrir en nueva pestana</label>
                                </div>
                            </div>
                            <div class="form-group" style="margin-top: 8px;">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="formActivo" name="activo" checked>
                                    <label class="form-check-label form-switch-label" for="formActivo">Activo</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Imagen</label>
                        <div class="upload-area" id="uploadArea" onclick="document.getElementById('fileInput').click()">
                            <input type="file" id="fileInput" accept="image/*" style="display: none;" onchange="previewImage(this)">
                            <div id="uploadPlaceholder">
                                <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                                <div class="upload-area-text">Click para subir imagen</div>
                                <div class="upload-area-hint">JPG, PNG, WebP (max 5MB)</div>
                            </div>
                            <div id="uploadPreview" style="display: none;">
                                <div class="upload-preview">
                                    <img id="previewImg" src="" alt="Preview">
                                    <button type="button" class="upload-preview-remove" onclick="removePreview(event)">&times;</button>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" name="imagen_url" id="formImagenUrl" value="">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn-admin btn-admin-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn-admin btn-admin-primary">
                        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
var currentFilter = 'all';
var sortable;

document.addEventListener('DOMContentLoaded', function() {
    var tbody = document.getElementById('tableBody');
    if (tbody) {
        sortable = new Sortable(tbody, {
            handle: '.drag-handle',
            animation: 200,
            ghostClass: 'sortable-ghost',
            chosenClass: 'sortable-chosen',
            onEnd: function() {
                saveOrder();
            }
        });
    }
});

function openModal(btn) {
    var modal = document.getElementById('actividadModal');
    var title = document.getElementById('modalTitle');

    if (btn) {
        title.textContent = 'Editar actividad';
        document.getElementById('formId').value = btn.dataset.id;
        document.getElementById('formTitulo').value = btn.dataset.titulo || '';
        document.getElementById('formTipo').value = btn.dataset.tipo || '';
        document.getElementById('formDescripcion').value = btn.dataset.descripcion || '';
        document.getElementById('formEnlace').value = btn.dataset.enlaceUrl || '';
        document.getElementById('formEnlaceTexto').value = btn.dataset.enlaceTexto || 'Ver mas';
        document.getElementById('formEnlaceNuevaPestana').checked = btn.dataset.enlaceNuevaPestana === 'true';
        document.getElementById('formOrden').value = btn.dataset.orden || 0;
        document.getElementById('formActivo').checked = btn.dataset.activo === 'true';
        document.getElementById('formImagenUrl').value = btn.dataset.imagenUrl || '';

        if (btn.dataset.imagenUrl) {
            document.getElementById('previewImg').src = btn.dataset.imagenUrl;
            document.getElementById('uploadPlaceholder').style.display = 'none';
            document.getElementById('uploadPreview').style.display = 'block';
        } else {
            document.getElementById('uploadPlaceholder').style.display = '';
            document.getElementById('uploadPreview').style.display = 'none';
        }
    } else {
        title.textContent = 'Nueva actividad';
        document.getElementById('actividadForm').reset();
        document.getElementById('formId').value = '';
        document.getElementById('formOrden').value = '0';
        document.getElementById('formEnlaceTexto').value = 'Ver mas';
        document.getElementById('formEnlaceNuevaPestana').checked = false;
        document.getElementById('formActivo').checked = true;
        document.getElementById('formImagenUrl').value = '';
        document.getElementById('uploadPlaceholder').style.display = '';
        document.getElementById('uploadPreview').style.display = 'none';
    }

    document.getElementById('fileInput').value = '';
    new bootstrap.Modal(modal).show();
}

function filterStatus(status, btn) {
    currentFilter = status;
    document.querySelectorAll('.filter-btn').forEach(function(b) { b.classList.remove('active'); });
    btn.classList.add('active');
    filterTable();
}

function filterTable() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var rows = document.querySelectorAll('#tableBody tr');

    rows.forEach(function(row) {
        var text = row.textContent.toLowerCase();
        var isActive = row.dataset.active === 'true';
        var matchSearch = text.includes(search);
        var matchFilter = currentFilter === 'all' ||
                         (currentFilter === 'active' && isActive) ||
                         (currentFilter === 'inactive' && !isActive);
        row.style.display = (matchSearch && matchFilter) ? '' : 'none';
    });
}

function saveOrder() {
    var rows = document.querySelectorAll('#tableBody tr');
    var ids = [];
    rows.forEach(function(row) { ids.push(row.dataset.id); });

    fetch('${pageContext.request.contextPath}/adm/actividades/reorder', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'orden[]=' + ids.join('&orden[]=')
    }).then(function(r) { return r.json(); })
      .then(function(d) { if (d.ok) showToast('success', 'Orden actualizado'); });
}

function previewImage(input) {
    if (!input.files || !input.files[0]) return;
    var file = input.files[0];
    if (file.size > 5 * 1024 * 1024) { showToast('warning', 'Maximo 5MB'); input.value = ''; return; }

    var fd = new FormData();
    fd.append('file', file);

    document.getElementById('uploadPlaceholder').innerHTML =
        '<div class="admin-spinner" style="margin: 0 auto;"></div><div style="font-size:0.82rem;color:var(--default-color);margin-top:8px;">Subiendo...</div>';

    fetch('${pageContext.request.contextPath}/adm/actividades/upload-image', {
        method: 'POST', body: fd
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.url) {
            document.getElementById('formImagenUrl').value = d.url;
            document.getElementById('previewImg').src = d.url;
            document.getElementById('uploadPlaceholder').style.display = 'none';
            document.getElementById('uploadPreview').style.display = 'block';
            document.getElementById('uploadPlaceholder').innerHTML =
                '<svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg><div class="upload-area-text">Click para subir imagen</div><div class="upload-area-hint">JPG, PNG, WebP (max 5MB)</div>';
        } else {
            showToast('error', d.error || 'Error al subir');
            document.getElementById('uploadPlaceholder').innerHTML =
                '<svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg><div class="upload-area-text">Click para subir imagen</div><div class="upload-area-hint">JPG, PNG, WebP (max 5MB)</div>';
            input.value = '';
        }
      }).catch(function() {
        showToast('error', 'Error de conexion');
        document.getElementById('uploadPlaceholder').innerHTML =
            '<svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg><div class="upload-area-text">Click para subir imagen</div><div class="upload-area-hint">JPG, PNG, WebP (max 5MB)</div>';
        input.value = '';
      });
}

function removePreview(e) {
    e.stopPropagation();
    document.getElementById('fileInput').value = '';
    document.getElementById('formImagenUrl').value = '';
    document.getElementById('uploadPlaceholder').style.display = '';
    document.getElementById('uploadPreview').style.display = 'none';
}
</script>
