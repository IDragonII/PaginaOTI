<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.AdminUser" %>
<%@ page import="java.util.List" %>
<%
    List<AdminUser> users = AdminUser.getAll();
    AdminUser currentUser = (AdminUser) session.getAttribute("adminUser");
%>

<!-- Toolbar -->
<div class="admin-toolbar" style="margin-bottom: 20px;">
    <div class="toolbar-search">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
        <input type="text" id="searchInput" placeholder="Buscar usuario..." oninput="filterTable()">
    </div>
    <button class="btn-admin btn-admin-primary" onclick="openModal()">
        <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
        Nuevo usuario
    </button>
</div>

<!-- Table Card -->
<div class="admin-card">
    <div class="admin-card-body">
            <div class="table-responsive-wrapper">
            <table class="admin-table" id="usuariosTable">
                <thead>
                    <tr>
                        <th>Usuario</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th style="width: 100px;">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <% for (AdminUser u : users) { %>
                    <tr data-id="<%= u.id %>">
                        <td data-label="Usuario">
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <div class="sidebar-footer-avatar" style="width: 36px; height: 36px; font-size: 0.82rem;">
                                    <%= u.nombre != null ? u.nombre.substring(0, 1).toUpperCase() : "?" %>
                                </div>
                                <span class="table-title"><%= u.username %></span>
                            </div>
                        </td>
                        <td data-label="Nombre"><span style="color: var(--default-color);"><%= u.nombre != null ? u.nombre : "" %></span></td>
                        <td data-label="Email"><span style="color: var(--default-color);"><%= u.email != null ? u.email : "" %></span></td>
                        <td data-label="Rol">
                            <span class="badge-status" style="background: rgba(139,92,246,0.1); color: #7C3AED;">
                                <%= u.rol != null ? u.rol.toUpperCase() : "" %>
                            </span>
                        </td>
                        <td data-label="Estado">
                            <span class="badge-status <%= u.activo ? "badge-active" : "badge-inactive" %>">
                                <%= u.activo ? "Activo" : "Inactivo" %>
                            </span>
                        </td>
                        <td data-label="Acciones">
                        <div class="action-btn-group">
                            <% if (u.id != currentUser.id) { %>
                                <button class="action-btn" title="Editar"
                                    data-id="<%= u.id %>"
                                    data-username="<%= u.username %>"
                                    data-nombre="<%= u.nombre != null ? u.nombre : "" %>"
                                    data-email="<%= u.email != null ? u.email : "" %>"
                                    data-rol="<%= u.rol %>"
                                    data-activo="<%= u.activo %>"
                                    onclick="openModal(this)">
                                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
                                </button>
                                <button class="action-btn danger" title="Eliminar" onclick="confirmDelete('${pageContext.request.contextPath}/adm/usuarios/delete?id=<%= u.id %>')">
                                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                                </button>
                            <% } else { %>
                                <span style="font-size: 0.75rem; color: var(--default-color); opacity: 0.5;">Tu cuenta</span>
                            <% } %>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
            </table>
            </div>
    </div>
</div>

<!-- Modal Form -->
<div class="modal fade modal-admin" id="usuarioModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Nuevo usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="${pageContext.request.contextPath}/adm/usuarios/save" class="form-admin" id="usuarioForm">
                <div class="modal-body">
                    <input type="hidden" name="id" id="formId" value="">

                    <div class="form-group">
                        <label class="form-label" for="formUsername">Usuario *</label>
                        <input type="text" class="form-control" id="formUsername" name="username" required
                               placeholder="Nombre de usuario" minlength="4">
                    </div>

                    <div class="form-group" id="passwordGroup">
                        <label class="form-label" for="formPassword">Contrasena *</label>
                        <input type="password" class="form-control" id="formPassword" name="password"
                               placeholder="Minimo 6 caracteres" minlength="6">
                        <div class="form-text">Dejar vacio para mantener la contrasena actual (al editar)</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="formNombre">Nombre completo</label>
                        <input type="text" class="form-control" id="formNombre" name="nombre"
                               placeholder="Nombre y apellido">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="formEmail">Email</label>
                        <input type="email" class="form-control" id="formEmail" name="email"
                               placeholder="correo@unap.edu.pe">
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label class="form-label" for="formRol">Rol</label>
                                <select class="form-select" id="formRol" name="rol">
                                    <option value="editor">Editor</option>
                                    <option value="superadmin">Superadmin</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
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
function openModal(btn) {
    var modal = document.getElementById('usuarioModal');
    var title = document.getElementById('modalTitle');
    var passwordGroup = document.getElementById('passwordGroup');

    if (btn) {
        title.textContent = 'Editar usuario';
        document.getElementById('formId').value = btn.dataset.id;
        document.getElementById('formUsername').value = btn.dataset.username || '';
        document.getElementById('formNombre').value = btn.dataset.nombre || '';
        document.getElementById('formEmail').value = btn.dataset.email || '';
        document.getElementById('formRol').value = btn.dataset.rol || 'editor';
        document.getElementById('formActivo').checked = btn.dataset.activo === 'true';
        document.getElementById('formPassword').required = false;
        passwordGroup.style.display = 'none';
    } else {
        title.textContent = 'Nuevo usuario';
        document.getElementById('usuarioForm').reset();
        document.getElementById('formId').value = '';
        document.getElementById('formActivo').checked = true;
        document.getElementById('formPassword').required = true;
        passwordGroup.style.display = '';
    }

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
</script>
