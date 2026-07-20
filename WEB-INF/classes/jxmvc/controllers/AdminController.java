package jxmvc.controllers;

import jxmvc.models.AdminUser;
import jxmvc.models.Actividad;
import jxmvc.models.Documento;
import jxmvc.models.Enlace;
import jxmvc.models.PlanaDirectiva;
import jxmvc.models.Configuracion;
import jxmvc.models.Servicio;
import jxmvc.models.Unidad;
import jxmvc.utils.FileStorage;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.MultipartConfig;

/**
 * Controlador para rutas /adm/*
 * Maneja el panel de administración.
 */
@MultipartConfig
public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();
        if (path == null) path = "/";

        // Login / Logout
        if (path.equals("/login") || path.equals("/login/")) {
            forward("/views/adm/login.jsp", request, response);
            return;
        }

        if (path.equals("/logout") || path.equals("/logout/")) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/adm/login");
            return;
        }

        // Verificar autenticación
        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/adm/login");
            return;
        }

        // Dashboard (raíz admin)
        if (path.equals("/") || path.equals("")) {
            request.setAttribute("pageTitle", "Dashboard");
            request.setAttribute("currentSection", "dashboard");
            forward("/views/adm/layout.jsp", request, response);
            return;
        }

        // ── Actividades ─────────────────────────────────────────
        if (path.startsWith("/actividades")) {
            handleActividades(path, request, response);
            return;
        }

        // ── Plana Directiva ─────────────────────────────────────
        if (path.startsWith("/plana-directiva")) {
            handlePlanaDirectiva(path, request, response);
            return;
        }

        // ── Servicios ───────────────────────────────────────────
        if (path.startsWith("/servicios")) {
            handleServicios(path, request, response);
            return;
        }

        // ── Unidades ───────────────────────────────────────────
        if (path.startsWith("/unidades")) {
            handleUnidades(path, request, response);
            return;
        }

        // ── Documentos ──────────────────────────────────────────
        if (path.startsWith("/documentos")) {
            handleDocumentos(path, request, response);
            return;
        }

        // ── Configuración ───────────────────────────────────────
        if (path.equals("/configuracion") || path.equals("/configuracion/")) {
            request.setAttribute("pageTitle", "Configuración");
            request.setAttribute("currentSection", "configuracion");
            request.setAttribute("config", Configuracion.getAll());
            forward("/views/adm/layout.jsp", request, response);
            return;
        }

        // ── Usuarios ─────────────────────────────────────────────
        if (path.startsWith("/usuarios")) {
            handleUsuarios(path, request, response);
            return;
        }

        // 404
        response.sendError(404);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();
        if (path == null) path = "/";

        // Login POST
        if (path.equals("/login") || path.equals("/login/")) {
            handleLogin(request, response);
            return;
        }

        // Verificar auth para otros POSTs
        if (!isAuthenticated(request)) {
            response.sendRedirect(request.getContextPath() + "/adm/login");
            return;
        }

        // ── Actividades POST ────────────────────────────────────
        if (path.equals("/actividades/save")) {
            handleActividadSave(request, response);
            return;
        }
        if (path.equals("/actividades/delete")) {
            handleActividadDelete(request, response);
            return;
        }
        if (path.equals("/actividades/reorder")) {
            handleActividadReorder(request, response);
            return;
        }
        if (path.equals("/actividades/upload-image")) {
            handleActividadUploadImage(request, response);
            return;
        }
        if (path.equals("/actividades/delete-image")) {
            handleActividadDeleteImage(request, response);
            return;
        }

        // ── Servicios POST ──────────────────────────────────────
        if (path.equals("/servicios/save")) {
            handleServicioSave(request, response);
            return;
        }
        if (path.equals("/servicios/delete")) {
            handleServicioDelete(request, response);
            return;
        }
        if (path.equals("/servicios/reorder")) {
            handleServicioReorder(request, response);
            return;
        }
        if (path.equals("/servicios/upload-image")) {
            handleServicioUploadImage(request, response);
            return;
        }
        if (path.equals("/servicios/delete-image")) {
            handleServicioDeleteImage(request, response);
            return;
        }

        // ── Unidades POST ──────────────────────────────────────
        if (path.equals("/unidades/save")) {
            handleUnidadSave(request, response);
            return;
        }
        if (path.equals("/unidades/delete")) {
            handleUnidadDelete(request, response);
            return;
        }
        if (path.equals("/unidades/reorder")) {
            handleUnidadReorder(request, response);
            return;
        }

        // ── Documentos POST ────────────────────────────────────
        if (path.equals("/documentos/save")) {
            handleDocumentoSave(request, response);
            return;
        }
        if (path.equals("/documentos/delete")) {
            handleDocumentoDelete(request, response);
            return;
        }
        if (path.equals("/documentos/reorder")) {
            handleDocumentoReorder(request, response);
            return;
        }
        if (path.equals("/documentos/upload-doc")) {
            handleDocumentoUploadDoc(request, response);
            return;
        }
        if (path.equals("/documentos/delete-doc")) {
            handleDocumentoDeleteDoc(request, response);
            return;
        }

        // ── Plana Directiva POST ────────────────────────────────
        if (path.equals("/plana-directiva/save")) {
            handlePlanaDirectivaSave(request, response);
            return;
        }
        if (path.equals("/plana-directiva/delete")) {
            handlePlanaDirectivaDelete(request, response);
            return;
        }
        if (path.equals("/plana-directiva/upload-image")) {
            handlePlanaDirectivaUploadImage(request, response);
            return;
        }
        if (path.equals("/plana-directiva/delete-image")) {
            handlePlanaDirectivaDeleteImage(request, response);
            return;
        }

        // ── Configuración POST ──────────────────────────────────
        if (path.equals("/configuracion/save")) {
            handleConfigSave(request, response);
            return;
        }
        if (path.equals("/configuracion/upload-image")) {
            handleConfigUploadImage(request, response);
            return;
        }
        if (path.equals("/configuracion/upload-firma")) {
            handleConfigUploadFirma(request, response);
            return;
        }
        if (path.equals("/configuracion/delete-image")) {
            handleConfigDeleteImage(request, response);
            return;
        }

        // ── Usuarios POST ───────────────────────────────────────
        if (path.equals("/usuarios/save")) {
            handleUsuarioSave(request, response);
            return;
        }
        if (path.equals("/usuarios/delete")) {
            handleUsuarioDelete(request, response);
            return;
        }

        response.sendError(404);
    }

    // ══════════════════════════════════════════════════════════════
    // Auth helpers
    // ══════════════════════════════════════════════════════════════

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("adminUser") != null;
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminUser user = AdminUser.getByUsername(username);

        if (user != null && user.checkPassword(password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("adminUser", user);
            session.setAttribute("adminNombre", user.nombre);
            session.setAttribute("adminRol", user.rol);
            response.sendRedirect(request.getContextPath() + "/adm/");
        } else {
            request.setAttribute("error", "Credenciales inválidas");
            forward("/views/adm/login.jsp", request, response);
        }
    }

    // ══════════════════════════════════════════════════════════════
    // Actividades
    // ══════════════════════════════════════════════════════════════

    private void handleActividades(String path, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Actividades");
        request.setAttribute("currentSection", "actividades");
        request.setAttribute("actividades", Actividad.getAll());
        forward("/views/adm/layout.jsp", request, response);
    }

    private void handleActividadSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Actividad a = new Actividad();
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            a.id = Integer.parseInt(idParam);
        }
        a.titulo = request.getParameter("titulo");
        a.tipo = request.getParameter("tipo");
        a.descripcion = request.getParameter("descripcion");
        String newImageUrl = request.getParameter("imagen_url");
        if (newImageUrl == null) newImageUrl = "";
        a.orden = Integer.parseInt(request.getParameter("orden") != null ? request.getParameter("orden") : "0");
        a.activo = "on".equals(request.getParameter("activo"));

        if (a.id > 0) {
            Actividad old = Actividad.getById(a.id);
            a.imagenUrl = newImageUrl;
            if (old != null && old.imagenUrl != null && !old.imagenUrl.equals(newImageUrl)) {
                FileStorage.deleteImage(old.imagenUrl);
            }
            a.enlaceId = guardarEnlace(request, old != null ? old.enlaceId : 0);
            Actividad.update(a);
        } else {
            a.imagenUrl = newImageUrl;
            a.enlaceId = guardarEnlace(request, 0);
            Actividad.create(a);
        }

        response.sendRedirect(request.getContextPath() + "/adm/actividades");
    }

    private void handleActividadDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Actividad a = Actividad.getById(id);
            if (a != null) {
                if (a.imagenUrl != null) FileStorage.deleteImage(a.imagenUrl);
                if (a.enlaceId > 0) Enlace.delete(a.enlaceId);
            }
            Actividad.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/adm/actividades");
    }

    private void handleActividadUploadImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        try {
            Part file = request.getPart("file");
            if (file == null || file.getSize() == 0) {
                response.getWriter().write("{\"error\":\"No file\"}");
                return;
            }
            if (!FileStorage.isValidImage(file)) {
                response.getWriter().write("{\"error\":\"Invalid file (max 5MB, image only)\"}");
                return;
            }
            String url = FileStorage.saveImage(file, "notis");
            if (url != null) {
                response.getWriter().write("{\"url\":\"" + url + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"Upload failed\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleActividadDeleteImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Actividad a = Actividad.getById(id);
            if (a != null && a.imagenUrl != null) {
                FileStorage.deleteImage(a.imagenUrl);
                a.imagenUrl = null;
                Actividad.update(a);
            }
        }
        response.getWriter().write("{\"ok\":true}");
    }

    private void handleActividadReorder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String[] ids = request.getParameterValues("orden[]");
        if (ids != null) {
            java.util.List<Integer> idList = new java.util.ArrayList<>();
            for (String id : ids) idList.add(Integer.parseInt(id));
            Actividad.reorder(idList);
        }
        response.setContentType("application/json");
        response.getWriter().write("{\"ok\":true}");
    }

    // ══════════════════════════════════════════════════════════════
    // Plana Directiva
    // ══════════════════════════════════════════════════════════════

    private void handlePlanaDirectiva(String path, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Plana Directiva");
        request.setAttribute("currentSection", "plana-directiva");
        request.setAttribute("directiva", PlanaDirectiva.getAll());
        forward("/views/adm/layout.jsp", request, response);
    }

    private void handlePlanaDirectivaSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        PlanaDirectiva p = new PlanaDirectiva();
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            p.id = Integer.parseInt(idParam);
        }
        p.nombre = request.getParameter("nombre");
        p.cargo = request.getParameter("cargo");
        p.descripcion = request.getParameter("descripcion");
        String newFotoUrl = request.getParameter("foto_url");
        if (newFotoUrl == null) newFotoUrl = "";
        p.linkedinUrl = request.getParameter("linkedin_url");
        p.twitterUrl = request.getParameter("twitter_url");
        p.orden = Integer.parseInt(request.getParameter("orden") != null ? request.getParameter("orden") : "0");
        p.activo = "on".equals(request.getParameter("activo"));

        if (p.id > 0) {
            PlanaDirectiva old = PlanaDirectiva.getById(p.id);
            p.fotoUrl = newFotoUrl;
            if (old != null && old.fotoUrl != null && !old.fotoUrl.equals(newFotoUrl)) {
                FileStorage.deleteImage(old.fotoUrl);
            }
            PlanaDirectiva.update(p);
        } else {
            p.fotoUrl = newFotoUrl;
            PlanaDirectiva.create(p);
        }

        response.sendRedirect(request.getContextPath() + "/adm/plana-directiva");
    }

    private void handlePlanaDirectivaDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            PlanaDirectiva p = PlanaDirectiva.getById(id);
            if (p != null && p.fotoUrl != null) {
                FileStorage.deleteImage(p.fotoUrl);
            }
            PlanaDirectiva.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/adm/plana-directiva");
    }

    private void handlePlanaDirectivaUploadImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        try {
            Part file = request.getPart("file");
            if (file == null || file.getSize() == 0) {
                response.getWriter().write("{\"error\":\"No file\"}");
                return;
            }
            if (!FileStorage.isValidImage(file)) {
                response.getWriter().write("{\"error\":\"Invalid file (max 5MB, image only)\"}");
                return;
            }
            String url = FileStorage.saveImage(file, "pers");
            if (url != null) {
                response.getWriter().write("{\"url\":\"" + url + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"Upload failed\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handlePlanaDirectivaDeleteImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            PlanaDirectiva p = PlanaDirectiva.getById(id);
            if (p != null && p.fotoUrl != null) {
                FileStorage.deleteImage(p.fotoUrl);
                p.fotoUrl = null;
                PlanaDirectiva.update(p);
            }
        }
        response.getWriter().write("{\"ok\":true}");
    }

    // ══════════════════════════════════════════════════════════════
    // Servicios
    // ══════════════════════════════════════════════════════════════

    private void handleServicios(String path, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Servicios");
        request.setAttribute("currentSection", "servicios");
        request.setAttribute("servicios", Servicio.getAll());
        forward("/views/adm/layout.jsp", request, response);
    }

    private void handleServicioSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Servicio s = new Servicio();
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            s.id = Integer.parseInt(idParam);
        }
        s.titulo = request.getParameter("titulo");
        s.descripcion = request.getParameter("descripcion");
        String newImageUrl = request.getParameter("imagen_url");
        if (newImageUrl == null) newImageUrl = "";
        s.orden = Integer.parseInt(request.getParameter("orden") != null ? request.getParameter("orden") : "0");
        s.activo = "on".equals(request.getParameter("activo"));

        if (s.id > 0) {
            Servicio old = Servicio.getById(s.id);
            s.imagenUrl = newImageUrl;
            if (old != null && old.imagenUrl != null && !old.imagenUrl.equals(newImageUrl)) {
                FileStorage.deleteImage(old.imagenUrl);
            }
            s.enlaceId = guardarEnlace(request, old != null ? old.enlaceId : 0);
            Servicio.update(s);
        } else {
            s.imagenUrl = newImageUrl;
            s.enlaceId = guardarEnlace(request, 0);
            Servicio.create(s);
        }

        response.sendRedirect(request.getContextPath() + "/adm/servicios");
    }

    private void handleServicioDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Servicio s = Servicio.getById(id);
            if (s != null) {
                if (s.imagenUrl != null) FileStorage.deleteImage(s.imagenUrl);
                if (s.enlaceId > 0) Enlace.delete(s.enlaceId);
            }
            Servicio.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/adm/servicios");
    }

    private void handleServicioReorder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idsParam = request.getParameter("ids");
        if (idsParam != null && !idsParam.isEmpty()) {
            java.util.List<Integer> ids = new java.util.ArrayList<>();
            for (String id : idsParam.split(",")) {
                ids.add(Integer.parseInt(id.trim()));
            }
            Servicio.reorder(ids);
        }
        response.getWriter().write("{\"ok\":true}");
    }

    private void handleServicioUploadImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        try {
            Part file = request.getPart("file");
            if (file == null || file.getSize() == 0) {
                response.getWriter().write("{\"error\":\"No file\"}");
                return;
            }
            if (!FileStorage.isValidImage(file)) {
                response.getWriter().write("{\"error\":\"Invalid file (max 5MB, image only)\"}");
                return;
            }
            String url = FileStorage.saveImage(file, "servs");
            if (url != null) {
                response.getWriter().write("{\"url\":\"" + url + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"Upload failed\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleServicioDeleteImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Servicio s = Servicio.getById(id);
            if (s != null && s.imagenUrl != null) {
                FileStorage.deleteImage(s.imagenUrl);
                s.imagenUrl = null;
                Servicio.update(s);
            }
        }
        response.getWriter().write("{\"ok\":true}");
    }

    // ══════════════════════════════════════════════════════════════
    // Unidades
    // ══════════════════════════════════════════════════════════════

    private void handleUnidades(String path, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Unidades");
        request.setAttribute("currentSection", "unidades");
        request.setAttribute("unidades", Unidad.getAll());
        forward("/views/adm/layout.jsp", request, response);
    }

    private void handleUnidadSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Unidad u = new Unidad();
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            u.id = Integer.parseInt(idParam);
        }
        u.titulo = request.getParameter("titulo");
        u.descripcion = request.getParameter("descripcion");
        u.orden = Integer.parseInt(request.getParameter("orden") != null ? request.getParameter("orden") : "0");
        u.activo = "on".equals(request.getParameter("activo"));

        if (u.id > 0) {
            Unidad old = Unidad.getById(u.id);
            u.enlaceId = guardarEnlace(request, old != null ? old.enlaceId : 0);
            Unidad.update(u);
        } else {
            u.enlaceId = guardarEnlace(request, 0);
            Unidad.create(u);
        }

        response.sendRedirect(request.getContextPath() + "/adm/unidades");
    }

    private void handleUnidadDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Unidad u = Unidad.getById(id);
            if (u != null && u.enlaceId > 0) {
                Enlace.delete(u.enlaceId);
            }
            Unidad.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/adm/unidades");
    }

    private void handleUnidadReorder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idsParam = request.getParameter("ids");
        if (idsParam != null && !idsParam.isEmpty()) {
            java.util.List<Integer> ids = new java.util.ArrayList<>();
            for (String id : idsParam.split(",")) {
                ids.add(Integer.parseInt(id.trim()));
            }
            Unidad.reorder(ids);
        }
        response.getWriter().write("{\"ok\":true}");
    }

    // ══════════════════════════════════════════════════════════════
    // Documentos
    // ══════════════════════════════════════════════════════════════

    private void handleDocumentos(String path, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Documentación");
        request.setAttribute("currentSection", "documentos");
        request.setAttribute("documentos", Documento.getAll());
        forward("/views/adm/layout.jsp", request, response);
    }

    private void handleDocumentoSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Documento d = new Documento();
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            d.id = Integer.parseInt(idParam);
        }
        d.titulo = request.getParameter("titulo");
        d.descripcion = request.getParameter("descripcion");
        d.url = request.getParameter("url");
        d.tipo = request.getParameter("tipo");
        d.orden = Integer.parseInt(request.getParameter("orden") != null ? request.getParameter("orden") : "0");
        d.activo = "on".equals(request.getParameter("activo"));

        String newArchivoUrl = request.getParameter("archivo_url");
        if (newArchivoUrl == null) newArchivoUrl = "";

        if (d.id > 0) {
            Documento old = Documento.getById(d.id);
            d.archivoUrl = newArchivoUrl;
            if (old != null && old.archivoUrl != null && !old.archivoUrl.equals(newArchivoUrl)) {
                FileStorage.deleteFile(old.archivoUrl);
            }
            Documento.update(d);
        } else {
            d.archivoUrl = newArchivoUrl;
            Documento.create(d);
        }

        response.sendRedirect(request.getContextPath() + "/adm/documentos");
    }

    private void handleDocumentoDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Documento d = Documento.getById(id);
            if (d != null && d.archivoUrl != null && !d.archivoUrl.isEmpty()) {
                FileStorage.deleteFile(d.archivoUrl);
            }
            Documento.delete(id);
        }
        response.sendRedirect(request.getContextPath() + "/adm/documentos");
    }

    private void handleDocumentoReorder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idsParam = request.getParameter("ids");
        if (idsParam != null && !idsParam.isEmpty()) {
            java.util.List<Integer> ids = new java.util.ArrayList<>();
            for (String id : idsParam.split(",")) {
                ids.add(Integer.parseInt(id.trim()));
            }
            Documento.reorder(ids);
        }
        response.getWriter().write("{\"ok\":true}");
    }

    private void handleDocumentoUploadDoc(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        try {
            Part file = request.getPart("file");
            if (file == null || file.getSize() == 0) {
                response.getWriter().write("{\"error\":\"No file\"}");
                return;
            }
            if (!FileStorage.isValidDoc(file)) {
                response.getWriter().write("{\"error\":\"Archivo invalido (max 10MB, solo PDF)\"}");
                return;
            }
            String url = FileStorage.saveDoc(file, "docs");
            if (url != null) {
                response.getWriter().write("{\"url\":\"" + url + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"Upload failed\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleDocumentoDeleteDoc(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Documento d = Documento.getById(id);
            if (d != null && d.archivoUrl != null && !d.archivoUrl.isEmpty()) {
                FileStorage.deleteFile(d.archivoUrl);
                d.archivoUrl = null;
                Documento.update(d);
            }
        }
        response.getWriter().write("{\"ok\":true}");
    }

    // ══════════════════════════════════════════════════════════════
    // Configuración
    // ══════════════════════════════════════════════════════════════

    private void handleConfigSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Soporte para envio single (clave/valor) o masivo (todos los campos)
        String clave = request.getParameter("clave");
        String valor = request.getParameter("valor");

        if (clave != null && !clave.isEmpty() && valor != null) {
            // Modo single
            Configuracion.update(clave, valor);
        } else {
            // Modo masivo: iterar todos los parametros del form
            java.util.Map<String, String> allowedKeys = new java.util.HashMap<>();
            // Branding
            allowedKeys.put("site_logo", "");
            allowedKeys.put("site_favicon", "");
            // Hero
            allowedKeys.put("hero_title", "");
            allowedKeys.put("hero_subtitle", "");
            allowedKeys.put("hero_description", "");
            allowedKeys.put("hero_image", "");
            allowedKeys.put("hero_video_id", "");
            allowedKeys.put("hero_video_autoplay", "false");
            // SEO
            allowedKeys.put("site_title", "");
            allowedKeys.put("site_description", "");
            // Redes sociales
            allowedKeys.put("social_twitter", "");
            allowedKeys.put("social_facebook", "");
            allowedKeys.put("social_instagram", "");
            allowedKeys.put("social_linkedin", "");
            // Contacto
            allowedKeys.put("contact_email", "");
            allowedKeys.put("contact_phone", "");
            allowedKeys.put("contact_address", "");
            allowedKeys.put("contact_address_2", "");
            allowedKeys.put("contact_hours", "");
            // Enlaces externos
            allowedKeys.put("url_campus_virtual", "");
            allowedKeys.put("url_cursos", "");
            allowedKeys.put("url_correo", "");
            allowedKeys.put("url_firmaperu", "");
            // FirmaUNA
            allowedKeys.put("firma_windows_url", "");
            allowedKeys.put("firma_linux_url", "");
            allowedKeys.put("firma_mac_url", "");
            allowedKeys.put("firma_video_windows", "");
            allowedKeys.put("firma_video_linux", "");
            allowedKeys.put("firma_video_mac", "");
            // Footer
            allowedKeys.put("footer_brand", "");
            allowedKeys.put("footer_developer", "");

            // Borrado diferido de instaladores FirmaUNA (solo al "Guardar")
            String[] firmaKeys = {"firma_windows_url", "firma_linux_url", "firma_mac_url"};
            java.util.Map<String, String> firmaOld = new java.util.HashMap<>();
            for (String fk : firmaKeys) {
                if ("1".equals(request.getParameter("firma_delete_" + fk))) {
                    firmaOld.put(fk, Configuracion.getValue(fk, ""));
                }
            }
            for (String key : allowedKeys.keySet()) {
                String val = request.getParameter(key);
                if (val != null) {
                    Configuracion.update(key, val);
                }
            }
            for (String fk : firmaKeys) {
                String old = firmaOld.get(fk);
                if (old != null && !old.isEmpty()) {
                    FileStorage.deleteFile(old);
                }
            }
        }
        response.sendRedirect(request.getContextPath() + "/adm/configuracion");
    }

    private void handleConfigUploadImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        try {
            Part file = request.getPart("file");
            if (file == null || file.getSize() == 0) {
                response.getWriter().write("{\"error\":\"No file\"}");
                return;
            }
            if (!FileStorage.isValidImage(file)) {
                response.getWriter().write("{\"error\":\"Invalid file (max 5MB, image only)\"}");
                return;
            }
            String url = FileStorage.saveImage(file, "config");
            if (url != null) {
                response.getWriter().write("{\"url\":\"" + url + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"Upload failed\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleConfigUploadFirma(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        try {
            String key = request.getParameter("key");
            if (key == null || !(key.equals("firma_windows_url")
                    || key.equals("firma_linux_url") || key.equals("firma_mac_url"))) {
                response.getWriter().write("{\"error\":\"Invalid key\"}");
                return;
            }
            Part file = request.getPart("file");
            if (file == null || file.getSize() == 0) {
                response.getWriter().write("{\"error\":\"No file\"}");
                return;
            }
            if (!FileStorage.isValidInstaller(file)) {
                response.getWriter().write("{\"error\":\"Archivo invalido (max 200MB, .exe .msi .sh .tar.gz .dmg .zip .deb .rpm)\"}");
                return;
            }
            String url = FileStorage.saveFile(file, "firma");
            if (url != null) {
                String old = Configuracion.getValue(key, "");
                if (!old.isEmpty() && !old.equals(url)) {
                    FileStorage.deleteFile(old);
                }
                response.getWriter().write("{\"url\":\"" + url + "\"}");
            } else {
                response.getWriter().write("{\"error\":\"Upload failed\"}");
            }
        } catch (Exception e) {
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleConfigDeleteImage(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        String key = request.getParameter("key");
        // Solo se permite borrar claves de Configuracion que almacenan imagenes/archivos
        String[] allowedDelKeys = {
            "site_logo", "site_favicon", "hero_image",
            "firma_windows_url", "firma_linux_url", "firma_mac_url"
        };
        boolean validKey = false;
        if (key != null && !key.isEmpty()) {
            for (String ak : allowedDelKeys) {
                if (ak.equals(key)) { validKey = true; break; }
            }
        }
        if (validKey) {
            String url = Configuracion.getValue(key, "");
            if (!url.isEmpty()) {
                FileStorage.deleteImage(url);
                Configuracion.update(key, "");
            }
        }
        response.getWriter().write("{\"ok\":true}");
    }

    // ══════════════════════════════════════════════════════════════
    // Usuarios
    // ══════════════════════════════════════════════════════════════

    private void handleUsuarios(String path, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        request.setAttribute("pageTitle", "Usuarios");
        request.setAttribute("currentSection", "usuarios");
        request.setAttribute("usuarios", AdminUser.getAll());
        request.setAttribute("currentUser", session != null ? session.getAttribute("adminUser") : null);
        forward("/views/adm/layout.jsp", request, response);
    }

    private void handleUsuarioSave(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        AdminUser u = new AdminUser();
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            u.id = Integer.parseInt(idParam);
        }
        u.username = request.getParameter("username");
        u.nombre = request.getParameter("nombre");
        u.email = request.getParameter("email");
        u.rol = request.getParameter("rol") != null ? request.getParameter("rol") : "editor";
        u.activo = "on".equals(request.getParameter("activo"));

        String password = request.getParameter("password");

        if (u.id > 0) {
            AdminUser.update(u);
            if (password != null && !password.isEmpty()) {
                AdminUser.updatePassword(u.id, password);
            }
        } else {
            if (password != null && !password.isEmpty()) {
                u.passwordHash = password;
                AdminUser.create(u);
            }
        }

        response.sendRedirect(request.getContextPath() + "/adm/usuarios");
    }

    private void handleUsuarioDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            AdminUser.delete(Integer.parseInt(idParam));
        }
        response.sendRedirect(request.getContextPath() + "/adm/usuarios");
    }

    // ══════════════════════════════════════════════════════════════
    // Enlace helper
    // ══════════════════════════════════════════════════════════════

    private int guardarEnlace(HttpServletRequest request, int currentEnlaceId) {
        String url = request.getParameter("enlace");
        String texto = request.getParameter("enlace_texto");
        String nuevaPestana = request.getParameter("enlace_nueva_pestana");

        if (url == null || url.trim().isEmpty()) {
            if (currentEnlaceId > 0) {
                Enlace.delete(currentEnlaceId);
            }
            return 0;
        }

        url = url.trim();
        if (texto == null) texto = "Ver mas";
        boolean target = "on".equals(nuevaPestana);

        Enlace e = new Enlace();
        e.titulo = texto;
        e.url = url;
        e.descripcion = texto;
        e.abrirNuevaPestana = target;
        e.activo = true;

        if (currentEnlaceId > 0) {
            e.id = currentEnlaceId;
            Enlace.update(e);
            return currentEnlaceId;
        } else {
            return Enlace.create(e);
        }
    }

    // ══════════════════════════════════════════════════════════════
    // Forward helper
    // ══════════════════════════════════════════════════════════════

    private void forward(String jspPath, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(jspPath).forward(request, response);
    }
}
