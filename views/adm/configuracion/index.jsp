<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jxmvc.models.Configuracion" %>
<%@ page import="java.util.List" %>
<style>
.upload-config-area, .upload-firma-area {
    border: 2px dashed #CBD5E1;
    border-radius: 10px;
    padding: 20px 16px;
    text-align: center;
    cursor: pointer;
    transition: all 0.2s ease;
    background-color: #F8FAFC;
}
.upload-config-area:hover, .upload-firma-area:hover { border-color: var(--accent-color); background-color: #F0F9FF; }
.upload-config-area.dragover, .upload-firma-area.dragover { border-color: var(--accent-color); background-color: #E0F2FE; }
.upload-config-name { font-size: 12px; color: #64748B; margin-top: 4px; word-break: break-all; }
.upload-config-area img { max-width: 100%; border-radius: 8px; }
.upload-firma-area.has-file { border-style: solid; border-color: #06B6D4; background-color: #F0FDFF; }
.upload-firma-area .firma-fname { font-size: 12px; font-weight: 600; color: #0891B2; margin-top: 6px; word-break: break-all; }
.upload-firma-area .firma-pending { color: #D97706; }
.firma-remove {
    display: inline-block; margin-top: 8px; font-size: 11px; color: #DC3545;
    background: none; border: none; cursor: pointer; text-decoration: underline;
}
.admin-card-header { display: flex; align-items: center; justify-content: space-between; }
.admin-card-header h3 { margin: 0; }
.btn-save-module {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 6px 16px; border-radius: 8px; border: none; cursor: pointer;
    font-size: 13px; font-weight: 600; transition: all 0.2s;
    background: linear-gradient(135deg, #0891B2, #06B6D4); color: #fff;
    box-shadow: 0 2px 8px rgba(8,145,178,0.25);
}
.btn-save-module:hover { box-shadow: 0 4px 12px rgba(8,145,178,0.4); transform: translateY(-1px); }
.btn-save-module:active { transform: translateY(0); }
.btn-save-module svg { width: 14px; height: 14px; }
.btn-save-module.saving { opacity: 0.6; pointer-events: none; }

.config-tabs {
    display: flex; gap: 4px; padding: 6px; margin-bottom: 24px;
    background: var(--admin-content-bg, #F1F5F9);
    border: 1px solid var(--border-color, #E2E8F0);
    border-radius: 12px;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
}
.config-tab {
    padding: 10px 18px; border-radius: 8px; border: none; cursor: pointer;
    font-size: 13px; font-weight: 600; white-space: nowrap;
    background: transparent; color: var(--text-muted, #64748B);
    transition: all 0.2s;
}
.config-tab:hover { background: var(--accent-bg, #E0F2FE); color: var(--accent-color, #0891B2); }
.config-tab.active {
    background: linear-gradient(135deg, #0891B2, #06B6D4); color: #fff;
    box-shadow: 0 2px 8px rgba(8,145,178,0.3);
}
.config-module { display: none; }
.config-module.active { display: block; }

.config-split {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
}
.config-form { min-width: 0; }
.config-preview {
    background: #fff;
    border-radius: 12px;
    border: 1px solid var(--border-color, #E2E8F0);
    overflow: hidden;
    position: sticky;
    top: 20px;
}
.config-preview-header {
    padding: 12px 16px;
    background: var(--admin-content-bg, #F1F5F9);
    border-bottom: 1px solid var(--border-color, #E2E8F0);
    font-size: 12px;
    font-weight: 600;
    color: var(--text-muted, #64748B);
    text-transform: uppercase;
    letter-spacing: 0.5px;
}
.config-preview-content { padding: 0; }

.preview-hero {
    background: linear-gradient(135deg, #F0F9FF 0%, #E0F2FE 100%);
    padding: 20px;
    min-height: 180px;
    display: flex;
    align-items: center;
}
.preview-hero-inner {
    display: flex;
    align-items: center;
    gap: 16px;
    width: 100%;
}
.preview-hero-text { flex: 1; }
.preview-hero-badge {
    display: inline-block;
    font-size: 10px;
    font-weight: 700;
    color: #0891B2;
    letter-spacing: 1px;
    margin-bottom: 4px;
}
.preview-hero-title {
    font-size: 18px;
    font-weight: 700;
    margin: 0 0 4px 0;
    color: #0891B2;
}
.preview-hero-desc {
    font-size: 11px;
    color: #64748B;
    margin: 0;
    line-height: 1.4;
}

.preview-seo {
    padding: 16px;
    background: #fff;
}
.preview-seo-title {
    font-size: 14px;
    color: #1A56DB;
    margin: 0 0 4px 0;
    cursor: pointer;
}
.preview-seo-title:hover { text-decoration: underline; }
.preview-seo-url {
    font-size: 12px;
    color: #16A34A;
    margin: 0 0 6px 0;
}
.preview-seo-desc {
    font-size: 12px;
    color: #4B5563;
    margin: 0;
    line-height: 1.5;
}

.preview-redes {
    padding: 16px;
    display: flex;
    gap: 12px;
    flex-wrap: wrap;
}
.preview-redes a {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: #E2E8F0;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #64748B;
    transition: all 0.2s;
}
.preview-redes a:hover { background: #0891B2; color: #fff; }
.preview-redes svg { width: 16px; height: 16px; }

.preview-footer-about {
    background: linear-gradient(180deg, #1E293B 0%, #0F172A 100%);
    padding: 20px;
    color: #E2E8F0;
}
.preview-footer-about-brand {
    display: block;
    color: #F8FAFF;
    font-family: var(--heading-font, 'Poppins', sans-serif);
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 1px;
    margin-bottom: 14px;
}
.preview-contacto {
    background: transparent;
    padding: 0;
    color: #E2E8F0;
}
.preview-contacto-item {
    display: flex;
    align-items: flex-start;
    gap: 10px;
    margin-bottom: 10px;
    font-size: 12px;
}
.preview-contacto-item svg { width: 14px; height: 14px; flex-shrink: 0; color: #22D3EE; margin-top: 2px; }
.preview-contacto-label { color: #94A3B8; font-size: 10px; text-transform: uppercase; letter-spacing: 0.5px; }

.preview-firma {
    padding: 20px;
}
.preview-firma-title {
    font-size: 13px;
    font-weight: 600;
    color: #0F172A;
    margin: 0 0 12px 0;
}
.preview-firma-btns {
    display: flex;
    gap: 8px;
    margin-bottom: 16px;
    flex-wrap: wrap;
}
.preview-firma-btn {
    flex: 1;
    min-width: 70px;
    padding: 8px 12px;
    background: #0891B2;
    color: #fff;
    border-radius: 6px;
    font-size: 11px;
    font-weight: 600;
    text-align: center;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 4px;
}
.preview-firma-btn:hover { background: #06B6D4; }
.preview-firma-btn svg { width: 12px; height: 12px; }
.preview-firma-videos {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 8px;
}
.preview-firma-video {
    aspect-ratio: 16/9;
    background: #E2E8F0;
    border-radius: 6px;
    overflow: hidden;
}
.preview-firma-video img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.preview-footer {
    background: linear-gradient(180deg, #1E293B 0%, #0F172A 100%);
    padding: 20px;
    text-align: center;
    color: #94A3B8;
    font-size: 12px;
}
.preview-footer-brand { color: #22D3EE; font-weight: 600; }

@media (max-width: 992px) {
    .config-split { grid-template-columns: 1fr; }
    .config-preview { position: static; }
}
@media (max-width: 768px) {
    .config-tabs { gap: 2px; padding: 4px; }
    .config-tab { padding: 8px 12px; font-size: 12px; }
}
</style>
<%
    List<Configuracion> configs = Configuracion.getAll();

    String siteLogo = Configuracion.getValue("site_logo", "");
    String siteFavicon = Configuracion.getValue("site_favicon", "");
    String heroVideoId = Configuracion.getValue("hero_video_id", "");
    String heroAutoplay = Configuracion.getValue("hero_video_autoplay", "true");
    String heroTitle = Configuracion.getValue("hero_title", "OTI - UNA Puno");
    String heroSubtitle = Configuracion.getValue("hero_subtitle", "UNIVERSIDAD NACIONAL DEL ALTIPLANO");
    String heroDescription = Configuracion.getValue("hero_description", "");
    String heroImage = Configuracion.getValue("hero_image", "");
    String siteTitle = Configuracion.getValue("site_title", "OTI - UNA Puno");
    String siteDesc = Configuracion.getValue("site_description", "");
    String siteUrl = "https://oti.unap.edu.pe";
    String socialTwitter = Configuracion.getValue("social_twitter", "");
    String socialFacebook = Configuracion.getValue("social_facebook", "");
    String socialInstagram = Configuracion.getValue("social_instagram", "");
    String socialLinkedin = Configuracion.getValue("social_linkedin", "");
    String contactEmail = Configuracion.getValue("contact_email", "");
    String contactPhone = Configuracion.getValue("contact_phone", "");
    String contactAddress = Configuracion.getValue("contact_address", "");
    String contactAddress2 = Configuracion.getValue("contact_address_2", "");
    String contactHours = Configuracion.getValue("contact_hours", "");
    String urlFirmaPeru = Configuracion.getValue("url_firmaperu", "");
    String firmaWin = Configuracion.getValue("firma_windows_url", "");
    String firmaLinux = Configuracion.getValue("firma_linux_url", "");
    String firmaMac = Configuracion.getValue("firma_mac_url", "");
    String videoWin = Configuracion.getValue("firma_video_windows", "");
    String videoLinux = Configuracion.getValue("firma_video_linux", "");
    String videoMac = Configuracion.getValue("firma_video_mac", "");
    String footerBrand = Configuracion.getValue("footer_brand", "");
    String footerDeveloper = Configuracion.getValue("footer_developer", "");
%>

<div class="config-tabs" id="configTabs">
    <button type="button" class="config-tab active" data-mod="mod-branding">Branding</button>
    <button type="button" class="config-tab" data-mod="mod-hero">Hero</button>
    <button type="button" class="config-tab" data-mod="mod-seo">SEO</button>
    <button type="button" class="config-tab" data-mod="mod-redes-contacto">Redes y Contacto</button>
    <button type="button" class="config-tab" data-mod="mod-firma">FirmaUNA</button>
    <button type="button" class="config-tab" data-mod="mod-footer">Footer</button>
</div>

<form method="POST" action="${pageContext.request.contextPath}/adm/configuracion/save" class="form-admin">

    <!-- MODULO 1: Branding -->
    <div class="admin-card config-module active" id="mod-branding" style="margin-bottom: 24px;">
        <div class="admin-card-header">
            <h3 class="admin-card-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; vertical-align: middle;"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
                Branding
            </h3>
            <button type="submit" class="btn-save-module">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Guardar
            </button>
        </div>
        <div style="padding: 24px;">
            <div class="row g-3">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Logo del sitio</label>
                        <input type="hidden" name="site_logo" id="site_logo_val" value="<%= siteLogo %>">
                        <div class="upload-config-area" id="site_logo_area" data-key="site_logo">
                            <% if (!siteLogo.isEmpty()) { %>
                            <img src="<%= siteLogo %>" alt="Logo" style="max-height: 60px; margin-bottom: 8px;">
                            <div class="upload-config-name">Imagen actual</div>
                            <% } else { %>
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                            <div class="upload-config-name">Arrastra o haz click para subir</div>
                            <% } %>
                        </div>
                        <input type="file" accept="image/*" style="display:none" id="site_logo_file">
                        <div class="form-text">Maximo 5MB (JPEG, PNG, WebP, GIF)</div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Favicon</label>
                        <input type="hidden" name="site_favicon" id="site_favicon_val" value="<%= siteFavicon %>">
                        <div class="upload-config-area" id="site_favicon_area" data-key="site_favicon">
                            <% if (!siteFavicon.isEmpty()) { %>
                            <img src="<%= siteFavicon %>" alt="Favicon" style="max-height: 32px; margin-bottom: 8px;">
                            <div class="upload-config-name">Imagen actual</div>
                            <% } else { %>
                            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                            <div class="upload-config-name">Arrastra o haz click para subir</div>
                            <% } %>
                        </div>
                        <input type="file" accept="image/*" style="display:none" id="site_favicon_file">
                        <div class="form-text">Icono de la pestana del navegador</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODULO 2: Hero -->
    <div class="admin-card config-module" id="mod-hero" style="margin-bottom: 24px;">
        <div class="admin-card-header">
            <h3 class="admin-card-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; vertical-align: middle;"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
                Hero
            </h3>
            <button type="submit" class="btn-save-module">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Guardar
            </button>
        </div>
        <div class="config-split" style="padding: 24px;">
            <div class="config-form">
                <div class="form-group">
                    <label class="form-label">Titulo</label>
                    <input type="text" class="form-control preview-input" name="hero_title" data-preview="hero-title"
                           value="<%= heroTitle %>" placeholder="OTI - UNA Puno">
                </div>
                <div class="form-group">
                    <label class="form-label">Subtitulo</label>
                    <input type="text" class="form-control preview-input" name="hero_subtitle" data-preview="hero-badge"
                           value="<%= heroSubtitle %>" placeholder="UNIVERSIDAD NACIONAL DEL ALTIPLANO">
                </div>
                <div class="form-group">
                    <label class="form-label">Descripcion</label>
                    <textarea class="form-control preview-input" name="hero_description" rows="3" data-preview="hero-desc"
                              placeholder="Descripcion que aparece debajo del titulo"><%= heroDescription %></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">Imagen de fondo</label>
                    <input type="hidden" name="hero_image" id="hero_image_val" value="<%= heroImage %>">
                    <div class="upload-config-area" id="hero_image_area" data-key="hero_image">
                        <% if (!heroImage.isEmpty()) { %>
                        <img src="<%= heroImage %>" alt="Hero" style="max-height: 80px; border-radius: 6px; margin-bottom: 8px;">
                        <div class="upload-config-name">Imagen actual</div>
                        <% } else { %>
                        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><circle cx="8.5" cy="8.5" r="1.5"></circle><polyline points="21 15 16 10 5 21"></polyline></svg>
                        <div class="upload-config-name">Arrastra o haz click para subir</div>
                        <% } %>
                    </div>
                    <input type="file" accept="image/*" style="display:none" id="hero_image_file">
                    <div class="form-text">Maximo 5MB (JPEG, PNG, WebP, GIF)</div>
                </div>

                <hr style="margin: 20px 0; border-color: var(--border-color);">
                <h6 style="font-size: 0.82rem; font-weight: 600; color: var(--heading-color); margin-bottom: 12px;">Video Hero</h6>
                <div class="row g-3">
                    <div class="col-md-8">
                        <div class="form-group">
                            <label class="form-label">YouTube Video ID</label>
                            <input type="text" class="form-control" name="hero_video_id"
                                   value="<%= heroVideoId %>" placeholder="Ej: dQw4w9WgXcQ">
                            <div class="form-text">Solo el ID del video</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Auto-reproducir</label>
                            <div class="form-check form-switch" style="padding-top: 6px;">
                                <input class="form-check-input" type="checkbox" name="hero_video_autoplay"
                                       id="heroAutoplay" <%= "true".equals(heroAutoplay) ? "checked" : "" %>>
                                <label class="form-check-label form-switch-label" for="heroAutoplay">Autoplay</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="config-preview">
                <div class="config-preview-header">Preview</div>
                <div class="config-preview-content">
                    <div class="preview-hero">
                        <div class="preview-hero-inner">
                            <div class="preview-hero-text">
                                <div class="preview-hero-badge" id="preview-hero-badge"><%= heroSubtitle.isEmpty() ? "SUBTITULO" : heroSubtitle %></div>
                                <h4 class="preview-hero-title" id="preview-hero-title"><%= heroTitle.isEmpty() ? "OTI - UNA Puno" : heroTitle %></h4>
                                <p class="preview-hero-desc" id="preview-hero-desc"><%= heroDescription.isEmpty() ? "Descripcion del hero..." : heroDescription %></p>
                            </div>
                            <img src="<%= heroImage.isEmpty() ? "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='80' height='50' viewBox='0 0 80 50'%3E%3Crect fill='%23CBD5E1' width='80' height='50' rx='4'/%3E%3Ctext x='40' y='30' fill='%2394A3B8' font-size='10' text-anchor='middle'%3EImagen%3C/text%3E%3C/svg%3E" : heroImage %>" class="preview-hero-img" id="preview-hero-img" style="width: 140px; height: 100px; border-radius: 16px; object-fit: cover; flex-shrink: 0;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODULO 3: SEO / Meta -->
    <div class="admin-card config-module" id="mod-seo" style="margin-bottom: 24px;">
        <div class="admin-card-header">
            <h3 class="admin-card-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; vertical-align: middle;"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                SEO / Meta
            </h3>
            <button type="submit" class="btn-save-module">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Guardar
            </button>
        </div>
        <div class="config-split" style="padding: 24px;">
            <div class="config-form">
                <div class="form-group">
                    <label class="form-label">Titulo del sitio</label>
                    <input type="text" class="form-control preview-input" name="site_title" data-preview="seo-title"
                           value="<%= siteTitle %>" placeholder="OTI - UNA Puno">
                </div>
                <div class="form-group">
                    <label class="form-label">Descripcion</label>
                    <textarea class="form-control preview-input" name="site_description" rows="2" data-preview="seo-desc"
                              placeholder="Descripcion del sitio para SEO"><%= siteDesc %></textarea>
                </div>
            </div>
            <div class="config-preview">
                <div class="config-preview-header">Google Preview</div>
                <div class="config-preview-content">
                    <div class="preview-seo">
                        <div class="preview-seo-title" id="preview-seo-title"><%= siteTitle.isEmpty() ? "Titulo del sitio" : siteTitle %></div>
                        <div class="preview-seo-url"><%= siteUrl %></div>
                        <div class="preview-seo-desc" id="preview-seo-desc"><%= siteDesc.isEmpty() ? "Descripcion del sitio para SEO..." : siteDesc %></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODULO 3: Redes y Contacto -->
    <div class="admin-card config-module" id="mod-redes-contacto" style="margin-bottom: 24px;">
        <div class="admin-card-header">
            <h3 class="admin-card-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; vertical-align: middle;"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                Redes y Contacto
            </h3>
            <button type="submit" class="btn-save-module">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Guardar
            </button>
        </div>
        <div class="config-split" style="padding: 24px;">
            <div class="config-form">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Twitter / X</label>
                            <input type="url" class="form-control preview-input" name="social_twitter" data-preview="social-twitter"
                                   value="<%= socialTwitter %>" placeholder="https://x.com/oti_unap">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Facebook</label>
                            <input type="url" class="form-control preview-input" name="social_facebook" data-preview="social-facebook"
                                   value="<%= socialFacebook %>" placeholder="https://facebook.com/oti.unap">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Instagram</label>
                            <input type="url" class="form-control preview-input" name="social_instagram" data-preview="social-instagram"
                                   value="<%= socialInstagram %>" placeholder="https://instagram.com/oti_unap">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">LinkedIn</label>
                            <input type="url" class="form-control preview-input" name="social_linkedin" data-preview="social-linkedin"
                                   value="<%= socialLinkedin %>" placeholder="https://linkedin.com/company/oti-unap">
                        </div>
                    </div>
                </div>
                <div class="form-text mb-4">Dejar vacio para ocultar el icono en el footer</div>

                <hr style="margin: 20px 0; border-color: var(--border-color);">
                <h6 style="font-size: 0.82rem; font-weight: 600; color: var(--heading-color); margin-bottom: 12px;">Contacto</h6>
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control preview-input" name="contact_email" data-preview="contact-email"
                                   value="<%= contactEmail %>" placeholder="oti@unap.edu.pe">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Telefono</label>
                            <input type="text" class="form-control preview-input" name="contact_phone" data-preview="contact-phone"
                                   value="<%= contactPhone %>" placeholder="+51 51 123456">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Direccion linea 1</label>
                    <input type="text" class="form-control preview-input" name="contact_address" data-preview="contact-address"
                           value="<%= contactAddress %>" placeholder="Ciudad Universitaria">
                </div>
                <div class="form-group">
                    <label class="form-label">Direccion linea 2</label>
                    <input type="text" class="form-control preview-input" name="contact_address_2" data-preview="contact-address-2"
                           value="<%= contactAddress2 %>" placeholder="Av. Floral S/N">
                </div>
                <div class="form-group">
                    <label class="form-label">Horario de atencion</label>
                    <input type="text" class="form-control preview-input" name="contact_hours" data-preview="contact-hours"
                           value="<%= contactHours %>" placeholder="Lunes a viernes 08:00am a 12:00pm">
                </div>
            </div>
            <div class="config-preview">
                <div class="config-preview-header">Preview (Footer)</div>
                <div class="config-preview-content">
                    <div class="preview-footer-about">
                        <span class="preview-footer-about-brand">Portal OTI</span>
                        <div class="preview-contacto">
                            <div class="preview-contacto-item" id="contact-address-item" style="display:none;">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
                                <div><div class="preview-contacto-label">Direccion</div><span id="preview-contact-address"></span><span id="preview-contact-address-2"></span></div>
                            </div>
                            <div class="preview-contacto-item" id="contact-email-item" style="display:none;">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                                <div><div class="preview-contacto-label">Email</div><span id="preview-contact-email"></span></div>
                            </div>
                            <div class="preview-contacto-item" id="contact-phone-item" style="display:none;">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                                <div><div class="preview-contacto-label">Telefono</div><span id="preview-contact-phone"></span></div>
                            </div>
                            <div class="preview-contacto-item" id="contact-hours-item" style="display:none;">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                                <div><div class="preview-contacto-label">Horario</div><span id="preview-contact-hours"></span></div>
                            </div>
                            <div id="no-contact" style="color:#64748B;font-size:12px;text-align:center;">Ingresa datos de contacto para ver el preview</div>
                        </div>
                        <div class="preview-redes" id="preview-redes" style="border-top: 1px solid rgba(148,163,184,0.15); margin-top: 16px; padding-top: 16px;">
                            <a href="#" id="social-twitter" style="display:none;"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg></a>
                            <a href="#" id="social-facebook" style="display:none;"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg></a>
                            <a href="#" id="social-instagram" style="display:none;"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z"/></svg></a>
                            <a href="#" id="social-linkedin" style="display:none;"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 01-2.063-2.065 2.064 2.064 0 112.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODULO 5: FirmaUNA -->
    <div class="admin-card config-module" id="mod-firma" style="margin-bottom: 24px;">
        <div class="admin-card-header">
            <h3 class="admin-card-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; vertical-align: middle;"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
                FirmaUNA
            </h3>
            <button type="submit" class="btn-save-module">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Guardar
            </button>
        </div>
        <div class="config-split" style="padding: 24px;">
            <div class="config-form">
                <h6 style="font-size: 0.82rem; font-weight: 600; color: var(--heading-color); margin-bottom: 12px;">Instaladores (subir archivo)</h6>
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Windows</label>
                            <input type="hidden" name="firma_windows_url" id="firma_windows_url_val" value="<%= firmaWin %>">
                            <div class="upload-firma-area <%= firmaWin.isEmpty() ? "" : "has-file" %>" id="firma_windows_url_area" data-key="firma_windows_url">
                                <% if (!firmaWin.isEmpty()) { %>
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#0891B2" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                <div class="firma-fname"><%= firmaWin.substring(firmaWin.lastIndexOf('/') + 1) %></div>
                                <button type="button" class="firma-remove" data-key="firma_windows_url">Quitar</button>
                                <% } else { %>
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                <div class="upload-config-name">Subir instalador</div>
                                <% } %>
                            </div>
                            <input type="file" accept=".exe,.msi,.zip" style="display:none" id="firma_windows_url_file">
                            <div class="form-text">Max 200MB (.exe .msi .zip)</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Linux</label>
                            <input type="hidden" name="firma_linux_url" id="firma_linux_url_val" value="<%= firmaLinux %>">
                            <div class="upload-firma-area <%= firmaLinux.isEmpty() ? "" : "has-file" %>" id="firma_linux_url_area" data-key="firma_linux_url">
                                <% if (!firmaLinux.isEmpty()) { %>
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#0891B2" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                <div class="firma-fname"><%= firmaLinux.substring(firmaLinux.lastIndexOf('/') + 1) %></div>
                                <button type="button" class="firma-remove" data-key="firma_linux_url">Quitar</button>
                                <% } else { %>
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                <div class="upload-config-name">Subir instalador</div>
                                <% } %>
                            </div>
                            <input type="file" accept=".tar.gz,.gz,.tar,.sh,.deb,.rpm,.appimage,.zip" style="display:none" id="firma_linux_url_file">
                            <div class="form-text">Max 200MB (.tar.gz .sh .deb .rpm .zip)</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Mac</label>
                            <input type="hidden" name="firma_mac_url" id="firma_mac_url_val" value="<%= firmaMac %>">
                            <div class="upload-firma-area <%= firmaMac.isEmpty() ? "" : "has-file" %>" id="firma_mac_url_area" data-key="firma_mac_url">
                                <% if (!firmaMac.isEmpty()) { %>
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#0891B2" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                <div class="firma-fname"><%= firmaMac.substring(firmaMac.lastIndexOf('/') + 1) %></div>
                                <button type="button" class="firma-remove" data-key="firma_mac_url">Quitar</button>
                                <% } else { %>
                                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                                <div class="upload-config-name">Subir instalador</div>
                                <% } %>
                            </div>
                            <input type="file" accept=".dmg,.pkg,.zip" style="display:none" id="firma_mac_url_file">
                            <div class="form-text">Max 200MB (.dmg .pkg .zip)</div>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">FirmaPeru (PCM)</label>
                    <input type="url" class="form-control" name="url_firmaperu"
                           value="<%= urlFirmaPeru %>" placeholder="https://apps.firmaperu.gob.pe/web">
                </div>

                <hr style="margin: 20px 0; border-color: var(--border-color);">
                <h6 style="font-size: 0.82rem; font-weight: 600; color: var(--heading-color); margin-bottom: 12px;">Videos Tutoriales (YouTube ID)</h6>
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Video Windows</label>
                            <input type="text" class="form-control" name="firma_video_windows"
                                   value="<%= videoWin %>" placeholder="v3u0W_ErpcM">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Video Linux</label>
                            <input type="text" class="form-control" name="firma_video_linux"
                                   value="<%= videoLinux %>" placeholder="AbVs45G9QzY">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="form-label">Video Mac</label>
                            <input type="text" class="form-control" name="firma_video_mac"
                                   value="<%= videoMac %>" placeholder="kAEBtke6HBk">
                        </div>
                    </div>
                </div>
            </div>
            <div class="config-preview">
                <div class="config-preview-header">Preview</div>
                <div class="config-preview-content">
                    <div class="preview-firma">
                        <div class="preview-firma-title">FirmaUNA</div>
                        <div class="preview-firma-btns">
                            <a href="<%= firmaWin.isEmpty() ? "#" : firmaWin %>" id="preview-firma-win" class="preview-firma-btn" style="<%= firmaWin.isEmpty() ? "opacity:0.5;pointer-events:none;" : "" %>">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2" ry="2"></rect><line x1="2" y1="2" x2="22" y2="22"></line></svg>
                                Windows
                            </a>
                            <a href="<%= firmaLinux.isEmpty() ? "#" : firmaLinux %>" id="preview-firma-linux" class="preview-firma-btn" style="<%= firmaLinux.isEmpty() ? "opacity:0.5;pointer-events:none;" : "" %>">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2" ry="2"></rect><line x1="2" y1="2" x2="22" y2="22"></line></svg>
                                Linux
                            </a>
                            <a href="<%= firmaMac.isEmpty() ? "#" : firmaMac %>" id="preview-firma-mac" class="preview-firma-btn" style="<%= firmaMac.isEmpty() ? "opacity:0.5;pointer-events:none;" : "" %>">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2" ry="2"></rect><line x1="2" y1="2" x2="22" y2="22"></line></svg>
                                Mac
                            </a>
                        </div>
                        <% if (!urlFirmaPeru.isEmpty()) { %>
                        <a href="<%= urlFirmaPeru %>" target="_blank" class="preview-firma-btn" style="background:#4B5563;margin-bottom:16px;">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>
                            FirmaPeru (PCM)
                        </a>
                        <% } %>
                        <% if (!videoWin.isEmpty() || !videoLinux.isEmpty() || !videoMac.isEmpty()) { %>
                        <div class="preview-firma-title" style="font-size:12px;margin-bottom:8px;">Tutoriales</div>
                        <div class="preview-firma-videos">
                            <div class="preview-firma-video">
                                <% if (!videoWin.isEmpty()) { %><img src="https://img.youtube.com/vi/<%= videoWin %>/mqdefault.jpg"><% } else { %><div style="background:#E2E8F0;height:100%;display:flex;align-items:center;justify-content:center;color:#94A3B8;font-size:10px;">Sin video</div><% } %>
                            </div>
                            <div class="preview-firma-video">
                                <% if (!videoLinux.isEmpty()) { %><img src="https://img.youtube.com/vi/<%= videoLinux %>/mqdefault.jpg"><% } else { %><div style="background:#E2E8F0;height:100%;display:flex;align-items:center;justify-content:center;color:#94A3B8;font-size:10px;">Sin video</div><% } %>
                            </div>
                            <div class="preview-firma-video">
                                <% if (!videoMac.isEmpty()) { %><img src="https://img.youtube.com/vi/<%= videoMac %>/mqdefault.jpg"><% } else { %><div style="background:#E2E8F0;height:100%;display:flex;align-items:center;justify-content:center;color:#94A3B8;font-size:10px;">Sin video</div><% } %>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- MODULO 6: Footer -->
    <div class="admin-card config-module" id="mod-footer" style="margin-bottom: 24px;">
        <div class="admin-card-header">
            <h3 class="admin-card-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-color)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 8px; vertical-align: middle;"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect><line x1="3" y1="9" x2="21" y2="9"></line><line x1="9" y1="21" x2="9" y2="9"></line></svg>
                Footer
            </h3>
            <button type="submit" class="btn-save-module">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
                Guardar
            </button>
        </div>
        <div class="config-split" style="padding: 24px;">
            <div class="config-form">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Marca</label>
                            <input type="text" class="form-control preview-input" name="footer_brand" data-preview="footer-brand"
                                   value="<%= footerBrand %>" placeholder="Portal OTI">
                            <div class="form-text">Nombre que aparece al lado del logo en el footer</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Desarrollador</label>
                            <input type="text" class="form-control preview-input" name="footer_developer" data-preview="footer-developer"
                                   value="<%= footerDeveloper %>" placeholder="Subunidad de Gobierno Electronico">
                            <div class="form-text">Credito que aparece en la linea inferior del footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="config-preview">
                <div class="config-preview-header">Preview</div>
                <div class="config-preview-content">
                    <div class="preview-footer">
                        <span class="preview-footer-brand" id="preview-footer-brand"><%= footerBrand.isEmpty() ? "Portal OTI" : footerBrand %></span> &copy; <span id="preview-footer-year"><%= java.time.Year.now().getValue() %></span> | <span id="preview-footer-developer"><%= footerDeveloper.isEmpty() ? "Subunidad de Gobierno Electrónico" : footerDeveloper %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</form>

<script>
(function() {
    var tabs = document.querySelectorAll('.config-tab');
    var modules = document.querySelectorAll('.config-module');

    tabs.forEach(function(tab) {
        tab.addEventListener('click', function() {
            var target = this.getAttribute('data-mod');
            tabs.forEach(function(t) { t.classList.remove('active'); });
            modules.forEach(function(m) { m.classList.remove('active'); });
            this.classList.add('active');
            var mod = document.getElementById(target);
            if (mod) mod.classList.add('active');
        });
    });
})();

document.querySelectorAll('.upload-config-area').forEach(function(area) {
    var key = area.getAttribute('data-key');
    var fileInput = document.getElementById(key + '_file');
    var valInput = document.getElementById(key + '_val');

    area.addEventListener('click', function() { fileInput.click(); });
    area.addEventListener('dragover', function(e) { e.preventDefault(); area.classList.add('dragover'); });
    area.addEventListener('dragleave', function() { area.classList.remove('dragover'); });
    area.addEventListener('drop', function(e) {
        e.preventDefault();
        area.classList.remove('dragover');
        if (e.dataTransfer.files.length) { uploadFile(key, e.dataTransfer.files[0]); }
    });
    fileInput.addEventListener('change', function() {
        if (fileInput.files.length) { uploadFile(key, fileInput.files[0]); }
    });
});

function uploadFile(key, file) {
    var area = document.getElementById(key + '_area');
    var valInput = document.getElementById(key + '_val');
    var formData = new FormData();
    formData.append('file', file);
    area.innerHTML = '<div style="padding:12px;color:#64748B;font-size:13px;">Subiendo...</div>';

    fetch('${pageContext.request.contextPath}/adm/configuracion/upload-image', {
        method: 'POST',
        body: formData
    }).then(function(r) { return r.json(); })
      .then(function(d) {
        if (d.url) {
            valInput.value = d.url;
            area.innerHTML = '<img src="' + d.url + '" style="max-height:80px;border-radius:6px;margin-bottom:8px;"><div class="upload-config-name">Imagen subida</div>';
            updateImagePreview(key, d.url);
        } else {
            area.innerHTML = '<svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#DC3545" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg><div class="upload-config-name" style="color:#DC3545;">' + (d.error || 'Error') + '</div>';
            setTimeout(function() { window.location.reload(); }, 2000);
        }
    }).catch(function() {
        area.innerHTML = '<svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#DC3545" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg><div class="upload-config-name" style="color:#DC3545;">Error de conexion</div>';
    });
}

function updateImagePreview(key, url) {
    if (key === 'hero_image') {
        var el = document.getElementById('preview-hero-img');
        if (el) el.src = url;
    }
}

// ── FirmaUNA: instaladores (subida/borrado diferido hasta "Guardar") ──
var firmaPending = {};
var firmaRemoved = {};

document.querySelectorAll('.upload-firma-area').forEach(function(area) {
    var key = area.getAttribute('data-key');
    var fileInput = document.getElementById(key + '_file');

    area.addEventListener('click', function(e) {
        if (e.target.classList.contains('firma-remove')) return;
        fileInput.click();
    });
    area.addEventListener('dragover', function(e) { e.preventDefault(); area.classList.add('dragover'); });
    area.addEventListener('dragleave', function() { area.classList.remove('dragover'); });
    area.addEventListener('drop', function(e) {
        e.preventDefault();
        area.classList.remove('dragover');
        if (e.dataTransfer.files.length) { selectFirmaFile(key, e.dataTransfer.files[0]); }
    });
    fileInput.addEventListener('change', function() {
        if (fileInput.files.length) { selectFirmaFile(key, fileInput.files[0]); }
    });
});

function selectFirmaFile(key, file) {
    firmaPending[key] = file;
    delete firmaRemoved[key];
    var area = document.getElementById(key + '_area');
    area.classList.add('has-file');
    var sizeMB = (file.size / (1024 * 1024)).toFixed(1);
    area.innerHTML =
        '<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#D97706" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>' +
        '<div class="firma-fname firma-pending">' + file.name + ' (' + sizeMB + ' MB)</div>' +
        '<div class="upload-config-name firma-pending">Pendiente - se subira al Guardar</div>' +
        '<button type="button" class="firma-remove" data-key="' + key + '">Quitar</button>';
    bindFirmaRemove(area.querySelector('.firma-remove'));
    updateFirmaPreview(key, file.name, true);
}

function updateFirmaPreview(key, label, pending) {
    var map = {
        'firma_windows_url': 'preview-firma-win',
        'firma_linux_url': 'preview-firma-linux',
        'firma_mac_url': 'preview-firma-mac'
    };
    var el = document.getElementById(map[key]);
    if (!el) return;
    el.style.opacity = '1';
    el.style.pointerEvents = 'auto';
    el.href = '#';
    var txt = el.lastChild;
    if (txt && txt.nodeType === 3) {
        txt.textContent = ' ' + (pending ? (label + ' (pendiente)') : label);
    }
}

function revertFirmaPreview(key) {
    var map = {
        'firma_windows_url': 'preview-firma-win',
        'firma_linux_url': 'preview-firma-linux',
        'firma_mac_url': 'preview-firma-mac'
    };
    var el = document.getElementById(map[key]);
    if (!el) return;
    var label = key === 'firma_windows_url' ? 'Windows' : key === 'firma_linux_url' ? 'Linux' : 'Mac';
    el.style.opacity = '0.5';
    el.style.pointerEvents = 'none';
    el.href = '#';
    var txt = el.lastChild;
    if (txt && txt.nodeType === 3) {
        txt.textContent = ' ' + label;
    }
}

function bindFirmaRemove(btn) {
    if (!btn) return;
    btn.addEventListener('click', function(e) {
        e.stopPropagation();
        var key = this.getAttribute('data-key');
        var hadSaved = document.getElementById(key + '_val').value;
        delete firmaPending[key];
        document.getElementById(key + '_file').value = '';
        document.getElementById(key + '_val').value = '';
        // Borrado diferido: solo se elimina del disco al presionar "Guardar"
        if (hadSaved) {
            firmaRemoved[key] = true;
        }
        revertFirmaPreview(key);
        var area = document.getElementById(key + '_area');
        area.classList.remove('has-file');
        area.innerHTML =
            '<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#94A3B8" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>' +
            '<div class="upload-config-name">Subir instalador</div>';
    });
}

document.querySelectorAll('.firma-remove').forEach(bindFirmaRemove);

function uploadPendingFirma() {
    var keys = Object.keys(firmaPending);
    if (keys.length === 0) return Promise.resolve();
    return Promise.all(keys.map(function(key) {
        var fd = new FormData();
        fd.append('file', firmaPending[key]);
        fd.append('key', key);
        return fetch('${pageContext.request.contextPath}/adm/configuracion/upload-firma', {
            method: 'POST',
            body: fd
        }).then(function(r) { return r.json(); })
          .then(function(d) {
            if (d.url) {
                document.getElementById(key + '_val').value = d.url;
                delete firmaPending[key];
            } else {
                throw new Error(d.error || 'Error al subir instalador');
            }
        });
    }));
}

document.querySelectorAll('.preview-input').forEach(function(input) {
    input.addEventListener('input', function() {
        var previewId = this.getAttribute('data-preview');
        var value = this.value;
        var el = document.getElementById('preview-' + previewId);
        if (el) {
            if (this.tagName === 'TEXTAREA') {
                el.textContent = value || '(Vacio)';
            } else {
                el.textContent = value || this.getAttribute('placeholder') || '(Vacio)';
            }
        }
        if (previewId === 'hero-title') {
            el = document.getElementById('preview-hero-title');
            if (el) {
                el.textContent = value || 'OTI - UNA Puno';
                void el.offsetWidth;
            }
        } else if (previewId === 'hero-badge') {
            el = document.getElementById('preview-hero-badge');
            if (el) el.textContent = value || 'SUBTITULO';
        } else if (previewId === 'hero-desc') {
            el = document.getElementById('preview-hero-desc');
            if (el) el.textContent = value || 'Descripcion del hero...';
        } else if (previewId === 'seo-title') {
            el = document.getElementById('preview-seo-title');
            if (el) el.textContent = value || 'Titulo del sitio';
        } else if (previewId === 'seo-desc') {
            el = document.getElementById('preview-seo-desc');
            if (el) el.textContent = value || 'Descripcion del sitio para SEO...';
        } else if (previewId === 'footer-brand') {
            el = document.getElementById('preview-footer-brand');
            if (el) el.textContent = value || 'Portal OTI';
        } else if (previewId === 'footer-developer') {
            el = document.getElementById('preview-footer-developer');
            if (el) el.textContent = value || 'Subunidad de Gobierno Electrónico';
        } else if (previewId.startsWith('social-')) {
            el = document.getElementById(previewId);
            if (el) el.style.display = value ? 'flex' : 'none';
        } else if (previewId.startsWith('contact-')) {
            updateContactPreview();
        }
    });
});

function updateContactPreview() {
    var fields = ['contact-address', 'contact-address-2', 'contact-email', 'contact-phone', 'contact-hours'];
    var hasAny = false;
    fields.forEach(function(f) {
        var input = document.querySelector('[name="' + f.replace(/-/g, '_') + '"]');
        var value = input ? input.value : '';
        var item = document.getElementById(f + '-item');
        var preview = document.getElementById('preview-' + f);
        if (item && preview) {
            if (value) {
                hasAny = true;
                item.style.display = 'flex';
                preview.textContent = value;
            } else {
                item.style.display = 'none';
            }
        }
    });
    var noContact = document.getElementById('no-contact');
    if (noContact) noContact.style.display = hasAny ? 'none' : 'block';
}

// Inicializar previews con los valores ya guardados en la BD
(function initPreviews() {
    document.querySelectorAll('.preview-input').forEach(function(input) {
        var previewId = input.getAttribute('data-preview');
        var value = input.value;
        if (previewId && previewId.startsWith('social-')) {
            var el = document.getElementById(previewId);
            if (el) el.style.display = value ? 'flex' : 'none';
        }
    });
    updateContactPreview();
})();

function isValidYouTubeId(val) {
    if (!val) return true; // vacio permitido
    val = val.trim();
    if (/^[A-Za-z0-9_-]{11}$/.test(val)) return true;
    if (/youtu\.?be/.test(val)) return true;
    return false;
}

document.querySelectorAll('.btn-save-module').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
        e.preventDefault();
        var form = document.querySelector('.form-admin');

        // Validar IDs de YouTube de FirmaUNA
        var videoFields = ['firma_video_windows', 'firma_video_linux', 'firma_video_mac'];
        for (var i = 0; i < videoFields.length; i++) {
            var inp = form.querySelector('[name="' + videoFields[i] + '"]');
            if (inp && !isValidYouTubeId(inp.value)) {
                showToast('error', 'El ID de video de ' + videoFields[i].replace('firma_video_', '') + ' no es valido (11 caracteres o URL de YouTube)');
                return;
            }
        }

        var original = btn.innerHTML;
        btn.classList.add('saving');
        btn.textContent = 'Guardando...';

        uploadPendingFirma().then(function() {
            var data = new FormData(form);
            var params = new URLSearchParams();
            data.forEach(function(value, key) {
                if (key === 'hero_video_autoplay') {
                    params.append(key, 'on');
                } else {
                    params.append(key, value);
                }
            });

            Object.keys(firmaRemoved).forEach(function(key) {
                params.append('firma_delete_' + key, '1');
            });

            return fetch(form.action, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: params.toString()
            });
        }).then(function(r) {
            if (r.redirected) {
                showToast('success', 'Guardado');
                btn.classList.remove('saving');
                btn.innerHTML = original;
                setTimeout(function() { window.location.reload(); }, 1000);
            }
        }).catch(function(err) {
            showToast('error', err.message || 'Error al guardar');
            btn.classList.remove('saving');
            btn.innerHTML = original;
        });
    });
});
</script>