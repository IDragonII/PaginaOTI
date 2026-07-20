<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.AdminUser" %>
<%
    AdminUser adminUser = (AdminUser) session.getAttribute("adminUser");
    if (adminUser == null) {
        response.sendRedirect(request.getContextPath() + "/adm/login");
        return;
    }

    String currentSection = (String) request.getAttribute("currentSection");
    String pageTitle = (String) request.getAttribute("pageTitle");
    if (currentSection == null) currentSection = "dashboard";
    if (pageTitle == null) pageTitle = "Dashboard";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin OTI - <%= pageTitle %></title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <link href="https://oti.unap.edu.pe/recursos/oti-icon.png" rel="icon">
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/assets/css/main.css" rel="stylesheet">
    <link href="/assets/css/admin.css" rel="stylesheet">
</head>
<body>

<div class="admin-wrapper">

    <!-- Overlay mobile -->
    <div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

    <!-- Sidebar -->
    <aside class="admin-sidebar" id="adminSidebar">

        <div class="sidebar-brand">
            <img src="../../assets/img/oti_logo.png" alt="OTI">
            <span class="sidebar-brand-text">OTI Admin</span>
        </div>

        <button class="sidebar-toggle" onclick="toggleSidebar()" title="Toggle menu">
            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 18 9 12 15 6"></polyline></svg>
        </button>

        <nav class="sidebar-nav">

            <div class="sidebar-nav-label">Principal</div>

            <a href="${pageContext.request.contextPath}/adm/" class="sidebar-nav-item <%= currentSection.equals("dashboard") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                <span>Dashboard</span>
            </a>

            <div class="sidebar-nav-divider"></div>
            <div class="sidebar-nav-label">Contenido</div>

            <a href="${pageContext.request.contextPath}/adm/actividades" class="sidebar-nav-item <%= currentSection.equals("actividades") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                <span>Actividades</span>
            </a>

            <a href="${pageContext.request.contextPath}/adm/plana-directiva" class="sidebar-nav-item <%= currentSection.equals("plana-directiva") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                <span>Plana Directiva</span>
            </a>

            <a href="${pageContext.request.contextPath}/adm/servicios" class="sidebar-nav-item <%= currentSection.equals("servicios") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                <span>Servicios</span>
            </a>

            <a href="${pageContext.request.contextPath}/adm/unidades" class="sidebar-nav-item <%= currentSection.equals("unidades") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                <span>Unidades</span>
            </a>

            <a href="${pageContext.request.contextPath}/adm/documentos" class="sidebar-nav-item <%= currentSection.equals("documentos") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line></svg>
                <span>Documentación</span>
            </a>

            <a href="${pageContext.request.contextPath}/adm/configuracion" class="sidebar-nav-item <%= currentSection.equals("configuracion") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
                <span>Configuracion</span>
            </a>

            <% if (adminUser.isSuperadmin()) { %>
            <div class="sidebar-nav-divider"></div>
            <div class="sidebar-nav-label">Sistema</div>

            <a href="${pageContext.request.contextPath}/adm/usuarios" class="sidebar-nav-item <%= currentSection.equals("usuarios") ? "active" : "" %>">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                <span>Usuarios</span>
            </a>
            <% } %>

        </nav>

        <div class="sidebar-footer">
            <div class="sidebar-footer-avatar">
                <%= adminUser.nombre != null ? adminUser.nombre.substring(0, 1).toUpperCase() : "A" %>
            </div>
            <div class="sidebar-footer-info">
                <div class="sidebar-footer-name"><%= adminUser.nombre %></div>
                <div class="sidebar-footer-role"><%= adminUser.rol %></div>
            </div>
            <a href="${pageContext.request.contextPath}/adm/logout" class="sidebar-footer-logout" title="Cerrar sesion">
                <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
            </a>
        </div>

    </aside>

    <!-- Main Content -->
    <main class="admin-main">

        <header class="admin-header">
            <div style="display: flex; align-items: center; gap: 12px;">
                <button class="mobile-menu-btn" onclick="toggleSidebar()">
                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
                </button>
                <div>
                    <h1 class="page-title"><%= pageTitle %></h1>
                </div>
            </div>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/" target="_blank" class="btn-admin btn-admin-secondary" style="font-size: 0.8rem; padding: 7px 14px;">
                    <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                    Ver sitio
                </a>
            </div>
        </header>

        <div class="admin-content">
            <%-- Content injected here --%>
            <% if (currentSection.equals("dashboard")) { %>
                <jsp:include page="dashboard.jsp" />
            <% } else if (currentSection.equals("actividades")) { %>
                <jsp:include page="actividades/list.jsp" />
            <% } else if (currentSection.equals("plana-directiva")) { %>
                <jsp:include page="plana-directiva/list.jsp" />
            <% } else if (currentSection.equals("servicios")) { %>
                <jsp:include page="servicios/list.jsp" />
            <% } else if (currentSection.equals("unidades")) { %>
                <jsp:include page="unidades/list.jsp" />
            <% } else if (currentSection.equals("documentos")) { %>
                <jsp:include page="documentos/list.jsp" />
            <% } else if (currentSection.equals("configuracion")) { %>
                <jsp:include page="configuracion/index.jsp" />
            <% } else if (currentSection.equals("usuarios")) { %>
                <jsp:include page="usuarios/list.jsp" />
            <% } %>
        </div>

    </main>

</div>

<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15/Sortable.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
function toggleSidebar() {
    var sidebar = document.getElementById('adminSidebar');
    var overlay = document.getElementById('sidebarOverlay');
    var isMobile = window.innerWidth <= 992;

    if (isMobile) {
        sidebar.classList.toggle('mobile-open');
        overlay.classList.toggle('active');
    } else {
        sidebar.classList.toggle('collapsed');
    }
}

// Cerrar sidebar en mobile al hacer click fuera
document.addEventListener('click', function(e) {
    var sidebar = document.getElementById('adminSidebar');
    var overlay = document.getElementById('sidebarOverlay');
    if (window.innerWidth <= 992 && sidebar.classList.contains('mobile-open')) {
        if (!sidebar.contains(e.target) && !e.target.closest('.mobile-menu-btn')) {
            sidebar.classList.remove('mobile-open');
            overlay.classList.remove('active');
        }
    }
});

// Cerrar sidebar en resize si pasa a desktop
window.addEventListener('resize', function() {
    var sidebar = document.getElementById('adminSidebar');
    var overlay = document.getElementById('sidebarOverlay');
    if (window.innerWidth > 992) {
        sidebar.classList.remove('mobile-open');
        overlay.classList.remove('active');
    }
});

// Toast helper
function showToast(icon, title) {
    Swal.fire({
        toast: true,
        position: 'top-end',
        icon: icon,
        title: title,
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true
    });
}

// Confirm delete
function confirmDelete(url) {
    Swal.fire({
        title: 'Eliminar registro',
        text: 'Esta accion no se puede deshacer',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#EF4444',
        cancelButtonColor: '#6B7280',
        confirmButtonText: 'Si, eliminar',
        cancelButtonText: 'Cancelar'
    }).then(function(result) {
        if (result.isConfirmed) {
            fetch(url, { method: 'POST' })
                .then(function() { window.location.reload(); });
        }
    });
}
</script>

</body>
</html>
