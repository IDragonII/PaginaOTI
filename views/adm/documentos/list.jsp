<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.Documento" %>
<%@ page import="java.util.List" %>
<%
    List<Documento> documentos = Documento.getAll();
%>

<!-- Toolbar -->
<div class="admin-toolbar" style="margin-bottom: 20px;">
    <div class="toolbar-search">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        <input type="text" id="searchInput" placeholder="Buscar documento..." oninput="filterTable()">
    </div>
    <div class="toolbar-filter">
        <button class="filter-btn active" onclick="filterStatus('all', this)">Todos</button>
        <button class="filter-btn" onclick="filterStatus('active', this)">Activos</button>
        <button class="filter-btn" onclick="filterStatus('inactive', this)">Inactivos</button>
    </div>
    <button class="btn-admin btn-admin-primary" onclick="openModal()">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        Nuevo documento
    </button>
</div>

<!-- Table Card -->
<div class="admin-card">
    <div class="admin-card-body">
        <% if (documentos.isEmpty()) { %>
            <div class="empty-state">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                <div class="empty-state-title">Sin documentos</div>
                <div class="empty-state-desc">Crea tu primer documento normativo para la seccion de documentacion</div>
                <button class="btn-admin btn-admin-primary" onclick="openModal()">
                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                    Crear documento
                </button>
            </div>
        <% } else { %>
            <div class="table-responsive-wrapper">
            <table class="admin-table" id="documentosTable">
                <thead>
                    <tr>
                        <th style="width: 32px;"></th>
                        <th>Titulo</th>
                        <th class="col-desc">Descripcion</th>
                        <th style="width: 90px;">Tipo</th>
                        <th class="col-enlace" style="width: 90px;">Fuente</th>
                        <th style="width: 80px;">Estado</th>
                        <th style="width: 72px;">Acc</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <% for (Documento d : documentos) { %>
                    <tr data-id="<%= d.id %>" data-active="<%= d.activo %>">
                        <td data-label="">
                            <span class="drag-handle" title="Arrastrar para ordenar">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="5" r="1"></circle><circle cx="15" cy="5" r="1"></circle><circle cx="9" cy="12" r="1"></circle><circle cx="15" cy="12" r="1"></circle><circle cx="9" cy="19" r="1"></circle><circle cx="15" cy="19" r="1"></circle></svg>
                            </span>
                        </td>
                        <td data-label="Titulo">
                            <span class="table-title" style="font-size: 0.85rem;"><%= d.titulo %></span>
                        </td>
                        <td data-label="Descripcion" class="col-desc">
                            <span class="table-text-truncate" style="max-width: 260px; display: block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--default-color);"><%= d.descripcion != null ? d.descripcion : "" %></span>
                        </td>
                        <td data-label="Tipo">
                            <span class="badge-status badge-active" style="font-size: 0.65rem; padding: 2px 8px;"><%= d.tipo != null && !d.tipo.isEmpty() ? d.tipo : "-" %></span>
                        </td>
                        <td data-label="Fuente" class="col-enlace">
                            <% if (d.archivoUrl != null && !d.archivoUrl.isEmpty()) { %>
                                <a href="<%= d.archivoUrl %>" target="_blank" class="table-link" style="font-size: 0.78rem; white-space: nowrap;">
                                    PDF local
                                </a>
                            <% } else if (d.url != null && !d.url.isEmpty()) { %>
                                <a href="<%= d.url %>" target="_blank" class="table-link" style="font-size: 0.78rem; white-space: nowrap;">
                                    URL ext.
                                </a>
                            <% } else { %>
                                <span style="color: var(--default-color); opacity: 0.4;">-</span>
                            <% } %>
                        </td>
                        <td data-label="Estado">
                            <span class="badge-status <%= d.activo ? "badge-active" : "badge-inactive" %>" style="font-size: 0.65rem; padding: 2px 8px;">
                                <%= d.activo ? "Activo" : "Inactivo" %>
                            </span>
                        </td>
                        <td data-label="Acciones">
                            <div class="action-btn-group" style="gap: 4px;">
                                <button class="action-btn" title="Editar" style="width: 28px; height: 28px;"
                                    data-id="<%= d.id %>"
                                    data-titulo="<%= d.titulo != null ? d.titulo : "" %>"
                                    data-descripcion="<%= d.descripcion != null ? d.descripcion : "" %>"
                                    data-url="<%= d.url != null ? d.url : "" %>"
                                    data-archivo-url="<%= d.archivoUrl != null ? d.archivoUrl : "" %>"
                                    data-tipo="<%= d.tipo != null ? d.tipo : "" %>"
                                    data-orden="<%= d.orden %>"
                                    data-activo="<%= d.activo %>"
                                    onclick="openModal(this)">
                                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
                                </button>
                                <button class="action-btn danger" title="Eliminar" style="width: 28px; height: 28px;" onclick="confirmDelete('${pageContext.request.contextPath}/adm/documentos/delete?id=<%= d.id %>')">
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
<div class="modal fade modal-admin" id="documentoModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Nuevo documento</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="${pageContext.request.contextPath}/adm/documentos/save" class="form-admin" id="documentoForm">
                <div class="modal-body">
                    <input type="hidden" name="id" id="formId" value="">
                    <input type="hidden" name="archivo_url" id="formArchivoUrl" value="">

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label" for="formTitulo">Titulo *</label>
                                <input type="text" class="form-control" id="formTitulo" name="titulo" required placeholder="Titulo del documento">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label" for="formTipo">Tipo</label>
                                <input type="text" class="form-control" id="formTipo" name="tipo" placeholder="ej: Norma, Ley, Reglamento">
                            </div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-md-8">
                            <div class="form-group">
                                <label class="form-label" for="formDescripcion">Descripcion</label>
                                <textarea class="form-control" id="formDescripcion" name="descripcion" rows="3" placeholder="Descripcion breve del documento"></textarea>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="form-label" for="formOrden">Orden</label>
                                <input type="number" class="form-control" id="formOrden" name="orden" value="0" min="0">
                            </div>
                            <div class="form-group" style="margin-top: 12px;">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="formActivo" name="activo" checked>
                                    <label class="form-check-label form-switch-label" for="formActivo">Activo</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Documento PDF (subir archivo o pegar URL externa)</label>
                        <div class="upload-area" id="uploadArea" onclick="document.getElementById('fileInput').click()">
                            <input type="file" id="fileInput" accept=".pdf" style="display: none;" onchange="previewDoc(this)">
                            <div id="uploadPlaceholder">
                                <svg viewBox="0 0 24 24" fill="none" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
                                <div class="upload-area-text">Click para subir PDF</div>
                                <div class="upload-area-hint">Solo archivos PDF (max 10MB)</div>
                            </div>
                            <div id="uploadPreview" style="display: none;">
                                <div class="upload-preview">
                                    <div id="previewDocName" style="font-size: 0.9rem; font-weight: 600; color: #0F172A;"></div>
                                    <button type="button" class="upload-preview-remove" onclick="removeDoc(event)">&times;</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group" style="margin-top: 12px;">
                        <label class="form-label" for="formUrl">URL externa (si no sube archivo)</label>
                        <input type="url" class="form-control" id="formUrl" name="url" placeholder="https://...">
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
var docPending = null;

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
    var modal = document.getElementById('documentoModal');
    var title = document.getElementById('modalTitle');

    if (btn) {
        title.textContent = 'Editar documento';
        document.getElementById('formId').value = btn.dataset.id;
        document.getElementById('formTitulo').value = btn.dataset.titulo || '';
        document.getElementById('formDescripcion').value = btn.dataset.descripcion || '';
        document.getElementById('formUrl').value = btn.dataset.url || '';
        document.getElementById('formArchivoUrl').value = btn.dataset.archivoUrl || '';
        document.getElementById('formTipo').value = btn.dataset.tipo || '';
        document.getElementById('formOrden').value = btn.dataset.orden || 0;
        document.getElementById('formActivo').checked = btn.dataset.activo === 'true';

        if (btn.dataset.archivoUrl) {
            var parts = btn.dataset.archivoUrl.split('/');
            document.getElementById('previewDocName').textContent = parts[parts.length - 1];
            document.getElementById('uploadPlaceholder').style.display = 'none';
            document.getElementById('uploadPreview').style.display = 'block';
        } else {
            document.getElementById('uploadPlaceholder').style.display = '';
            document.getElementById('uploadPreview').style.display = 'none';
        }
    } else {
        title.textContent = 'Nuevo documento';
        document.getElementById('documentoForm').reset();
        document.getElementById('formId').value = '';
        document.getElementById('formArchivoUrl').value = '';
        document.getElementById('formOrden').value = '0';
        document.getElementById('formActivo').checked = true;
        document.getElementById('uploadPlaceholder').style.display = '';
        document.getElementById('uploadPreview').style.display = 'none';
    }

    docPending = null;
    document.getElementById('fileInput').value = '';
    new bootstrap.Modal(modal).show();
}

function previewDoc(input) {
    if (!input.files || !input.files[0]) return;
    var file = input.files[0];
    if (file.size > 10 * 1024 * 1024) { showToast('warning', 'Maximo 10MB'); input.value = ''; return; }

    docPending = file;
    document.getElementById('previewDocName').textContent = file.name;
    document.getElementById('uploadPlaceholder').style.display = 'none';
    document.getElementById('uploadPreview').style.display = 'block';
}

function removeDoc(e) {
    e.stopPropagation();
    docPending = null;
    document.getElementById('fileInput').value = '';
    document.getElementById('formArchivoUrl').value = '';
    document.getElementById('uploadPlaceholder').style.display = '';
    document.getElementById('uploadPreview').style.display = 'none';
}

document.getElementById('documentoForm').addEventListener('submit', function(e) {
    if (!docPending) return;
    e.preventDefault();

    var form = this;
    var fd = new FormData();
    fd.append('file', docPending);

    fetch('${pageContext.request.contextPath}/adm/documentos/upload-doc', {
        method: 'POST', body: fd
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.url) {
            document.getElementById('formArchivoUrl').value = d.url;
            docPending = null;
            form.submit();
        } else {
            showToast('error', d.error || 'Error al subir');
        }
      }).catch(function() {
        showToast('error', 'Error de conexion');
      });
});

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

    fetch('${pageContext.request.contextPath}/adm/documentos/reorder', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'ids=' + ids.join(',')
    }).then(function(r) { return r.json(); })
      .then(function(d) { if (d.ok) showToast('success', 'Orden actualizado'); });
}
</script>
