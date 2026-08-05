<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jxmvc.models.Configuracion" %>
<%
    String horarioAtencion = Configuracion.getValue("contact_hours", "Lunes a viernes 08:00am a 12:00pm");
%>

<style>
    .layer-wrapper { padding: 80px 0; }
    .sol-wrapper { max-width: 920px; margin: 0 auto; }
    .sol-card { border: 1px solid #E2E8F0; border-radius: 14px; overflow: hidden; background: #fff; box-shadow: 0 4px 24px rgba(0,0,0,0.06); }
    .sol-header { background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 100%); padding: 14px 20px; display: flex; align-items: center; justify-content: space-between; }
    .sol-header h2 { color: #fff; font-size: 16px; font-weight: 700; margin: 0; }
    .sol-header .sol-horario { color: #94A3B8; font-size: 11px; display: flex; align-items: center; gap: 5px; }
    .sol-header .sol-horario svg { flex-shrink: 0; }
    .sol-body { padding: 16px 20px; }
    .sol-grid { display: grid; gap: 12px; }

    @media (min-width: 769px) {
        .sol-grid { grid-template-columns: 280px 1fr; }
        .sol-grid > #dniSection { grid-column: 1; grid-row: 1; }
        .sol-grid > #solicitudFields { grid-column: 2; grid-row: 1 / 3; }
        .sol-grid > #archivoSection { grid-column: 1; grid-row: 2; }
        .sol-grid > #enviarSection { grid-column: 1 / -1; grid-row: 3; }
    }

    .sol-section { background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 10px; padding: 12px; }
    .sol-section-title { font-size: 10px; font-weight: 700; color: #0369A1; text-transform: uppercase; letter-spacing: 0.6px; margin-bottom: 10px; display: flex; align-items: center; gap: 5px; }
    .sol-section-title .sol-step { display: inline-flex; align-items: center; justify-content: center; width: 18px; height: 18px; border-radius: 50%; background: #0369A1; color: #fff; font-size: 10px; font-weight: 700; flex-shrink: 0; }

    .sol-field { margin-bottom: 10px; }
    .sol-field:last-child { margin-bottom: 0; }
    .sol-field label { font-size: 11px; font-weight: 600; color: #475569; margin-bottom: 3px; display: block; }
    .sol-field .form-control, .sol-field .form-select { font-size: 13px; padding: 6px 10px; border-radius: 6px; border-color: #E2E8F0; }
    .sol-field .form-control:focus, .sol-field .form-select:focus { border-color: #0891B2; box-shadow: 0 0 0 2px rgba(8,145,178,0.15); }

    .sol-dni-row { display: flex; gap: 6px; }
    .sol-dni-row .form-control { flex: 1; }
    .sol-dni-row .btn { padding: 6px 14px; font-size: 12px; font-weight: 600; border-radius: 6px; white-space: nowrap; }

    .dni-feedback { font-size: 11px; margin-top: 3px; min-height: 16px; }
    .dni-loading { color: #64748B; }
    .dni-error { color: #DC3545; }
    .dni-success { color: #10B981; }

    .sol-persona { display: flex; align-items: center; gap: 8px; background: #F0F9FF; border: 1px solid #BAE6FD; border-radius: 8px; padding: 8px 10px; }
    .sol-persona .avatar { width: 30px; height: 30px; border-radius: 50%; background: #0369A1; color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 12px; flex-shrink: 0; }
    .sol-persona .info { font-size: 12px; color: #0F172A; font-weight: 600; }
    .sol-persona .sub { font-size: 10px; color: #64748B; }

    .sol-upload-area { border: 1.5px dashed #CBD5E1; border-radius: 8px; padding: 12px; text-align: center; transition: all 0.2s; background: #F8FAFC; cursor: pointer; }
    .sol-upload-area:hover { border-color: #0891B2; background: #F0F9FF; }
    .sol-upload-area.dragover { border-color: #0891B2; background: #E0F2FE; }
    .sol-upload-area p { font-size: 11px; color: #94A3B8; margin: 0; }
    .sol-upload-area svg { margin-bottom: 4px; }
    #fileInput { display: none; }
    .file-info { margin-top: 8px; }
    .file-info.active { display: block; }

    .sol-condicional { border: 1px solid #BAE6FD; border-radius: 8px; padding: 10px; background: #F0F9FF; margin-top: 8px; }
    .sol-condicional-title { font-size: 10px; color: #0369A1; font-weight: 700; text-transform: uppercase; letter-spacing: 0.4px; margin-bottom: 8px; display: flex; align-items: center; gap: 4px; }
    .sol-condicional-title svg { flex-shrink: 0; }

    .sol-hint { font-size: 11px; color: #0369A1; background: #F0F9FF; border: 1px solid #BAE6FD; border-radius: 6px; padding: 6px 10px; margin-bottom: 8px; }

    .sol-btn-submit { width: 100%; padding: 10px; font-size: 13px; font-weight: 700; border-radius: 8px; display: flex; align-items: center; justify-content: center; gap: 6px; }

    .sol-row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
    @media (max-width: 576px) { .sol-row-2 { grid-template-columns: 1fr; } }

    .sol-firma-section { margin-top: 16px; }
    .sol-firma-card { border: 1px solid #BAE6FD; border-radius: 12px; overflow: hidden; background: #fff; box-shadow: 0 4px 16px rgba(8,145,178,0.08); }
    .sol-firma-header { background: linear-gradient(135deg, #F0F9FF, #E0F2FE); padding: 14px 16px; display: flex; align-items: center; gap: 8px; border-bottom: 1px solid #BAE6FD; }
    .sol-firma-header h3 { font-size: 14px; font-weight: 700; color: #0F172A; margin: 0; }
    .sol-firma-info { padding: 12px 16px; font-size: 12px; color: #475569; border-bottom: 1px solid #E2E8F0; }
    .sol-firma-pdf { width: 100%; height: 420px; border: none; }
    .sol-firma-status { padding: 10px 16px; font-size: 12px; color: #64748B; text-align: center; }
    .sol-firma-actions { padding: 12px 16px; display: flex; gap: 8px; flex-wrap: wrap; border-top: 1px solid #E2E8F0; }
    .sol-firma-btn { padding: 8px 16px; border-radius: 8px; font-size: 12px; font-weight: 600; border: none; cursor: pointer; display: inline-flex; align-items: center; gap: 6px; transition: all 0.2s; }
    .sol-firma-btn-primary { background: #0891B2; color: #fff; }
    .sol-firma-btn-primary:hover { background: #0E7490; }
    .sol-firma-btn-primary:disabled { opacity: 0.6; cursor: not-allowed; }
    .sol-firma-btn-success { background: #10B981; color: #fff; }
    .sol-firma-btn-success:hover { background: #059669; }
    .sol-firma-btn-outline { background: #fff; color: #475569; border: 1px solid #E2E8F0; }
    .sol-firma-btn-outline:hover { background: #F8FAFC; }
</style>

<div class="sol-wrapper">
    <div class="sol-card">
        <!-- Header compacto -->
        <div class="sol-header">
            <h2>
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="vertical-align: middle; margin-right: 6px;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/></svg>
                Generar Solicitud
            </h2>
            <div class="sol-horario">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                <%= horarioAtencion %>
            </div>
        </div>

        <!-- Body -->
        <div class="sol-body">
            <form id="formSolicitud">
                <div class="sol-grid">

                        <!-- DNI -->
                        <div class="sol-section" id="dniSection">
                            <div class="sol-section-title"><span class="sol-step">1</span> Identificacion</div>
                            <div class="sol-field">
                                <label for="dni">DNI</label>
                                <div class="sol-dni-row">
                                    <input type="text" class="form-control" id="dni" placeholder="8 digitos" maxlength="8" inputmode="numeric">
                                    <button type="button" class="btn btn-primary" id="btnConsultar" onclick="consultarDNI()">Consultar</button>
                                </div>
                                <div class="dni-feedback" id="dniFeedback"></div>
                            </div>
                            <div id="personaFields" style="display:none;">
                                <div class="sol-persona">
                                    <div class="avatar" id="personaAvatar"></div>
                                    <div>
                                        <div class="sub">Persona identificada</div>
                                        <div class="info" id="personaNombre"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="solicitudFields" style="display:none;">
                            <!-- Tipo solicitud -->
                            <div class="sol-section">
                                <div class="sol-section-title"><span class="sol-step">2</span> Datos de la solicitud</div>
                                <div class="sol-field">
                                    <label for="cboTipo">Tipo de solicitud</label>
                                    <select id="cboTipo" class="form-select">
                                        <option value="" disabled selected> Seleccione </option>
                                    </select>
                                </div>
                                <div class="sol-row-2">
                                    <div class="sol-field">
                                        <label for="vinculo">Tipo de vinculo</label>
                                        <select id="vinculo" class="form-select" required>
                                            <option value="" disabled selected> Seleccione </option>
                                            <option value="Estudiante"> Estudiante </option>
                                            <option value="Docente"> Docente </option>
                                            <option value="Administrativo"> Administrativo </option>
                                        </select>
                                    </div>
                                    <div class="sol-field">
                                        <label for="msgOtros">Descripcion</label>
                                        <textarea class="form-control" id="msgOtros" rows="2" placeholder="Describa su solicitud..."></textarea>
                                    </div>
                                </div>

                                <!-- Campos condicionales: SOLICITUD_DE_CORREO -->
                                <div id="correoFields" style="display:none;">
                                    <div class="sol-condicional">
                                        <div class="sol-condicional-title">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#0369A1" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                                            Detalles de correo
                                        </div>
                                        <div class="sol-field">
                                            <label for="correoPersonal">Correo personal (requerido)</label>
                                            <input type="email" class="form-control" id="correoPersonal" placeholder="Ejm: usuario@gmail.com">
                                        </div>
                                        <div class="sol-field">
                                            <label for="telefonoPersonal">Telefono (opcional)</label>
                                            <input type="tel" class="form-control" id="telefonoPersonal" placeholder="Ejm: 951234567">
                                        </div>
                                        <div class="sol-field">
                                            <label for="cboMotivoCorreo">Motivo</label>
                                            <select id="cboMotivoCorreo" class="form-select">
                                                <option value="" disabled selected> Seleccione </option>
                                                <option value="CREACION"> Creacion </option>
                                                <option value="RESTABLECIMIENTO"> Restablecimiento </option>
                                                <option value="ELIMINACION"> Eliminacion </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- Campos condicionales: SOLICITUD_ALTA_BAJA -->
                                <div id="altaBajaFields" style="display:none;">
                                    <div class="sol-condicional">
                                        <div class="sol-condicional-title">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#0369A1" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                                            Detalles de cuenta
                                        </div>
                                        <div class="sol-row-2">
                                            <div class="sol-field">
                                                <label for="cboMotivo">Motivo de solicitud</label>
                                                <select id="cboMotivo" class="form-select">
                                                    <option value="" disabled selected> Seleccione </option>
                                                    <option value="CREACION"> Creacion </option>
                                                    <option value="RENOVACION"> Renovacion </option>
                                                    <option value="MODIFICACION"> Modificacion </option>
                                                    <option value="BAJA"> Baja </option>
                                                </select>
                                            </div>
                                            <div class="sol-field">
                                                <label for="sistemaEspecifico">Sistema especifico</label>
                                                <input type="text" class="form-control" id="sistemaEspecifico" placeholder="Ejm: SIGAVES">
                                            </div>
                                        </div>
                                        <div class="sol-field">
                                            <label for="tipoCuenta">Tipo de cuenta</label>
                                            <input type="text" class="form-control" id="tipoCuenta" placeholder="Ejm: Correo institucional + VPN">
                                        </div>
                                    </div>
                                </div>

                                <!-- Campos condicionales: SOPORTE TECNICO -->
                                <div id="soporteFields" style="display:none;">
                                    <div class="sol-condicional">
                                        <div class="sol-condicional-title">
                                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#0369A1" stroke-width="2"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>
                                            Datos del problema
                                        </div>
                                        <div class="sol-row-2">
                                            <div class="sol-field">
                                                <label for="ofiSoporte">Oficina</label>
                                                <input type="text" id="ofiSoporte" class="form-control" placeholder="Ingrese la oficina">
                                            </div>
                                            <div class="sol-field">
                                                <label for="cboDificultad">Dificultad</label>
                                                <select id="cboDificultad" class="form-select">
                                                    <option value="" disabled selected> Seleccione </option>
                                                    <option value="BAJA"> Baja </option>
                                                    <option value="MEDIA"> Media </option>
                                                    <option value="ALTA"> Alta </option>
                                                    <option value="CRITICA"> Critica </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Archivo adjunto -->
                        <div class="sol-section" id="archivoSection" style="display:none;">
                            <div class="sol-section-title"><span class="sol-step" id="archivoStep">3</span> Adjunto</div>
                            <div id="fileHint" class="sol-hint" style="display:none;"></div>
                            <div class="sol-upload-area" id="uploadArea">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="1.5"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>
                                <p>Arrastra archivos aqui</p>
                                <p style="font-size:10px;">PDF, JPG o PNG (max 5, 10MB c/u)</p>
                            </div>
                            <input type="file" id="fileInput" multiple accept=".pdf,.jpg,.jpeg,.png">
                            <div class="file-info" id="fileInfo"></div>
                            <div style="margin-top:8px;">
                                <button type="button" class="btn btn-outline-secondary btn-sm w-100" id="uploadBtn" onclick="document.getElementById('fileInput').click();" style="font-size:11px; border-radius:6px;">Seleccionar Archivo</button>
                            </div>
                        </div>

                        <!-- Enviar -->
                        <div id="enviarSection" style="display:none;">
                            <button type="button" class="btn btn-primary sol-btn-submit" id="btnEnviar" onclick="enviarSolicitud()">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
                                Enviar Solicitud
                            </button>
                        </div>

                </div>
            </form>
        </div>
    </div>
</div>

<!-- Notification Modal -->
<div class="modal fade" id="notifModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content" style="border-radius: 12px; border: none; overflow: hidden;">
            <div class="modal-body text-center p-4">
                <div id="notifIcon" style="font-size: 48px; margin-bottom: 12px;"></div>
                <h5 id="notifTitle" style="font-size: 16px; font-weight: 600; margin-bottom: 8px;"></h5>
                <p id="notifMsg" style="font-size: 13px; color: #64748B; margin-bottom: 16px;"></p>
                <button type="button" class="btn btn-sm w-100" id="notifBtn" data-bs-dismiss="modal" style="border-radius: 8px;">Aceptar</button>
            </div>
        </div>
    </div>
</div>

<!-- FirmaUNA Section: se muestra despues de crear el ticket si hay pdf_fut -->
<div class="sol-firma-section" id="firmaSection" style="display:none;">
    <div class="sol-firma-card">
        <div class="sol-firma-header">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#0891B2" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
            <h3 id="firmaTitulo">FUT - Formulario Unico de Tramite</h3>
        </div>
        <div class="sol-firma-info" id="firmaInfo"></div>
        <iframe id="firmaPdfViewer" class="sol-firma-pdf" src="about:blank"></iframe>
        <div class="sol-firma-status" id="firmaStatus"></div>
        <div class="sol-firma-actions" id="firmaActions">
            <button type="button" class="sol-firma-btn sol-firma-btn-primary" id="btnFirmar" onclick="iniciarFirma()">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/></svg>
                Firmar con FirmaUNA
            </button>
            <button type="button" class="sol-firma-btn sol-firma-btn-success" id="btnEnviarFirmado" onclick="enviarPDFFirmado()" style="display:none;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
                Enviar FUT Firmado
            </button>
            <button type="button" class="sol-firma-btn sol-firma-btn-outline" id="btnOmitirFirma" onclick="omitirFirma()">
                Omitir firma
            </button>
            <button type="button" class="sol-firma-btn sol-firma-btn-outline" id="btnNuevaSolicitud" onclick="nuevaSolicitud()" style="display:none;">
                Nueva solicitud
            </button>
        </div>
    </div>
</div>

<script>
var personaData = null;

window.addEventListener('DOMContentLoaded', function() {
    cargarTipos();
    var params = new URLSearchParams(window.location.search);
    if (params.get('tipo') === 'soporte') {
        preCargarSoporte();
    }
});

function preCargarSoporte() {
    document.getElementById('dniSection').style.display = 'block';
    document.getElementById('solicitudFields').style.display = 'none';
    document.getElementById('soporteFields').style.display = 'none';
    document.getElementById('archivoSection').style.display = 'none';
    document.getElementById('enviarSection').style.display = 'none';
    document.getElementById('archivoStep').textContent = '3';

    var check = setInterval(function() {
        var cbo = document.getElementById('cboTipo');
        for (var i = 0; i < cbo.options.length; i++) {
            if (cbo.options[i].getAttribute('data-nombre') === 'SOPORTE TECNICO') {
                cbo.selectedIndex = i;
                cbo.disabled = false;
                cbo.dispatchEvent(new Event('change'));
                clearInterval(check);
                break;
            }
        }
    }, 100);
    setTimeout(function() { clearInterval(check); }, 5000);
}

function consultarDNI() {
    var dni = document.getElementById('dni').value.trim();
    var feedback = document.getElementById('dniFeedback');
    var btn = document.getElementById('btnConsultar');

    if (!/^\d{8}$/.test(dni)) {
        feedback.className = 'dni-feedback dni-error';
        feedback.textContent = 'El DNI debe tener 8 digitos numericos';
        return;
    }

    btn.disabled = true;
    btn.textContent = 'Consultando...';
    feedback.className = 'dni-feedback dni-loading';
    feedback.textContent = 'Buscando persona...';

    fetch('/views/api/persona-dni.jsp?dni=' + dni)
        .then(function(r) { return r.json().then(function(d) { return { status: r.status, body: d }; }); })
        .then(function(res) {
            if (res.status === 200 && res.body.data) {
                personaData = res.body.data;

                // Verificar si tiene ticket ESPERANDO_FIRMA → mostrar PDF para firmar
                var ticketPendiente = personaData.ticket_pendiente;
                var pdfPendiente = personaData.pdf_pendiente;
                if (ticketPendiente && ticketPendiente.estado === 'ESPERANDO_FIRMA' && pdfPendiente && pdfPendiente.length > 100) {
                    document.getElementById('personaFields').style.display = 'block';
                    document.getElementById('personaNombre').textContent =
                        (res.body.data.nombres || '').split(' ')[0] + ' ' + (res.body.data.apellidos || '').split(' ')[0];
                    document.getElementById('personaAvatar').textContent =
                        (res.body.data.nombres || '').charAt(0);
                    feedback.className = 'dni-feedback dni-success';
                    feedback.innerHTML = '&#10003; Persona encontrada — Tiene un FUT pendiente de firma';
                    btn.textContent = 'Consultado';
                    document.getElementById('dni').readOnly = true;
                    showFirmaSection(ticketPendiente.codigo || '', pdfPendiente);
                    return;
                }

                if (personaData.tickets_activos && personaData.tickets_activos > 0) {
                    var activos = personaData.tickets_activos;
                    feedback.className = 'dni-feedback dni-error';
                    feedback.textContent = 'Ya tiene ' + activos + ' ticket(s) activo(s). Espere a que sea atendido para generar uno nuevo.';
                    personaData = null;
                    btn.disabled = false;
                    btn.textContent = 'Consultar';
                    return;
                }
                if (personaData.correos && Array.isArray(personaData.correos)) {
                    // Correo siempre se pide al usuario
                }
                var telEl = document.getElementById('telefonoPersonal');
                var nombres = (res.body.data.nombres || '').split(' ')[0];
                var apellidos = (res.body.data.apellidos || '').split(' ')[0];
                document.getElementById('personaNombre').textContent = nombres + ' ' + apellidos;
                document.getElementById('personaAvatar').textContent = nombres.charAt(0);

                document.getElementById('personaFields').style.display = 'block';
                document.getElementById('solicitudFields').style.display = 'block';
                document.getElementById('archivoSection').style.display = 'block';
                document.getElementById('enviarSection').style.display = 'block';
                feedback.className = 'dni-feedback dni-success';
                feedback.innerHTML = '&#10003; Persona encontrada';

                btn.textContent = 'Consultado';
                document.getElementById('dni').readOnly = true;
            } else {
                feedback.className = 'dni-feedback dni-error';
                feedback.textContent = res.body.mensaje || 'Persona no encontrada';
                personaData = null;
                btn.disabled = false;
                btn.textContent = 'Consultar';
            }
        })
        .catch(function(e) {
            feedback.className = 'dni-feedback dni-error';
            feedback.textContent = 'Error de conexion: ' + e.message;
            personaData = null;
            btn.disabled = false;
            btn.textContent = 'Consultar';
        });
}

function showNotif(tipo, titulo, msg) {
    var icon = document.getElementById('notifIcon');
    var title = document.getElementById('notifTitle');
    var body = document.getElementById('notifMsg');
    var btn = document.getElementById('notifBtn');
    if (tipo === 'success') {
        icon.innerHTML = '&#10004;';
        icon.style.color = '#10B981';
        btn.className = 'btn btn-sm btn-success w-100';
        btn.style.color = '#fff';
    } else if (tipo === 'error') {
        icon.innerHTML = '&#10006;';
        icon.style.color = '#DC3545';
        btn.className = 'btn btn-sm btn-danger w-100';
        btn.style.color = '#fff';
    } else {
        icon.innerHTML = '&#9432;';
        icon.style.color = '#0891B2';
        btn.className = 'btn btn-sm btn-info w-100';
        btn.style.color = '#fff';
    }
    title.textContent = titulo;
    body.textContent = msg;
    new bootstrap.Modal(document.getElementById('notifModal')).show();
}

function cargarTipos() {
    var mapaNombres = {
        'CORREO': 'SOLICITUD DE CORREO',
        'CONTRASEÑA': 'SOLICITUD DE CORREO',
        'ACTIVACION': 'SOLICITUD DE CORREO',
        'AULA_VIRTUAL': 'SOLICITUD DE ALTA Y BAJA',
        'FIRMA_DIGITAL': 'SOLICITUD DE ALTA Y BAJA',
        'DOMINIO': 'SOLICITUD DE ALTA Y BAJA',
        'SOPORTE TECNICO': 'SOPORTE TECNICO'
    };
    var cboNormal = document.getElementById('cboTipo');
    if (cboNormal) cboNormal.innerHTML = '<option value="" disabled selected>Seleccione</option>';

    fetch('/views/api/tipo-solicitudes.jsp')
        .then(function(r) { return r.json(); })
        .then(function(res) {
            var html = '<option value="" disabled selected>Seleccione</option>';
            var otroHtml = '';
            if (res.data) {
                res.data.forEach(function(t) {
                    var nombreInterno = mapaNombres[t.nombre] || t.nombre;
                    var opt = '<option value="' + t.id + '" data-oficina="' + (t.oficina || '') + '" data-nombre="' + nombreInterno + '" data-api-nombre="' + (t.nombre || '') + '">' + t.nombre + ' - ' + t.descripcion + '</option>';
                    if (nombreInterno === 'OTRO' || (t.nombre && t.nombre.toUpperCase() === 'OTRO')) {
                        otroHtml += opt;
                    } else {
                        html += opt;
                    }
                });
            }
            html += otroHtml;
            if (cboNormal) cboNormal.innerHTML = html;
        })
        .catch(function(err) { console.error('Error cargando tipos:', err); });
}

document.getElementById('cboTipo').addEventListener('change', function() {
    var opt = this.options[this.selectedIndex];
    var nombre = opt ? opt.getAttribute('data-nombre') : '';
    var isCorreo = nombre === 'SOLICITUD DE CORREO';
    var isAltaBaja = nombre === 'SOLICITUD DE ALTA Y BAJA';
    var isSoporte = nombre === 'SOPORTE TECNICO';

    document.getElementById('correoFields').style.display = isCorreo ? 'block' : 'none';
    document.getElementById('altaBajaFields').style.display = isAltaBaja ? 'block' : 'none';
    document.getElementById('soporteFields').style.display = isSoporte ? 'block' : 'none';

    actualizarHintArchivo();
});

document.getElementById('vinculo').addEventListener('change', function() {
    actualizarHintArchivo();
});

function actualizarHintArchivo() {
    var tipoSelect = document.getElementById('cboTipo');
    var nombreTipo = tipoSelect.options[tipoSelect.selectedIndex]
        ? tipoSelect.options[tipoSelect.selectedIndex].getAttribute('data-nombre') : '';
    var vinculo = document.getElementById('vinculo').value;
    var hint = document.getElementById('fileHint');

    if (nombreTipo === 'SOPORTE TECNICO') {
        hint.innerHTML = '&#9432; <b>Opcional:</b> Adjunte evidencia del problema';
        hint.style.display = 'block';
    } else if (nombreTipo === 'SOLICITUD DE CORREO' && vinculo) {
        if (vinculo === 'Administrativo') {
            hint.innerHTML = '&#9432; <b>Requerido:</b> Su contrato (PDF o imagen)';
        } else {
            hint.innerHTML = '&#9432; <b>Requerido:</b> Foto de su DNI (frente y reverso)';
        }
        hint.style.display = 'block';
    } else {
        hint.style.display = 'none';
    }
}

function enviarSolicitud() {
    var cboNormal = document.getElementById('cboTipo');
    var tipo = cboNormal;
    var tipoId = tipo.value;
    if (!tipoId) {
        showNotif('info', 'Atencion', 'Seleccione un tipo de solicitud');
        return;
    }

    var nombreTipo = tipo.options[tipo.selectedIndex]
        ? tipo.options[tipo.selectedIndex].getAttribute('data-nombre') : '';
    var isSoporte = nombreTipo === 'SOPORTE TECNICO';

    var fd = new FormData();
    fd.append('tipo_solicitud_id', tipoId);

    if (isSoporte) {
        if (!personaData) {
            showNotif('info', 'Atencion', 'Primero consulte el DNI');
            return;
        }
        if (personaData.ticket_pendiente && personaData.ticket_pendiente.estado === 'ESPERANDO_FIRMA' && personaData.pdf_pendiente && personaData.pdf_pendiente.length > 100) {
            showFirmaSection(personaData.ticket_pendiente.codigo || '', personaData.pdf_pendiente);
            return;
        }
        if (personaData.tickets_activos && personaData.tickets_activos > 0) {
            showNotif('error', 'Ticket activo', 'Ya tiene un ticket activo pendiente. No puede generar otro.');
            return;
        }
        var ofi = document.getElementById('ofiSoporte').value;
        var dificultad = document.getElementById('cboDificultad').value;
        var msg = document.getElementById('msgOtros').value.trim();
        if (!ofi) { showNotif('info', 'Atencion', 'Ingrese la oficina'); return; }
        if (!dificultad) { showNotif('info', 'Atencion', 'Seleccione la dificultad'); return; }
        if (!msg) { showNotif('info', 'Atencion', 'Ingrese la descripcion del problema'); return; }

        fd.append('dni', personaData.dni);
        fd.append('oficina_sopporte', ofi);
        fd.append('dificultad', dificultad);
        fd.append('observaciones', msg);
    } else {
        if (!personaData) {
            showNotif('info', 'Atencion', 'Primero consulte el DNI');
            return;
        }
        if (personaData.ticket_pendiente && personaData.ticket_pendiente.estado === 'ESPERANDO_FIRMA' && personaData.pdf_pendiente && personaData.pdf_pendiente.length > 100) {
            showFirmaSection(personaData.ticket_pendiente.codigo || '', personaData.pdf_pendiente);
            return;
        }
        if (personaData.tickets_activos && personaData.tickets_activos > 0) {
            showNotif('error', 'Ticket activo', 'Ya tiene un ticket activo pendiente. No puede generar otro.');
            return;
        }
        var vinculo = document.getElementById('vinculo').value;
        if (!vinculo) {
            showNotif('info', 'Atencion', 'Seleccione un tipo de vinculo');
            return;
        }
        var msgOtros = document.getElementById('msgOtros').value.trim();

        fd.append('dni', personaData.dni);
        if (vinculo) fd.append('vinculo', vinculo);
        if (msgOtros) fd.append('observaciones', msgOtros);

        var correoVisible = document.getElementById('correoFields').style.display !== 'none';
        if (correoVisible) {
            var correoVal = document.getElementById('correoPersonal').value.trim();
            if (!correoVal) {
                showNotif('info', 'Atencion', 'Ingrese su correo personal');
                return;
            }
            fd.append('correo_personal', correoVal);
            var motivoCorreo = document.getElementById('cboMotivoCorreo').value;
            if (motivoCorreo) fd.append('motivo_solicitud', motivoCorreo);
            var telefonoVal = document.getElementById('telefonoPersonal').value.trim();
            if (telefonoVal) fd.append('telefono', telefonoVal);
        }

        var altaBajaVisible = document.getElementById('altaBajaFields').style.display !== 'none';
        if (altaBajaVisible) {
            var fileInputCheck = document.getElementById('fileInput');
            var filesCheck = fileInputCheck ? fileInputCheck.files : [];
            if (filesCheck.length === 0) {
                showNotif('info', 'Atencion', 'Debe adjuntar al menos un archivo (foto de DNI)');
                return;
            }
            var cboMotivo = document.getElementById('cboMotivo');
            var motivoVal = cboMotivo.value;
            var tipoCuentaVal = document.getElementById('tipoCuenta').value.trim();
            var sistemaVal = document.getElementById('sistemaEspecifico').value.trim();
            if (motivoVal) fd.append('motivo_solicitud', motivoVal);
            if (tipoCuentaVal) fd.append('tipo_cuenta', tipoCuentaVal);
            if (sistemaVal) fd.append('sistema_especifico', sistemaVal);
        }
    }

    var fileInput = document.getElementById('fileInput');
    var files = fileInput ? fileInput.files : [];
    if (files.length > 5) {
        showNotif('info', 'Atencion', 'Puede adjuntar un maximo de 5 archivos');
        return;
    }
    for (var i = 0; i < files.length; i++) {
        if (files[i].size > 10 * 1024 * 1024) {
            showNotif('info', 'Atencion', 'El archivo "' + files[i].name + '" supera los 10MB');
            return;
        }
    }
    for (var i = 0; i < files.length; i++) {
        fd.append('adjuntos[]', files[i]);
    }

    var btnEnviar = document.getElementById('btnEnviar');
    btnEnviar.disabled = true;
    btnEnviar.textContent = 'Enviando...';

    fetch('/views/api/crear-ticket.jsp', {
        method: 'POST',
        body: fd
    })
    .then(function(r) { return r.json().then(function(d) { return { status: r.status, body: d }; }); })
    .then(function(res) {
        if (res.status === 201) {
            var codigo = res.body.data ? res.body.data.codigo : '';
            var pdfFut = res.body.data ? (res.body.data.pdf_fut || '') : '';
            var correoDestino = personaData ? personaData.correo || '' : '';

            if (pdfFut && pdfFut.length > 100) {
                showFirmaSection(codigo, pdfFut);
            } else {
                var extra = correoDestino ? 'El comprobante PDF sera enviado a ' + correoDestino : '';
                showNotif('success', 'Solicitud registrada', 'Codigo: ' + codigo + '. ' + extra);
                limpiarForm();
            }
        } else {
            var msgErr = res.body.message || res.body.mensaje || 'Error al crear solicitud';
            if (res.body.errors) {
                var details = Object.values(res.body.errors).flat().join('\n');
                msgErr += '\n' + details;
            }
            showNotif('error', 'Error', msgErr);
            btnEnviar.disabled = false;
            btnEnviar.textContent = 'Enviar Solicitud';
        }
    })
    .catch(function(e) {
        showNotif('error', 'Error de conexion', e.message);
        btnEnviar.disabled = false;
        btnEnviar.textContent = 'Enviar Solicitud';
    });
}

function limpiarForm() {
    document.getElementById('dni').value = '';
    document.getElementById('dni').readOnly = false;
    document.getElementById('dniFeedback').textContent = '';
    document.getElementById('dniFeedback').className = 'dni-feedback';
    document.getElementById('btnConsultar').disabled = false;
    document.getElementById('btnConsultar').textContent = 'Consultar';
    document.getElementById('personaNombre').textContent = '';
    document.getElementById('personaAvatar').textContent = '';

    document.getElementById('vinculo').innerHTML = '<option value="" disabled selected> Seleccione </option>' +
        '<option value="Estudiante"> Estudiante </option>' +
        '<option value="Docente"> Docente </option>' +
        '<option value="Administrativo"> Administrativo </option>';
    document.getElementById('cboTipo').innerHTML = '<option value="" disabled selected>Seleccione</option>';
    document.getElementById('msgOtros').value = '';

    document.getElementById('dniSection').style.display = 'block';
    document.getElementById('soporteFields').style.display = 'none';
    document.getElementById('personaFields').style.display = 'none';
    document.getElementById('solicitudFields').style.display = 'none';
    document.getElementById('archivoSection').style.display = 'none';
    document.getElementById('enviarSection').style.display = 'none';
    document.getElementById('archivoStep').textContent = '3';

    document.getElementById('ofiSoporte').value = '';
    document.getElementById('cboDificultad').selectedIndex = 0;
    personaData = null;

    document.getElementById('correoFields').style.display = 'none';
    document.getElementById('correoPersonal').value = '';
    document.getElementById('telefonoPersonal').value = '';
    document.getElementById('cboMotivoCorreo').innerHTML = '<option value="" disabled selected> Seleccione </option>' +
        '<option value="CREACION"> Creacion </option>' +
        '<option value="RESTABLECIMIENTO"> Restablecimiento </option>' +
        '<option value="ELIMINACION"> Eliminacion </option>';
    document.getElementById('altaBajaFields').style.display = 'none';
    document.getElementById('cboMotivo').innerHTML = '<option value="" disabled selected> Seleccione </option>' +
        '<option value="CREACION"> Creacion </option>' +
        '<option value="RENOVACION"> Renovacion </option>' +
        '<option value="MODIFICACION"> Modificacion </option>' +
        '<option value="BAJA"> Baja </option>';
    document.getElementById('tipoCuenta').value = '';
    document.getElementById('sistemaEspecifico').value = '';

    var fileInfo = document.getElementById('fileInfo');
    var fileInput = document.getElementById('fileInput');
    var uploadBtn = document.getElementById('uploadBtn');
    if (fileInfo) { fileInfo.classList.remove('active'); fileInfo.innerHTML = ''; }
    if (fileInput) fileInput.value = '';
    if (uploadBtn) {
        uploadBtn.innerHTML = 'Seleccionar Archivo';
        uploadBtn.classList.remove('btn-primary');
        uploadBtn.classList.add('btn-outline-secondary');
    }
    var btnEnviar = document.getElementById('btnEnviar');
    if (btnEnviar) {
        btnEnviar.disabled = false;
        btnEnviar.textContent = 'Enviar Solicitud';
    }

    cargarTipos();
    var params = new URLSearchParams(window.location.search);
    if (params.get('tipo') === 'soporte') {
        preCargarSoporte();
    }
}

function removeFile(index) {
    var fileInput = document.getElementById('fileInput');
    if (!fileInput || !fileInput.files.length) return;
    var dt = new DataTransfer();
    for (var i = 0; i < fileInput.files.length; i++) {
        if (i !== index) dt.items.add(fileInput.files[i]);
    }
    fileInput.files = dt.files;
    if (fileInput.files.length > 0) {
        showFileInfo(fileInput.files);
    } else {
        var fileInfo = document.getElementById('fileInfo');
        var uploadBtn = document.getElementById('uploadBtn');
        fileInfo.innerHTML = '';
        fileInfo.classList.remove('active');
        uploadBtn.innerHTML = 'Seleccionar Archivo';
        uploadBtn.classList.remove('btn-primary');
        uploadBtn.classList.add('btn-outline-secondary');
    }
}

function showFileInfo(files) {
    var container = document.getElementById('fileInfo');
    var uploadBtn = document.getElementById('uploadBtn');
    var html = '';
    for (var i = 0; i < files.length; i++) {
        var f = files[i];
        html += '<div class="d-flex align-items-center" style="padding: 4px 0;' + (i > 0 ? ' border-top: 1px solid #dee2e6;' : '') + '">';
        html += '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0d6efd" stroke-width="2" style="margin-right: 6px; flex-shrink: 0;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>';
        html += '<div style="flex: 1; min-width: 0;">';
        html += '<h6 class="mb-0" style="font-size: 11px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + f.name + '</h6>';
        html += '<small class="text-muted" style="font-size:10px;">' + (f.size / 1024).toFixed(1) + ' KB &middot; ' + (f.type || '?') + '</small>';
        html += '</div>';
        html += '<button type="button" onclick="removeFile(' + i + ')" style="background: none; border: none; color: #DC3545; cursor: pointer; padding: 2px 4px; font-size: 14px; line-height: 1; flex-shrink: 0;" title="Quitar archivo">&#10005;</button>';
        html += '</div>';
    }
    container.innerHTML = html;
    container.classList.add('active');
    uploadBtn.innerHTML = '&#10003; ' + (files.length === 1 ? files[0].name : files.length + ' archivos');
    uploadBtn.classList.remove('btn-outline-secondary');
    uploadBtn.classList.add('btn-primary');
}
</script>

<script>
(function() {
    var uploadArea = document.getElementById('uploadArea');
    var fileInput = document.getElementById('fileInput');
    var fileInfo = document.getElementById('fileInfo');
    var uploadBtn = document.getElementById('uploadBtn');
    if (!uploadArea || !fileInput) return;

    uploadArea.addEventListener('click', function() { fileInput.click(); });
    uploadArea.addEventListener('dragover', function(e) { e.preventDefault(); uploadArea.classList.add('dragover'); });
    uploadArea.addEventListener('dragleave', function(e) { uploadArea.classList.remove('dragover'); });
    uploadArea.addEventListener('drop', function(e) {
        e.preventDefault(); uploadArea.classList.remove('dragover');
        if (e.dataTransfer.files.length) {
            var newFiles = e.dataTransfer.files;
            var current = fileInput.files;
            var combined = new DataTransfer();
            for (var i = 0; i < current.length; i++) combined.items.add(current[i]);
            for (var i = 0; i < newFiles.length; i++) combined.items.add(newFiles[i]);
            if (combined.files.length > 5) {
                showNotif('info', 'Atencion', 'Puede adjuntar un maximo de 5 archivos');
                return;
            }
            fileInput.files = combined.files;
            showFileInfo(combined.files);
        }
    });
    fileInput.addEventListener('change', function() { if (fileInput.files.length) showFileInfo(fileInput.files); });
})();
</script>

<script>
var firmaSessionId = null;
var firmaCodigo = null;
var firmaSentinelTimer = null;

function showFirmaSection(codigo, pdfFut) {
    firmaCodigo = codigo;

    document.getElementById('formSolicitud').style.display = 'none';
    document.getElementById('firmaInfo').innerHTML = '<b>Ticket:</b> ' + codigo;
    document.getElementById('firmaPdfViewer').src = 'data:application/pdf;base64,' + pdfFut;

    document.getElementById('firmaStatus').innerHTML = '';
    document.getElementById('btnFirmar').style.display = '';
    document.getElementById('btnFirmar').disabled = false;
    document.getElementById('btnEnviarFirmado').style.display = 'none';
    document.getElementById('btnOmitirFirma').style.display = '';
    document.getElementById('btnNuevaSolicitud').style.display = 'none';
    document.getElementById('firmaSection').style.display = 'block';
}

function Base64Enc(str) {
    return btoa(unescape(encodeURIComponent(str)));
}

function iniciarFirma() {
    var pdfViewer = document.getElementById('firmaPdfViewer');
    var pdfBase64 = '';
    try {
        var src = pdfViewer.src;
        if (src && src.indexOf('data:application/pdf;base64,') === 0) {
            pdfBase64 = src.substring(28);
        }
    } catch(e) {}

    if (!pdfBase64) {
        showNotif('error', 'Error', 'No se pudo obtener el PDF para firmar');
        return;
    }

    var btn = document.getElementById('btnFirmar');
    btn.disabled = true;
    btn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/></svg> Preparando...';
    document.getElementById('firmaStatus').innerHTML = 'Preparando documento para firma...';

    var fd = new FormData();
    fd.append('pdf_base64', pdfBase64);
    fd.append('codigo_ticket', firmaCodigo);

    fetch('/views/api/firmauna-setup.jsp', { method: 'POST', body: fd })
        .then(function(r) { return r.json(); })
        .then(function(res) {
            if (!res.success) {
                throw new Error(res.error || 'Error al preparar firma');
            }
            firmaSessionId = res.session_id;

            document.getElementById('firmaStatus').innerHTML = 'Abriendo FirmaUNA Desktop...';
            btn.innerHTML = 'Esperando firma...';

            var urlInvoke = 'service=sign'
                + '&id=' + res.id
                + '&host=' + res.host
                + '&down=' + res.down
                + '&up=' + res.up;
            var protocolUrl = 'zanfirmauna:' + Base64Enc(urlInvoke);
            window.location.href = protocolUrl;

            iniciarPolling(res.sentinel_url);
        })
        .catch(function(e) {
            showNotif('error', 'Error', e.message || 'No se pudo iniciar la firma');
            btn.disabled = false;
            btn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"/></svg> Firmar con FirmaUNA';
            document.getElementById('firmaStatus').innerHTML = '';
        });
}

function iniciarPolling(sentinelUrl) {
    if (firmaSentinelTimer) clearInterval(firmaSentinelTimer);

    firmaSentinelTimer = setInterval(function() {
        fetch(sentinelUrl)
            .then(function(r) { return r.json(); })
            .then(function(res) {
                if (res.state === true || res.status === 'COMPLETE') {
                    clearInterval(firmaSentinelTimer);
                    firmaSentinelTimer = null;
                    onFirmaCompleta();
                }
            })
            .catch(function() {});
    }, 3000);
}

function onFirmaCompleta() {
    document.getElementById('firmaPdfViewer').src = '/views/api/firmauna-display.jsp?sid=' + firmaSessionId + '&t=' + Date.now();
    document.getElementById('firmaStatus').innerHTML = '&#10003; Documento firmado correctamente';
    document.getElementById('firmaStatus').style.color = '#10B981';
    document.getElementById('btnFirmar').style.display = 'none';
    document.getElementById('btnEnviarFirmado').style.display = '';
    document.getElementById('btnOmitirFirma').style.display = 'none';
    document.getElementById('btnNuevaSolicitud').style.display = '';
}

function enviarPDFFirmado() {
    var btn = document.getElementById('btnEnviarFirmado');
    btn.disabled = true;
    btn.textContent = 'Enviando...';
    document.getElementById('firmaStatus').innerHTML = 'Enviando FUT firmado...';
    document.getElementById('firmaStatus').style.color = '#64748B';

    var fd = new FormData();
    fd.append('sid', firmaSessionId);
    fd.append('codigo_ticket', firmaCodigo);

    fetch('/views/api/enviar-firmado.jsp', { method: 'POST', body: fd })
        .then(function(r) { return r.json().then(function(d) { return { status: r.status, body: d }; }); })
        .then(function(res) {
            if (res.status >= 200 && res.status < 300 && res.body.success !== false) {
                document.getElementById('firmaStatus').innerHTML = '&#10003; FUT firmado enviado correctamente';
                document.getElementById('firmaStatus').style.color = '#10B981';
                btn.style.display = 'none';
                showNotif('success', 'Firma enviada', 'El FUT firmado fue enviado. El comprobante sera recibido por correo.');
            } else {
                throw new Error(res.body.error || res.body.message || 'Error al enviar');
            }
        })
        .catch(function(e) {
            document.getElementById('firmaStatus').innerHTML = 'Error al enviar: ' + e.message;
            document.getElementById('firmaStatus').style.color = '#DC3545';
            btn.disabled = false;
            btn.textContent = 'Enviar FUT Firmado';
        });
}

function omitirFirma() {
    document.getElementById('firmaSection').style.display = 'none';
    document.getElementById('firmaStatus').style.color = '#64748B';
    limpiarForm();
    showNotif('info', 'Solicitud registrada', 'La solicitud fue registrada sin firma digital.');
}

function nuevaSolicitud() {
    document.getElementById('firmaSection').style.display = 'none';
    document.getElementById('firmaStatus').style.color = '#64748B';
    limpiarForm();
}
</script>
