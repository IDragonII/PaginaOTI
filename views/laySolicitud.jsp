<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jxmvc.models.Configuracion" %>
<%
    String horarioAtencion = Configuracion.getValue("contact_hours", "Lunes a viernes 08:00am a 12:00pm");
%>

<style>
    .dni-feedback { font-size: 12px; margin-top: 4px; min-height: 18px; }
    .dni-loading { color: #64748B; }
    .dni-error { color: #DC3545; }
    .dni-success { color: #10B981; }
    .form-readonly { background-color: #f1f5f9 !important; border-color: #e2e8f0 !important; color: #475569 !important; }
    .upload-container { position: relative; margin: 12px 0; }
    .upload-area { border: 2px dashed #CBD5E1; border-radius: 10px; padding: 28px 16px; text-align: center; transition: all 0.2s ease; background-color: #F8FAFC; cursor: pointer; }
    .upload-area:hover { border-color: #0369A1; background-color: #F0F9FF; }
    .upload-area.dragover { border-color: #0369A1; background-color: #E0F2FE; }
    .file-info { margin-top: 12px; padding: 10px 12px; border-radius: 8px; background-color: #F1F5F9; display: none; }
    .file-info.active { display: block; }
    #fileInput { display: none; }

    .card-solicitud { border: 1px solid #E2E8F0; border-radius: 12px; overflow: hidden; background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.04); }
    .card-solicitud-header { background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 100%); padding: 20px 24px; }
    .card-solicitud-header h2 { color: #fff; font-size: 18px; font-weight: 700; margin: 0 0 4px 0; }
    .card-solicitud-header p { color: #94A3B8; font-size: 13px; margin: 0; }
    .card-solicitud-body { padding: 24px; }

    .step-label { display: inline-flex; align-items: center; gap: 6px; font-size: 11px; font-weight: 700; color: #0369A1; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 10px; }
    .step-label .step-num { display: inline-flex; align-items: center; justify-content: center; width: 20px; height: 20px; border-radius: 50%; background: #0369A1; color: #fff; font-size: 11px; font-weight: 700; }
    .step-divider { height: 1px; background: #E2E8F0; margin: 20px 0; }

    .condicional-box { border: 1px solid #BAE6FD; border-radius: 8px; padding: 14px; background: #F0F9FF; margin-bottom: 16px; }
    .condicional-box h6 { font-size: 11px; color: #0369A1; font-weight: 700; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 0.5px; }

    .hint-box { font-size: 12px; color: #0369A1; background: #F0F9FF; border: 1px solid #BAE6FD; border-radius: 6px; padding: 8px 12px; margin-bottom: 12px; }

    .persona-badge { display: flex; align-items: center; gap: 10px; background: #F0F9FF; border: 1px solid #BAE6FD; border-radius: 8px; padding: 10px 14px; }
    .persona-badge .avatar { width: 36px; height: 36px; border-radius: 50%; background: #0369A1; color: #fff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px; flex-shrink: 0; }
    .persona-badge .info { font-size: 13px; color: #0F172A; font-weight: 600; }

    .horario-bar { display: flex; align-items: center; gap: 8px; background: #F8FAFC; border: 1px solid #E2E8F0; border-radius: 8px; padding: 10px 14px; font-size: 12px; color: #475569; margin-bottom: 20px; }
    .horario-bar svg { flex-shrink: 0; }
</style>

<div style="max-width: 860px; margin: 0 auto;">
    <div class="card-solicitud">
        <!-- Header -->
        <div class="card-solicitud-header">
            <h2>Generar Solicitud</h2>
            <p>Complete los datos para registrar su solicitud</p>
        </div>

        <!-- Body -->
        <div class="card-solicitud-body">

            <!-- Horario -->
            <div class="horario-bar">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#475569" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
                <span><b>Horario de atencion:</b> <%= horarioAtencion %></span>
            </div>

            <form id="formSolicitud">

                <!-- PASO 1: Identificacion (siempre visible en flujo normal) -->
                <div id="dniSection">
                    <div class="step-label"><span class="step-num">1</span> Identificacion</div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" style="font-size: 13px;"> DNI </label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="dni" placeholder="Ingrese 8 digitos" maxlength="8" inputmode="numeric" style="font-size: 14px; padding: 8px 12px;">
                            <button type="button" class="btn btn-primary" id="btnConsultar" onclick="consultarDNI()" style="padding: 8px 16px; font-size: 13px;">Consultar</button>
                        </div>
                        <div class="dni-feedback" id="dniFeedback"></div>
                    </div>

                    <div id="personaFields" style="display:none;" class="mb-3">
                        <div class="persona-badge">
                            <div class="avatar" id="personaAvatar"></div>
                            <div>
                                <div style="font-size: 11px; color: #64748B; margin-bottom: 1px;">Persona identificada</div>
                                <div class="info" id="personaNombre"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- PASO 2: Datos de solicitud (despues de DNI, flujo normal) -->
                <div id="solicitudFields" style="display:none;">
                    <div class="step-divider"></div>
                    <div class="step-label"><span class="step-num">2</span> Datos de la solicitud</div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold" style="font-size: 13px;"> Tipo de solicitud </label>
                        <select id="cboTipo" class="form-select" style="font-size: 14px; padding: 8px 12px;">
                            <option value="" disabled selected> Seleccione </option>
                        </select>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-semibold" style="font-size: 13px;"> Tipo de vinculo </label>
                                <select id="vinculo" class="form-select" required style="font-size: 14px; padding: 8px 12px;">
                                    <option value="" disabled selected> Seleccione </option>
                                    <option value="Estudiante"> Estudiante </option>
                                    <option value="Docente"> Docente </option>
                                    <option value="Administrativo"> Administrativo </option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-semibold" style="font-size: 13px;"> Descripcion </label>
                                <textarea class="form-control" id="msgOtros" rows="1" placeholder="Describa su solicitud..." style="font-size: 14px; padding: 8px 12px;"></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Campos condicionales: SOLICITUD_DE_CORREO -->
                    <div id="correoFields" style="display:none;">
                        <div class="condicional-box">
                            <h6>
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0369A1" stroke-width="2" style="vertical-align: middle; margin-right: 4px;"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                                Detalles de correo institucional
                            </h6>
                            <div class="mb-3">
                                <label class="form-label fw-semibold" style="font-size: 13px;"> Correo personal (requerido) </label>
                                <input type="email" class="form-control" id="correoPersonal" placeholder="Ejm: usuario@gmail.com" style="font-size: 14px; padding: 8px 12px;">
                            </div>
                            <div class="mb-0">
                                <label class="form-label fw-semibold" style="font-size: 13px;"> Motivo </label>
                                <select id="cboMotivoCorreo" class="form-select" style="font-size: 14px; padding: 8px 12px;">
                                    <option value="" disabled selected> Seleccione </option>
                                    <option value="CREACION"> Creacion </option>
                                    <option value="RESTABLECIMIENTO"> Restablecimiento </option>
                                    <option value="ACTIVACION"> Activacion </option>
                                    <option value="OTRO"> Otro </option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Campos condicionales: SOLICITUD_ALTA_BAJA -->
                    <div id="altaBajaFields" style="display:none;">
                        <div class="condicional-box">
                            <h6>
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0369A1" stroke-width="2" style="vertical-align: middle; margin-right: 4px;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg>
                                Detalles de cuenta
                            </h6>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold" style="font-size: 13px;"> Motivo de solicitud </label>
                                        <select id="cboMotivo" class="form-select" style="font-size: 14px; padding: 8px 12px;">
                                            <option value="" disabled selected> Seleccione </option>
                                            <option value="CREACION"> Creacion </option>
                                            <option value="RENOVACION"> Renovacion </option>
                                            <option value="MODIFICACION"> Modificacion </option>
                                            <option value="BAJA"> Baja </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold" style="font-size: 13px;"> Sistema especifico </label>
                                        <input type="text" class="form-control" id="sistemaEspecifico" placeholder="Ejm: SIGAVES" style="font-size: 14px; padding: 8px 12px;">
                                    </div>
                                </div>
                            </div>
                            <div class="mb-0">
                                <label class="form-label fw-semibold" style="font-size: 13px;"> Tipo de cuenta </label>
                                <input type="text" class="form-control" id="tipoCuenta" placeholder="Ejm: Correo institucional + VPN" style="font-size: 14px; padding: 8px 12px;">
                            </div>
                        </div>
                    </div>

                    <!-- Campos condicionales: SOPORTE TECNICO (dentro de solicitudFields) -->
                    <div id="soporteFields" style="display:none;">
                        <div class="condicional-box">
                            <h6>
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#0369A1" stroke-width="2" style="vertical-align: middle; margin-right: 4px;"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 1 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 1 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 1 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>
                                Datos del problema
                            </h6>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold" style="font-size: 13px;"> Oficina </label>
                                        <input type="text" id="ofiSoporte" class="form-control" placeholder="Ingrese la oficina" style="font-size: 14px; padding: 8px 12px;">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold" style="font-size: 13px;"> Dificultad </label>
                                        <select id="cboDificultad" class="form-select" style="font-size: 14px; padding: 8px 12px;">
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

                <!-- PASO 4: Archivo adjunto -->
                <div id="archivoSection" style="display:none;">
                    <div class="step-divider"></div>
                    <div class="step-label"><span class="step-num" id="archivoStep">3</span> Documento adjunto</div>

                    <div id="fileHint" class="hint-box" style="display:none;"></div>

                    <div class="upload-container">
                        <div class="upload-area" id="uploadArea">
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="1.5" style="margin-bottom: 8px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/></svg>
                            <h5 style="font-size: 13px; color: #475569; margin-bottom: 4px; font-weight: 600;">Arrastra y suelta archivos aqui</h5>
                            <p style="font-size: 12px; color: #94A3B8; margin: 0;"> PDF, JPG o PNG (max 5 archivos, 10MB c/u) </p>
                        </div>
                        <input type="file" id="fileInput" multiple accept=".pdf,.jpg,.jpeg,.png">
                        <div class="file-info" id="fileInfo"></div>
                    </div>
                    <div class="d-grid gap-2 mt-2">
                        <button type="button" class="btn btn-outline-secondary" id="uploadBtn" onclick="document.getElementById('fileInput').click();" style="font-size: 13px; border-radius: 8px; padding: 8px;">Seleccionar Archivo</button>
                    </div>
                </div>

                <!-- Enviar -->
                <div id="enviarSection" style="display:none;">
                    <div class="step-divider"></div>
                    <div class="d-grid">
                        <button type="button" class="btn btn-primary" id="btnEnviar" onclick="enviarSolicitud()" style="padding: 10px; font-size: 14px; font-weight: 600; border-radius: 8px;">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="vertical-align: middle; margin-right: 4px;"><line x1="22" y1="2" x2="11" y2="13"/><polygon points="22 2 15 22 11 13 2 9 22 2"/></svg>
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

<script>
var personaData = null;
var correoPersonalAPI = null;

window.addEventListener('DOMContentLoaded', function() {
    cargarTipos();
    var params = new URLSearchParams(window.location.search);
    if (params.get('tipo') === 'soporte') {
        preCargarSoporte();
    }
});

function preCargarSoporte() {
    // Flujo soporte: DNI visible, pre-seleccionar SOPORTE TECNICO despues de consultar DNI
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
                if (personaData.correos && Array.isArray(personaData.correos)) {
                    var personal = personaData.correos.find(function(c) { return c.tipo === 'PERSONAL'; });
                    if (personal && personal.correo) {
                        correoPersonalAPI = personal.correo;
                        var el = document.getElementById('correoPersonal');
                        if (el) el.value = personal.correo;
                    } else {
                        correoPersonalAPI = null;
                    }
                } else {
                    correoPersonalAPI = null;
                }
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
            if (res.data) {
                res.data.forEach(function(t) {
                    var nombreInterno = mapaNombres[t.nombre] || t.nombre;
                    html += '<option value="' + t.id + '" data-oficina="' + (t.oficina || '') + '" data-nombre="' + nombreInterno + '" data-api-nombre="' + (t.nombre || '') + '">' + t.nombre + ' - ' + t.descripcion + '</option>';
                });
            }
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
    if (isCorreo && correoPersonalAPI) {
        document.getElementById('correoPersonal').style.display = 'none';
        document.getElementById('correoPersonal').previousElementSibling.style.display = 'none';
    } else {
        document.getElementById('correoPersonal').style.display = '';
        document.getElementById('correoPersonal').previousElementSibling.style.display = '';
    }
    document.getElementById('altaBajaFields').style.display = isAltaBaja ? 'block' : 'none';
    document.getElementById('soporteFields').style.display = isSoporte ? 'block' : 'none';

// SOPORTE TECNICO funciona igual que otros tipos: requiere DNI, no oculta dniSection
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
        hint.innerHTML = '&#9432; <b>Opcional:</b> Adjunte evidencia del problema (capturas de pantalla, etc.)';
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

    // === RAMA SOPORTE TECNICO (requiere DNI como otros tipos) ===
    if (isSoporte) {
        if (!personaData) {
            showNotif('info', 'Atencion', 'Primero consulte el DNI');
            return;
        }
        var ofi = document.getElementById('ofiSoporte').value;
        var dificultad = document.getElementById('cboDificultad').value;
        var msg = document.getElementById('msgOtros').value.trim();
        if (!ofi) { showNotif('info', 'Atencion', 'Seleccione la oficina'); return; }
        if (!dificultad) { showNotif('info', 'Atencion', 'Seleccione la dificultad'); return; }
        if (!msg) { showNotif('info', 'Atencion', 'Ingrese la descripcion del problema'); return; }

        fd.append('dni', personaData.dni);
        fd.append('oficina_sopporte', ofi);
        fd.append('dificultad', dificultad);
        fd.append('observaciones', msg);
    } else {
        // === RAMA OTROS TIPOS (requiere DNI) ===
        if (!personaData) {
            showNotif('info', 'Atencion', 'Primero consulte el DNI');
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

        // Campos condicionales: SOLICITUD_DE_CORREO
        var correoVisible = document.getElementById('correoFields').style.display !== 'none';
        if (correoVisible) {
            var correoVal = correoPersonalAPI || document.getElementById('correoPersonal').value.trim();
            if (!correoVal) {
                showNotif('info', 'Atencion', 'Ingrese su correo personal');
                return;
            }
            fd.append('correo_personal', correoVal);
            var motivoCorreo = document.getElementById('cboMotivoCorreo').value;
            if (motivoCorreo) fd.append('motivo_solicitud', motivoCorreo);
        }

        // Campos condicionales: SOLICITUD_ALTA_BAJA
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

    // Archivos adjuntos
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
            var correoDestino = personaData ? personaData.correo || '' : '';
            var extra = correoDestino ? 'El comprobante PDF sera enviado a ' + correoDestino : '';
            showNotif('success', 'Solicitud registrada', 'Codigo: ' + codigo + '. ' + extra);
            limpiarForm();
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
    // Resetear DNI
    document.getElementById('dni').value = '';
    document.getElementById('dni').readOnly = false;
    document.getElementById('dniFeedback').textContent = '';
    document.getElementById('dniFeedback').className = 'dni-feedback';
    document.getElementById('btnConsultar').disabled = false;
    document.getElementById('btnConsultar').textContent = 'Consultar';
    document.getElementById('personaNombre').textContent = '';
    document.getElementById('personaAvatar').textContent = '';

    // Resetear selects
    document.getElementById('vinculo').innerHTML = '<option value="" disabled selected> Seleccione </option>' +
        '<option value="Estudiante"> Estudiante </option>' +
        '<option value="Docente"> Docente </option>' +
        '<option value="Administrativo"> Administrativo </option>';
    document.getElementById('cboTipo').innerHTML = '<option value="" disabled selected>Seleccione</option>';
    document.getElementById('msgOtros').value = '';

    // Mostrar DNI, ocultar lo demas
    document.getElementById('dniSection').style.display = 'block';
    document.getElementById('soporteFields').style.display = 'none';
    document.getElementById('personaFields').style.display = 'none';
    document.getElementById('solicitudFields').style.display = 'none';
    document.getElementById('archivoSection').style.display = 'none';
    document.getElementById('enviarSection').style.display = 'none';
    document.getElementById('archivoStep').textContent = '3';

    // Resetear soporte
    document.getElementById('ofiSoporte').value = '';
    document.getElementById('cboDificultad').selectedIndex = 0;
    personaData = null;

    // Resetear campos condicionales
    document.getElementById('correoFields').style.display = 'none';
    document.getElementById('correoPersonal').value = '';
    document.getElementById('correoPersonal').style.display = '';
    document.getElementById('correoPersonal').previousElementSibling.style.display = '';
    correoPersonalAPI = null;
    document.getElementById('cboMotivoCorreo').innerHTML = '<option value="" disabled selected> Seleccione </option>' +
        '<option value="CREACION"> Creacion </option>' +
        '<option value="RESTABLECIMIENTO"> Restablecimiento </option>' +
        '<option value="ACTIVACION"> Activacion </option>' +
        '<option value="OTRO"> Otro </option>';
    document.getElementById('altaBajaFields').style.display = 'none';
    document.getElementById('cboMotivo').innerHTML = '<option value="" disabled selected> Seleccione </option>' +
        '<option value="CREACION"> Creacion </option>' +
        '<option value="RENOVACION"> Renovacion </option>' +
        '<option value="MODIFICACION"> Modificacion </option>' +
        '<option value="BAJA"> Baja </option>';
    document.getElementById('tipoCuenta').value = '';
    document.getElementById('sistemaEspecifico').value = '';

    // Resetear archivos
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

    // Recargar tipos de solicitud y verificar burbuja soporte
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
        uploadBtn.classList.add('btn-outline-primary');
    }
}

function showFileInfo(files) {
    var container = document.getElementById('fileInfo');
    var uploadBtn = document.getElementById('uploadBtn');
    var html = '';
    for (var i = 0; i < files.length; i++) {
        var f = files[i];
        html += '<div class="d-flex align-items-center" style="padding: 6px 0;' + (i > 0 ? ' border-top: 1px solid #dee2e6;' : '') + '">';
        html += '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#0d6efd" stroke-width="2" style="margin-right: 8px; flex-shrink: 0;"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>';
        html += '<div style="flex: 1; min-width: 0;">';
        html += '<h6 class="mb-0" style="font-size: 12px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + f.name + '</h6>';
        html += '<small class="text-muted">' + (f.size / 1024).toFixed(1) + ' KB &middot; ' + (f.type || '?') + '</small>';
        html += '</div>';
        html += '<button type="button" onclick="removeFile(' + i + ')" style="background: none; border: none; color: #DC3545; cursor: pointer; padding: 2px 6px; font-size: 16px; line-height: 1; flex-shrink: 0;" title="Quitar archivo">&#10005;</button>';
        html += '</div>';
    }
    container.innerHTML = html;
    container.classList.add('active');
    uploadBtn.innerHTML = '&#10003; ' + (files.length === 1 ? files[0].name : files.length + ' archivos');
    uploadBtn.classList.remove('btn-outline-primary');
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