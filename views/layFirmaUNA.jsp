<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String pWinUrl = Configuracion.getValue("firma_windows_url", "");
    String pLinuxUrl = Configuracion.getValue("firma_linux_url", "");
    String pMacUrl = Configuracion.getValue("firma_mac_url", "");
    String pVideoWin = Configuracion.getValue("firma_video_windows", "");
    String pVideoLinux = Configuracion.getValue("firma_video_linux", "");
    String pVideoMac = Configuracion.getValue("firma_video_mac", "");
    String pFirmaPeru = Configuracion.getValue("url_firmaperu", "");
    String pWinFile = pWinUrl.isEmpty() ? "" : pWinUrl.substring(pWinUrl.lastIndexOf('/') + 1);
    String pLinuxFile = pLinuxUrl.isEmpty() ? "" : pLinuxUrl.substring(pLinuxUrl.lastIndexOf('/') + 1);
    String pMacFile = pMacUrl.isEmpty() ? "" : pMacUrl.substring(pMacUrl.lastIndexOf('/') + 1);
%>

<div>
    <h1> FirmaUNA - Software de Firma Digital </h1>
</div>
<hr>
<div class="row">
    <div class="col-md-12">
        <p align="justify">
            <b>FirmaUNA</b> es el software institucional de firma digital de la
            <b>Universidad Nacional del Altiplano Puno</b>, con integracion a
            <a href="<%= pFirmaPeru.isEmpty() ? "#" : pFirmaPeru %>" target="_blank" style="color: #0891B2; text-decoration: underline;">FirmaPeru de la PCM</a>.
            Descargue el instalador segun su sistema operativo.
        </p>
    </div>
</div>

<div class="row mt-4">
    <!-- Windows -->
    <div class="col-md-4 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; transition: box-shadow 0.3s;">
            <div class="card-body" style="padding: 24px;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2"><rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect><line x1="8" y1="21" x2="16" y2="21"></line><line x1="12" y1="17" x2="12" y2="21"></line></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700;">Windows</h5>
                        <small style="color: #64748B;">64 bits</small>
                    </div>
                </div>
                <% if (!pWinUrl.isEmpty()) { %>
                <a href="<%= pWinUrl %>" target="_blank" class="btn btn-success w-100" style="border-radius: 8px; padding: 10px 16px; text-decoration: none;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                    Descargar <small style="opacity: 0.8;"><%= pWinFile %></small>
                </a>
                <% } else { %>
                <button class="btn btn-success w-100" disabled style="border-radius: 8px; padding: 10px 16px; opacity: 0.5; cursor: not-allowed;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                    No disponible
                </button>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Linux -->
    <div class="col-md-4 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; transition: box-shadow 0.3s;">
            <div class="card-body" style="padding: 24px;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700;">Linux</h5>
                        <small style="color: #64748B;">Multi-distro</small>
                    </div>
                </div>
                <% if (!pLinuxUrl.isEmpty()) { %>
                <a href="<%= pLinuxUrl %>" target="_blank" class="btn btn-outline-info w-100" style="border-radius: 8px; padding: 10px 16px; text-decoration: none;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                    Descargar <small style="opacity: 0.8;"><%= pLinuxFile %></small>
                </a>
                <% } else { %>
                <button class="btn btn-outline-info w-100" disabled style="border-radius: 8px; padding: 10px 16px; opacity: 0.5; cursor: not-allowed;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                    No disponible
                </button>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Mac -->
    <div class="col-md-4 mb-4">
        <div class="card" style="border: 1px solid #E0F2FE; border-radius: 12px; overflow: hidden; transition: box-shadow 0.3s;">
            <div class="card-body" style="padding: 24px;">
                <div class="d-flex align-items-center mb-3">
                    <div style="width: 48px; height: 48px; border-radius: 12px; background: linear-gradient(135deg, #0891B2, #06B6D4); display: flex; align-items: center; justify-content: center; margin-right: 16px; flex-shrink: 0;">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2"><path d="M12 20.94c1.5 0 2.75 1.06 4 1.06 3 0 6-8 6-12.22A4.91 4.91 0 0 0 17 5c-2.22 0-4 1.44-5 2-1-.56-2.78-2-5-2a4.9 4.9 0 0 0-5 4.78C2 14 5 22 8 22c1.25 0 2.5-1.06 4-1.06Z"></path><path d="M10 2c1 .5 2 2 2 5"></path></svg>
                    </div>
                    <div>
                        <h5 style="margin: 0; font-size: 1rem; font-weight: 700;">MacOS</h5>
                        <small style="color: #64748B;">ARM / Intel</small>
                    </div>
                </div>
                <% if (!pMacUrl.isEmpty()) { %>
                <a href="<%= pMacUrl %>" target="_blank" class="btn btn-outline-warning w-100" style="border-radius: 8px; padding: 10px 16px; text-decoration: none;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                    Descargar <small style="opacity: 0.8;"><%= pMacFile %></small>
                </a>
                <% } else { %>
                <button class="btn btn-outline-warning w-100" disabled style="border-radius: 8px; padding: 10px 16px; opacity: 0.5; cursor: not-allowed;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                    No disponible
                </button>
                <% } %>
            </div>
        </div>
    </div>
</div>

<% if (!pFirmaPeru.isEmpty()) { %>
<div class="row mt-2">
    <div class="col-md-12">
        <a href="<%= pFirmaPeru %>" target="_blank" class="btn btn-outline-dark" style="border-radius: 8px; padding: 10px 20px; text-decoration: none;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 6px;"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
            FirmaPeru (PCM) - Portal oficial
        </a>
    </div>
</div>
<% } %>

<% if (!pVideoWin.isEmpty() || !pVideoLinux.isEmpty() || !pVideoMac.isEmpty()) { %>
<div class="row mt-4">
    <div class="col-md-12">
        <hr>
        <h4 style="font-weight: 700;">Video Tutoriales</h4>
        <p style="color: #64748B;">Aprenda a instalar y usar FirmaUNA en su sistema operativo.</p>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; background: #000; margin-bottom: 16px;" id="pageVideoContainer">
            <iframe id="pageVideoFrame" src="" allowfullscreen style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none; display: none;"></iframe>
            <div id="pageVideoPlaceholder" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; flex-direction: column; color: #64748B;">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-bottom: 8px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                <small>Seleccione un video tutorial</small>
            </div>
        </div>
        <div class="d-flex gap-2">
            <% if (!pVideoWin.isEmpty()) { %>
            <button type="button" class="btn btn-outline-danger btn-sm flex-fill" onclick="playPageVideo('windows')" style="border-radius: 6px;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                Windows
            </button>
            <% } %>
            <% if (!pVideoLinux.isEmpty()) { %>
            <button type="button" class="btn btn-outline-danger btn-sm flex-fill" onclick="playPageVideo('linux')" style="border-radius: 6px;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                Linux
            </button>
            <% } %>
            <% if (!pVideoMac.isEmpty()) { %>
            <button type="button" class="btn btn-outline-danger btn-sm flex-fill" onclick="playPageVideo('mac')" style="border-radius: 6px;">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-right: 4px;"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                MacOS
            </button>
            <% } %>
        </div>
    </div>
</div>
<script>
function playPageVideo(os) {
    var iframe = document.getElementById('pageVideoFrame');
    var placeholder = document.getElementById('pageVideoPlaceholder');
    var videoIds = {
        windows: '<%= pVideoWin %>',
        linux: '<%= pVideoLinux %>',
        mac: '<%= pVideoMac %>'
    };
    var id = videoIds[os];
    if (id) {
        iframe.src = 'https://www.youtube.com/embed/' + id + '?autoplay=1&rel=0';
        iframe.style.display = 'block';
        placeholder.style.display = 'none';
    }
}
</script>
<% } %>
