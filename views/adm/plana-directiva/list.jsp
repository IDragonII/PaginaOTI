<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.PlanaDirectiva" %>
<%@ page import="java.util.List" %>
<%
    List<PlanaDirectiva> directiva = PlanaDirectiva.getAll();
%>

<!-- Toolbar -->
<div class="admin-toolbar" style="margin-bottom: 20px;">
    <div class="toolbar-search">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        <input type="text" id="searchInput" placeholder="Buscar miembro..." oninput="filterTable()">
    </div>
    <button class="btn-admin btn-admin-primary" onclick="openModal()">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        Nuevo miembro
    </button>
</div>

<!-- Table Card -->
<div class="admin-card">
    <div class="admin-card-body">
        <% if (directiva.isEmpty()) { %>
            <div class="empty-state">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                <div class="empty-state-title">Sin miembros</div>
                <div class="empty-state-desc">Agrega los miembros de la plana directiva</div>
                <button class="btn-admin btn-admin-primary" onclick="openModal()">
                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                    Agregar miembro
                </button>
            </div>
        <% } else { %>
            <div class="table-responsive-wrapper">
            <table class="admin-table" id="directivaTable">
                <thead>
                    <tr>
                        <th style="width: 40px;"></th>
                        <th style="width: 60px;">Foto</th>
                        <th>Nombre</th>
                        <th>Cargo</th>
                        <th>Redes</th>
                        <th>Estado</th>
                        <th style="width: 100px;">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <% for (PlanaDirectiva p : directiva) { %>
                    <tr data-id="<%= p.id %>" data-active="<%= p.activo %>">
                        <td data-label="">
                            <span class="drag-handle" title="Arrastrar para ordenar">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="5" r="1"></circle><circle cx="15" cy="5" r="1"></circle><circle cx="9" cy="12" r="1"></circle><circle cx="15" cy="12" r="1"></circle><circle cx="9" cy="19" r="1"></circle><circle cx="15" cy="19" r="1"></circle></svg>
                            </span>
                        </td>
                        <td data-label="Foto">
                            <% if (p.fotoUrl != null && !p.fotoUrl.isEmpty()) { %>
                                <img src="<%= p.fotoUrl %>" class="table-img-circular" alt="">
                            <% } else { %>
                                <div class="table-img-circular" style="background: linear-gradient(135deg, rgba(8,145,178,0.1), rgba(34,211,238,0.1)); display: flex; align-items: center; justify-content: center; font-weight: 700; color: var(--accent-color); font-size: 0.9rem;">
                                    <%= p.nombre != null ? p.nombre.substring(0, 1).toUpperCase() : "?" %>
                                </div>
                            <% } %>
                        </td>
                        <td data-label="Nombre">
                            <span class="table-title"><%= p.nombre %></span>
                        </td>
                        <td data-label="Cargo">
                            <span style="color: var(--default-color);"><%= p.cargo != null ? p.cargo : "" %></span>
                        </td>
                        <td data-label="Redes">
                            <div style="display: flex; gap: 6px;">
                                <% if (p.linkedinUrl != null && !p.linkedinUrl.isEmpty()) { %>
                                    <a href="<%= p.linkedinUrl %>" target="_blank" class="action-btn" title="LinkedIn">
                                        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"></path><rect x="2" y="9" width="4" height="12"></rect><circle cx="4" cy="4" r="2"></circle></svg>
                                    </a>
                                <% } %>
                                <% if (p.twitterUrl != null && !p.twitterUrl.isEmpty()) { %>
                                    <a href="<%= p.twitterUrl %>" target="_blank" class="action-btn" title="Twitter">
                                        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path></svg>
                                    </a>
                                <% } %>
                            </div>
                        </td>
                        <td data-label="Estado">
                            <span class="badge-status <%= p.activo ? "badge-active" : "badge-inactive" %>">
                                <%= p.activo ? "Activo" : "Inactivo" %>
                            </span>
                        </td>
                        <td data-label="Acciones">
                            <div class="action-btn-group">
                                <button class="action-btn" title="Editar"
                                    data-id="<%= p.id %>"
                                    data-nombre="<%= p.nombre != null ? p.nombre : "" %>"
                                    data-cargo="<%= p.cargo != null ? p.cargo : "" %>"
                                    data-descripcion="<%= p.descripcion != null ? p.descripcion : "" %>"
                                    data-foto-url="<%= p.fotoUrl != null ? p.fotoUrl : "" %>"
                                    data-linkedin-url="<%= p.linkedinUrl != null ? p.linkedinUrl : "" %>"
                                    data-twitter-url="<%= p.twitterUrl != null ? p.twitterUrl : "" %>"
                                    data-orden="<%= p.orden %>"
                                    data-activo="<%= p.activo %>"
                                    onclick="openModal(this)">
                                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
                                </button>
                                <button class="action-btn danger" title="Eliminar" onclick="confirmDelete('${pageContext.request.contextPath}/adm/plana-directiva/delete?id=<%= p.id %>')">
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
<div class="modal fade modal-admin" id="directivaModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Nuevo miembro</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="${pageContext.request.contextPath}/adm/plana-directiva/save" class="form-admin" id="directivaForm">
                <div class="modal-body">
                    <input type="hidden" name="id" id="formId" value="">

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label" for="formNombre">Nombre *</label>
                                <input type="text" class="form-control" id="formNombre" name="nombre" required placeholder="Nombre completo">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label" for="formOrden">Orden</label>
                                <input type="number" class="form-control" id="formOrden" name="orden" value="0" min="0">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="formCargo">Cargo</label>
                        <input type="text" class="form-control" id="formCargo" name="cargo" placeholder="Ej: Director OTI">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="formDescripcion">Descripcion</label>
                        <textarea class="form-control" id="formDescripcion" name="descripcion" rows="2" placeholder="Breve descripcion del miembro"></textarea>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label" for="formLinkedin">LinkedIn URL</label>
                                <input type="url" class="form-control" id="formLinkedin" name="linkedin_url" placeholder="https://linkedin.com/in/...">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label" for="formTwitter">Twitter URL</label>
                                <input type="url" class="form-control" id="formTwitter" name="twitter_url" placeholder="https://twitter.com/...">
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label">Foto</label>
                                <div class="upload-area" onclick="document.getElementById('fileInput').click()" style="padding: 20px;">
                                    <input type="file" id="fileInput" accept="image/*" style="display: none;" onchange="previewImage(this)">
                                    <div id="uploadPlaceholder" style="display: flex; align-items: center; gap: 12px; text-align: left;">
                                        <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" style="width: 28px; height: 28px; margin: 0;"><circle cx="12" cy="8" r="5"></circle><path d="M20 21a8 8 0 1 0-16 0"></path></svg>
                                        <div>
                                            <div class="upload-area-text" style="margin: 0;">Click para subir foto</div>
                                            <div class="upload-area-hint" style="margin: 0;">JPG, PNG (recomendado 400x400px)</div>
                                        </div>
                                    </div>
                                    <div id="uploadPreview" style="display: none;">
                                        <div class="upload-preview">
                                            <img id="previewImg" src="" alt="Preview" style="max-width: 120px; max-height: 120px; border-radius: 50%;">
                                            <button type="button" class="upload-preview-remove" onclick="removePreview(event)">&times;</button>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="foto_url" id="formFotoUrl" value="">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label">&nbsp;</label>
                                <div class="form-check form-switch" style="padding-top: 6px;">
                                    <input class="form-check-input" type="checkbox" id="formActivo" name="activo" checked>
                                    <label class="form-check-label form-switch-label" for="formActivo">Activo</label>
                                </div>
                            </div>
                        </div>
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
                var rows = document.querySelectorAll('#tableBody tr');
                var ids = [];
                rows.forEach(function(row) { ids.push(row.dataset.id); });
                fetch('${pageContext.request.contextPath}/adm/plana-directiva/reorder', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'orden[]=' + ids.join('&orden[]=')
                }).then(function(r) { return r.json(); })
                  .then(function(d) { if (d.ok) showToast('success', 'Orden actualizado'); });
            }
        });
    }
});

function openModal(btn) {
    var modal = document.getElementById('directivaModal');
    var title = document.getElementById('modalTitle');

    if (btn) {
        title.textContent = 'Editar miembro';
        document.getElementById('formId').value = btn.dataset.id;
        document.getElementById('formNombre').value = btn.dataset.nombre || '';
        document.getElementById('formCargo').value = btn.dataset.cargo || '';
        document.getElementById('formDescripcion').value = btn.dataset.descripcion || '';
        document.getElementById('formLinkedin').value = btn.dataset.linkedinUrl || '';
        document.getElementById('formTwitter').value = btn.dataset.twitterUrl || '';
        document.getElementById('formOrden').value = btn.dataset.orden || 0;
        document.getElementById('formActivo').checked = btn.dataset.activo === 'true';
        document.getElementById('formFotoUrl').value = btn.dataset.fotoUrl || '';

        if (btn.dataset.fotoUrl) {
            document.getElementById('previewImg').src = btn.dataset.fotoUrl;
            document.getElementById('uploadPlaceholder').style.display = 'none';
            document.getElementById('uploadPreview').style.display = 'block';
        } else {
            document.getElementById('uploadPlaceholder').style.display = 'flex';
            document.getElementById('uploadPreview').style.display = 'none';
        }
    } else {
        title.textContent = 'Nuevo miembro';
        document.getElementById('directivaForm').reset();
        document.getElementById('formId').value = '';
        document.getElementById('formOrden').value = '0';
        document.getElementById('formActivo').checked = true;
        document.getElementById('formFotoUrl').value = '';
        document.getElementById('uploadPlaceholder').style.display = 'flex';
        document.getElementById('uploadPreview').style.display = 'none';
    }

    document.getElementById('fileInput').value = '';
    new bootstrap.Modal(modal).show();
}

function filterTable() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var rows = document.querySelectorAll('#tableBody tr');
    rows.forEach(function(row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.includes(search) ? '' : 'none';
    });
}

function previewImage(input) {
    if (!input.files || !input.files[0]) return;
    var file = input.files[0];
    if (file.size > 5 * 1024 * 1024) { showToast('warning', 'Maximo 5MB'); input.value = ''; return; }

    var fd = new FormData();
    fd.append('file', file);

    document.getElementById('uploadPlaceholder').style.display = 'none';

    var spinner = document.getElementById('uploadSpinner');
    if (!spinner) {
        spinner = document.createElement('div');
        spinner.id = 'uploadSpinner';
        spinner.style.cssText = 'text-align:center;padding:20px;';
        spinner.innerHTML = '<div class="admin-spinner" style="margin: 0 auto;"></div><div style="font-size:0.82rem;color:var(--default-color);margin-top:8px;">Subiendo...</div>';
        document.querySelector('#directivaModal .upload-area').appendChild(spinner);
    }
    spinner.style.display = 'block';

    fetch('${pageContext.request.contextPath}/adm/plana-directiva/upload-image', {
        method: 'POST', body: fd
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        spinner.style.display = 'none';
        if (d.url) {
            document.getElementById('formFotoUrl').value = d.url;
            document.getElementById('previewImg').src = d.url;
            document.getElementById('uploadPreview').style.display = 'block';
        } else {
            showToast('error', d.error || 'Error al subir');
            document.getElementById('uploadPlaceholder').style.display = 'flex';
            input.value = '';
        }
      }).catch(function() {
        spinner.style.display = 'none';
        showToast('error', 'Error de conexion');
        document.getElementById('uploadPlaceholder').style.display = 'flex';
        input.value = '';
      });
}

function removePreview(e) {
    e.stopPropagation();
    document.getElementById('fileInput').value = '';
    document.getElementById('formFotoUrl').value = '';
    document.getElementById('uploadPlaceholder').style.display = 'flex';
    document.getElementById('uploadPreview').style.display = 'none';
}
</script>
