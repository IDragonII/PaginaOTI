<%-- 
    Document   : layServicios
    Created on : July 9, 2026
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>.layer-wrapper { padding: 80px 0; }</style>

<div>
    <h1> Servicios de la OTI </h1>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <div class="alert alert-primary">
            <b> Catalogo de Servicios </b> 
        </div>
        <p align="justify">
            La <b>Oficina de Tecnologias de la Informacion</b> ofrece una amplia gama de servicios 
            tecnologicos para la comunidad universitaria de la Universidad Nacional del Altiplano Puno. 
            A continuacion se detallan los servicios disponibles para estudiantes, docentes y personal administrativo.
        </p>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════ -->
<!-- SERVICIOS PARA ESTUDIANTES                         -->
<!-- ═══════════════════════════════════════════════════ -->
<div class="row mt-4">
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Servicios para Estudiantes</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Acceso academico y digital</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Servicios digitales disenados para la comunidad estudiantil de la UNA Puno.
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Creacion y actualizacion del correo institucional</li>
                    <li>Recuperacion de acceso al correo institucional</li>
                    <li>Acceso y soporte para el Campus Virtual</li>
                    <li>Soporte para sistemas academicos: Laurasia, Aula Virtual, Intranet, Campus, Gestion Docente, Tutorias</li>
                    <li>Descarga del Formulario Unico de Tramite (FUT)</li>
                </ul>
                <a href="https://campus.unap.edu.pe" target="_blank"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    Campus Virtual
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                </a>
            </div>
        </div>
    </div>

    <!-- ═══════════════════════════════════════════════════ -->
    <!-- SERVICIOS PARA DOCENTES                            -->
    <!-- ═══════════════════════════════════════════════════ -->
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Servicios para Docentes</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Herramientas academicas</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Servicios orientados al personal docente de la universidad.
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Actualizacion del correo institucional</li>
                    <li>Tramite de la Firma Digital UNAP</li>
                    <li>Solicitud y reserva de laboratorios de computo</li>
                    <li>Soporte para plataformas academicas y administrativas</li>
                </ul>
                <a href="/firmaUNA.jsp" target="_blank"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    FirmaDigital
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════ -->
<!-- MESA DE AYUDA + DESARROLLO                          -->
<!-- ═══════════════════════════════════════════════════ -->
<div class="row">
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Mesa de Ayuda y Soporte Tecnico</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Atencion y soporte</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Servicio de soporte tecnico para atender problemas relacionados con:
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Equipos de computo</li>
                    <li>Software institucional</li>
                    <li>Redes y conectividad</li>
                    <li>Correo institucional</li>
                    <li>Sistemas informaticos</li>
                    <li>Atencion mediante WhatsApp para solicitudes de soporte</li>
                </ul>
                <a href="/solicitud.jsp"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    Generar solicitud
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Desarrollo de Software</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Subunidad especializada</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Subunidad especializada que desarrolla y mantiene:
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Sistemas institucionales</li>
                    <li>Aplicaciones web</li>
                    <li>Plataformas academicas</li>
                    <li>Soluciones informaticas para las diferentes oficinas de la universidad</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════ -->
<!-- REDES + GOBIERNO ELECTRONICO                        -->
<!-- ═══════════════════════════════════════════════════ -->
<div class="row">
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Redes y Telecomunicaciones</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Infraestructura de red</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Subunidad que administra la infraestructura tecnologica de la universidad:
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Red institucional</li>
                    <li>Infraestructura de comunicaciones</li>
                    <li>Servicios de Internet</li>
                    <li>Equipamiento de telecomunicaciones del campus universitario</li>
                </ul>
                <a href="/unidades.jsp"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    Ver unidades
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Gobierno Electronico</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Firma digital e identidad</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Funciones destacadas de esta subunidad:
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Implementacion de la Firma Digital institucional</li>
                    <li>Integracion con FirmaPeru de la Presidencia del Consejo de Ministros</li>
                    <li>Desarrollo de plataforma de identidad digital institucional (en desarrollo)</li>
                </ul>
                <a href="/firmaUNA.jsp" target="_blank"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    FirmaDigital
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- ═══════════════════════════════════════════════════ -->
<!-- SOPORTE + SOFTWARE INSTITUCIONAL                    -->
<!-- ═══════════════════════════════════════════════════ -->
<div class="row">
    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Soporte y Mantenimiento</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Equipos e infraestructura</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    Actividades realizadas por esta subunidad:
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Mantenimiento preventivo y correctivo de equipos informaticos</li>
                    <li>Instalacion y configuracion de software</li>
                    <li>Atencion de incidencias tecnologicas</li>
                    <li>Asistencia tecnica a las diferentes dependencias de la universidad</li>
                </ul>
                <a href="/unidades.jsp"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    Ver unidades
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; height: 100%;">
            <div class="card-body" style="padding: 24px; display: flex; flex-direction: column;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700; color: #0F172A;">Software Institucional</h5>
                        <p style="margin: 4px 0 0; font-size: 0.85rem; color: #64748B;">Herramientas y manuales</p>
                    </div>
                </div>
                <p style="font-size: 0.9rem; color: #475569; line-height: 1.6; margin-bottom: 12px;">
                    La OTI proporciona las siguientes herramientas:
                </p>
                <ul style="font-size: 0.85rem; color: #475569; line-height: 1.8; padding-left: 18px; margin-bottom: 16px; flex-grow: 1;">
                    <li>Instaladores de FirmaUNA</li>
                    <li>Integracion con FirmaPeru</li>
                    <li>Software complementario (JDK 1.8 para aplicaciones institucionales)</li>
                    <li>Manuales y videotutoriales para el uso de estas herramientas</li>
                </ul>
                <a href="/firmaUNA.jsp" target="_blank"
                   class="btn btn-outline-primary btn-sm"
                   style="border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; align-self: flex-start;">
                    Descargas
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                </a>
            </div>
        </div>
    </div>
</div>
