-- Script de inicialización: Base de datos Admin OTI
-- Se ejecuta automáticamente al crear el volumen PostgreSQL

-- Crear base de datos separada
CREATE DATABASE oti_admin;

-- Crear usuario dedicado
CREATE USER oti_admin WITH PASSWORD 'admin_secure_pass_2026';

-- Otorgar permisos
GRANT ALL PRIVILEGES ON DATABASE oti_admin TO oti_admin;

-- Conectar a la nueva BD para crear tablas
\c oti_admin;

-- Otorgar permisos de esquema y por defecto para tablas futuras
GRANT ALL ON SCHEMA public TO oti_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO oti_admin;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO oti_admin;

----------------------------------------------------
-- Tabla: usuarios admin
----------------------------------------------------
CREATE TABLE admin_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nombre VARCHAR(100),
    email VARCHAR(100),
    rol VARCHAR(20) DEFAULT 'editor',
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: enlaces
----------------------------------------------------
CREATE TABLE enlaces (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    url VARCHAR(500) NOT NULL,
    descripcion TEXT,
    abrir_nueva_pestana BOOLEAN DEFAULT true,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: actividades (carrusel home)
----------------------------------------------------
CREATE TABLE actividades (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    tipo VARCHAR(100) DEFAULT 'institucional',
    descripcion TEXT,
    fecha DATE,
    imagen_url VARCHAR(500),
    enlace_id INT REFERENCES enlaces(id) ON DELETE SET NULL,
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: plana directiva
----------------------------------------------------
CREATE TABLE plana_directiva (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    cargo VARCHAR(100),
    descripcion TEXT,
    foto_url VARCHAR(500),
    linkedin_url VARCHAR(500),
    twitter_url VARCHAR(500),
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: configuración (key-value)
----------------------------------------------------
CREATE TABLE configuracion (
    clave VARCHAR(100) PRIMARY KEY,
    valor TEXT,
    tipo VARCHAR(20) DEFAULT 'string',
    descripcion VARCHAR(255),
    updated_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: servicios (sección homepage)
----------------------------------------------------
CREATE TABLE servicios (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    imagen_url VARCHAR(500),
    enlace_id INT REFERENCES enlaces(id) ON DELETE SET NULL,
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: unidades (subunidades OTI)
----------------------------------------------------
CREATE TABLE unidades (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    enlace_id INT REFERENCES enlaces(id) ON DELETE SET NULL,
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Tabla: documentos (normativas, leyes, etc.)
----------------------------------------------------
CREATE TABLE documentos (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    url VARCHAR(500),
    archivo_url VARCHAR(500),
    tipo VARCHAR(100),
    orden INT DEFAULT 0,
    activo BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW()
);

----------------------------------------------------
-- Datos iniciales
----------------------------------------------------

-- Admin inicial (password: admin123 -> BCrypt hash)
INSERT INTO admin_users (username, password_hash, nombre, rol)
VALUES ('admin', '$2a$10$2fyFQ9ksI0xARqxDdjNgJ.0ln43EOKY.LzuuSDs7D1lSc9GKJJff.', 'Administrador OTI', 'superadmin');

-- Configuración por defecto
INSERT INTO configuracion (clave, valor, tipo, descripcion) VALUES
('hero_video_id', '', 'string', 'YouTube video ID para hero'),
('hero_video_autoplay', 'true', 'boolean', 'Auto-reproducir video hero'),
('hero_subtitle', 'UNIVERSIDAD NACIONAL DEL ALTIPLANO', 'string', 'Subtítulo del hero'),
('hero_description', 'Más de 24 años desarrollando soluciones informáticas y de telecomunicaciones para la comunidad universitaria. Impulsados por la Transformación Digital.', 'text', 'Descripción del hero'),
('hero_image', '/assets/img/oti-1.jpg', 'image', 'Imagen del hero'),
('site_title', 'OTI - UNA Puno', 'string', 'Título del sitio'),
('site_description', 'Oficina de Tecnologías de la Información', 'string', 'Descripción SEO'),
('site_logo', 'https://oti.unap.edu.pe/recursos/oti-ofic.png', 'image', 'Logo del sitio'),
('site_favicon', 'https://oti.unap.edu.pe/recursos/oti-icon.png', 'image', 'Favicon del sitio'),
('social_twitter', '', 'url', 'URL de Twitter/X'),
('social_facebook', '', 'url', 'URL de Facebook'),
('social_instagram', '', 'url', 'URL de Instagram'),
('social_linkedin', '', 'url', 'URL de LinkedIn'),
('contact_email', '', 'string', 'Email de contacto'),
('contact_phone', '', 'string', 'Teléfono de contacto'),
('contact_address', 'Ciudad Universitaria', 'string', 'Dirección línea 1'),
('contact_address_2', 'Av. Floral S/N', 'string', 'Dirección línea 2'),
('contact_hours', 'Lunes a viernes 08:00am a 12:00pm', 'string', 'Horario de atención'),
('footer_brand', 'Portal OTI', 'string', 'Nombre en footer'),
('footer_developer', 'Subunidad de Gobierno Electrónico', 'string', 'Crédito en footer'),
('url_campus_virtual', 'https://campus.unap.edu.pe/', 'url', 'URL Campus Virtual'),
('url_firmaperu', 'https://apps.firmaperu.gob.pe/web', 'url', 'URL FirmaPeru'),
('firma_windows_url', '', 'url', 'Instalador Windows'),
('firma_linux_url', '', 'url', 'Instalador Linux'),
('firma_mac_url', '', 'url', 'Instalador Mac'),
('firma_video_windows', 'v3u0W_ErpcM', 'string', 'Video tutorial Windows'),
('firma_video_linux', 'AbVs45G9QzY', 'string', 'Video tutorial Linux'),
('firma_video_mac', 'kAEBtke6HBk', 'string', 'Video tutorial Mac');

-- Enlaces iniciales
INSERT INTO enlaces (titulo, url, descripcion) VALUES
('Campus Virtual', 'https://campus.unap.edu.pe/', 'Ver mas'),
('Correo Institucional', 'http://oti.servicios.unap.edu.pe/', 'Ver mas');

-- Actividades de ejemplo (sin enlace por defecto)
INSERT INTO actividades (titulo, descripcion, fecha, imagen_url, orden) VALUES
('Toma de Imágenes para Carnet Universitario 2025', 'La UNA Puno realizó la toma de fotografías para el carné universitario en el Edificio de 15 pisos.', '2025-03-15', '/assets/img/notis/foto02.jpg', 1),
('Implementación del Sistema de Firma Digital', 'La OTI implementó el nuevo sistema de firma digital para la UNA Puno.', '2025-06-01', '/assets/img/notis/foto04.jpg', 2);

-- Plana directiva de ejemplo
INSERT INTO plana_directiva (nombre, cargo, descripcion, foto_url, orden) VALUES
('Juan Pérez García', 'Director OTI', 'Director de la Oficina de Tecnologías de la Información', '/assets/img/pers/default.jpg', 1),
('María López Vargas', 'Subdirectora OTI', 'Subdirectora de la Oficina de Tecnologías de la Información', '/assets/img/pers/default.jpg', 2);

-- Servicios de ejemplo (con enlace_id a enlaces ya creados)
INSERT INTO servicios (titulo, descripcion, imagen_url, enlace_id, orden) VALUES
('Campus Virtual', 'Accede a los diferentes servicios académicos, correo institucional, plataformas de aprendizaje y más', '', 1, 1),
('Correo Institucional', 'Solicita tu correo institucional o recupéralo por este acceso', '', 2, 2);

-- Unidades de ejemplo (sin enlace por defecto)
INSERT INTO unidades (titulo, descripcion, orden) VALUES
('Soporte y Mantenimiento', 'Técnicos e Ingenieros capacitados para dar soporte y mantenimiento a los equipos de cómputo, infraestructura tecnológica y sistemas de la universidad.', 1),
('Redes y Telecomunicaciones', 'Ingenieros especializados en telecomunicaciones, redes de datos, infraestructura de red y conectividad para toda la universidad.', 2),
('Gobierno Electrónico', 'Software Institucional de Firma Digital con integración a FirmaPeru de la P.C.M. y Plataforma de Identidad Digital para acceso sin contraseñas.', 3),
('Desarrollo de Software', 'Ingenieros especialistas en desarrollo de software, creación de sistemas de información, aplicaciones web y plataformas académicas para la universidad.', 4);

-- Documentos de ejemplo (seed)
INSERT INTO documentos (titulo, descripcion, url, tipo, orden) VALUES
('NTP ISO/IEC 27001:2022', 'Norma Tecnica Peruana que establece los requisitos para establecer, implementar, mantener y mejorar continuamente un sistema de gestion de seguridad de la informacion (SGSI).', 'https://app-intra.saludpol.gob.pe/wp-content/uploads/2025/02/4.-NTP-ISO-27001-2022.pdf', 'Norma', 1),
('Ley N° 29733', 'Ley que regula la proteccion de datos personales, el derecho al honor a la intimidad personal y familiar y a la vida privada de las personas.', 'https://cdn.www.gob.pe/uploads/document/file/272360/Ley%20N%C2%BA%2029733.pdf.pdf?v=1618338779', 'Ley', 2);

----------------------------------------------------
-- Permisos explícitos para tablas ya creadas
----------------------------------------------------
GRANT ALL ON TABLE admin_users TO oti_admin;
GRANT ALL ON TABLE enlaces TO oti_admin;
GRANT ALL ON TABLE actividades TO oti_admin;
GRANT ALL ON TABLE plana_directiva TO oti_admin;
GRANT ALL ON TABLE configuracion TO oti_admin;
GRANT ALL ON TABLE servicios TO oti_admin;
GRANT ALL ON TABLE unidades TO oti_admin;
GRANT ALL ON TABLE documentos TO oti_admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO oti_admin;

----------------------------------------------------
-- Migraciones (seguras para BD existentes)
----------------------------------------------------
ALTER TABLE actividades ADD COLUMN IF NOT EXISTS fecha DATE;
INSERT INTO configuracion (clave, valor, tipo, descripcion) VALUES
('firma_windows_name', '', 'string', 'Nombre original instalador Windows'),
('firma_linux_name', '', 'string', 'Nombre original instalador Linux'),
('firma_mac_name', '', 'string', 'Nombre original instalador Mac')
ON CONFLICT (clave) DO NOTHING;
