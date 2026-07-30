# PaginaOTI

Jakarta EE web application (JSP/Servlet) para OTI (Oficina de Tecnologías de la Información) — UNA Puno. Framework MVC propio (JxMVC) + PostgreSQL.

---

## 🚀 Desarrollo Local (Docker)

### Requisitos
- Docker 20+ y Docker Compose
- Puerto 8080 libre (Tomcat)
- Puerto 5432 libre (PostgreSQL)

### Levantar
```bash
git clone https://github.com/<tu-usuario>/PaginaOti.git
cd PaginaOti
docker-compose up --build -d
```

### Accesos
| Servicio | URL | Credenciales |
|---|---|---|
| **App pública** | http://localhost:8080 | — |
| **Admin** | http://localhost:8080/adm/ | `admin` / `admin123` |
| **PostgreSQL** | `localhost:5432` | `oti_admin` / `admin_secure_pass_2026` / db: `oti_admin` |

### Volúmenes persistentes (solo desarrollo)
Los siguientes directorios se montan desde el host para que las subidas de imágenes persistan entre rebuilds:

```
./assets/img/notis  → /assets/img/notis   (actividades/noticias)
./assets/img/pers   → /assets/img/pers    (plana directiva)
./assets/img/config → /assets/img/config  (logo, favicon, hero)
./assets/img/firma  → /assets/img/firma   (instaladores FirmaUNA)
./assets/img/servs  → /assets/img/servs   (servicios)
./assets/img/docs   → /assets/img/docs    (documentación PDF)
```

### Logs y debugging
```bash
docker-compose logs -f app   # logs Tomcat
docker-compose logs -f db    # logs PostgreSQL
```

---

## 🏭 Despliegue en Producción

### Arquitectura
- **PostgreSQL 16**: Servidor dedicado (fuera de Docker)
- **Tomcat 10 + JDK 17**: Instalado nativo en el servidor
- **Nginx/Apache**: Reverse proxy (puerto 80/443 → 8080)
- **Archivos subidos**: Filesystem real del servidor (`/assets/img/`)

> En producción **no se usa Docker Compose para la app**, solo para la BD si se desea. El WAR se despliega directo en Tomcat.

### 1. Compilar WAR
Opción A — Maven (requiere `pom.xml` en source):
```bash
mvn clean package
# genera target/ROOT.war
```

Opción B — Docker (usa el Dockerfile del repo):
```bash
docker build -t paginaoti-app .
# copiar WAR desde container o usar multi-stage build
```

### 2. Configurar `META-INF/context.xml` (producción)
Edita antes de empaquetar o sobrescribe en `$CATALINA_HOME/webapps/ROOT/META-INF/context.xml`:

> **Nota**: Usa `type="javax.sql.DataSource"` (API del JDK `java.sql`). El nombre `jakarta.sql.DataSource` **no es correcto** para Tomcat/JNDI — causaba `NamingException` y fue revertido.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context path="">
    <!-- API Tickets (cambiar por valores reales) -->
    <Parameter name="OTI_API_KEY" value="<TU_API_KEY_REAL>" override="false"/>
    <Parameter name="OTI_API_BASE" value="https://api.tu-dominio.com" override="false"/>

    <!-- DataSource PostgreSQL -->
    <Resource name="jdbc/OtiAdminDB"
        auth="Container" type="javax.sql.DataSource"
        driverClassName="org.postgresql.Driver"
        url="jdbc:postgresql://<DB_HOST>:5432/oti_admin"
        username="oti_admin" password="<PASSWORD_SEGURO>"
        maxTotal="20" maxIdle="10" maxWaitMillis="-1"
        validationQuery="SELECT 1" testOnBorrow="true"/>
</Context>
```

### 3. Desplegar en Tomcat
```bash
# Copiar WAR
cp target/ROOT.war $CATALINA_HOME/webapps/

# O desplegar estructura expandida
cp -r * $CATALINA_HOME/webapps/ROOT/
```

### 4. Configurar Nginx (SSL opcional)
```nginx
server {
    listen 80;
    server_name oti.unap.edu.pe;

    # Redirect HTTP → HTTPS (si usas Let's Encrypt)
    # return 301 https://$server_name$request_uri;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Archivos estáticos servidos por Nginx (opcional, mejor rendimiento)
    location /assets/ {
        alias /ruta/real/assets/;
        expires 30d;
        add_header Cache-Control "public";
    }
}
```

### 5. Variables críticas — Dev vs Prod

| Variable | Desarrollo | Producción |
|---|---|---|
| `POSTGRES_PASSWORD` | `admin_secure_pass_2026` | **Password fuerte único** (20+ chars) |
| `OTI_API_KEY` | API key real de tickets | **Key real de API tickets** |
| `OTI_API_BASE` | `http://host.docker.internal:8000` | `https://api.tu-dominio.com` |
| `context.xml url` | `jdbc:postgresql://db:5432/oti_admin` | `jdbc:postgresql://<DB_HOST>:5432/oti_admin` |
| `context.xml password` | `admin_secure_pass_2026` | **Mismo password seguro de BD** |
| `context.xml type` | `javax.sql.DataSource` (correcto, API del JDK) | `javax.sql.DataSource` (correcto) |

### Backup de base de datos
```bash
# Backup manual
pg_dump -h <DB_HOST> -U oti_admin oti_admin > backup_$(date +%F).sql

# Restaurar
psql -h <DB_HOST> -U oti_admin oti_admin < backup_2026-07-24.sql
```

---

## 📁 Estructura del Proyecto

```
ROOT/
├── index.jsp              # Entry point → forward a BaseController
├── solicitud.jsp          # Formulario unificado tickets/solicitudes
├── documentacion.jsp      # Página documentación (ISO 27001, Ley 29733)
├── firmaUNA.jsp           # Página pública descargas FirmaUNA
├── historia-oti.jsp       # Página historia OTI (timeline + jefaturas)
├── servicios.jsp          # Página servicios (legacy, no usada en home)
├── unidades.jsp           # Página unidades/subunidades
├── views/
│   ├── web.jsp            # Layout principal (header, nav, footer, hero 3D)
│   ├── lay*.jsp           # Capas hijas (home, servicios, noticias, equipo, etc.)
│   │   ├── layHistoria.jsp
│   │   ├── layFirmaUNA.jsp
│   │   ├── layDocumentacion.jsp
│   │   ├── layServicios.jsp
│   │   ├── laySolicitud.jsp
│   │   ├── layTicket.jsp
│   │   └── layUnidades.jsp
│   ├── api/               # Proxies server-side para API externa
│   │   ├── crear-ticket.jsp
│   │   ├── persona-dni.jsp
│   │   ├── ticket-pdf.jsp
│   │   └── tipo-solicitudes.jsp
│   └── adm/               # Vistas admin
│       ├── layout.jsp     # Sidebar admin + toggle responsive
│       ├── login.jsp      # Login glassmorphism
│       ├── dashboard.jsp
│       ├── configuracion/index.jsp
│       ├── actividades/list.jsp
│       ├── plana-directiva/list.jsp
│       ├── servicios/list.jsp
│       ├── unidades/list.jsp
│       ├── documentos/list.jsp
│       └── usuarios/list.jsp
├── assets/
│   ├── css/
│   │   ├── main.css       # Estilos globales + secciones dark/light
│   │   ├── admin.css      # Panel admin responsivo (grid, card view)
│   │   └── menu.css       # Estilos del menú lateral
│   ├── js/
│   │   ├── main.js
│   │   └── mountain-scene.js   # Three.js hero 3D (wireframe + puntos + estrellas)
│   ├── vendor/            # Bootstrap 5, AOS, GLightbox, Swiper (CDN/local)
│   └── img/               # Imágenes estáticas + subidas
│       ├── notis/         # Actividades/noticias (persistencia dev)
│       ├── pers/          # Plana directiva (persistencia dev)
│       ├── config/        # Logo, favicon, hero image (persistencia dev)
│       ├── firma/         # Instaladores FirmaUNA (persistencia dev)
│       ├── servs/         # Iconos/imágenes servicios (persistencia dev)
│       └── docs/          # Documentación PDF (persistencia dev)
├── WEB-INF/
│   ├── web.xml            # Servlet config, JxRouter, BaseController, AssetxController
│   ├── jx.tld             # Taglib custom <jx:forEach>, <jx:if>
│   ├── classes/jxmvc/     # Clases compiladas (controllers, models, utils, base)
│   └── lib/               # JARs: postgresql, jbcrypt, json, openPDF, mail
├── META-INF/
│   ├── context.xml        # JNDI DataSource + API params (javax.sql.DataSource)
│   └── MANIFEST.MF
├── db-init/
│   └── 01-create-admin-db.sql   # Schema + seed (admin, unidades, servicios, actividades, plana, config, documentos, enlaces)
├── docker-compose.yml     # Dev: app + db + volumes + red oti-net
├── Dockerfile             # Build: Tomcat 10 + JDK 17 + compilación JxMVC
└── AGENTS.md              # Documentación viva del proyecto
```

---

## 🔧 Stack Técnico

| Capa | Tecnología |
|---|---|
| **Backend** | Jakarta EE 9 (Servlet 5, JSP 3), Tomcat 10, JDK 17 |
| **Framework MVC** | JxMVC (custom: `JxRouter`, `BaseController`, `AssetxController`) |
| **BD** | PostgreSQL 16, JDBC, JNDI DataSource |
| **Frontend** | JSP + Bootstrap 5 + AOS + GLightbox + Swiper + Three.js (CDN) |
| **Auth Admin** | Session-based + BCrypt (jBCrypt 0.4) |
| **PDF** | OpenPDF 1.3 for ticket-pdf generation |
| **Build/Deploy** | Docker Compose (dev), WAR + Tomcat nativo (prod) |

---

## 📝 Notas Importantes

- **Header/Footer**: Definidos en `views/web.jsp`. El hero usa Three.js (`mountain-scene.js`) con escena de montañas generativas (Perlin noise), wireframe de puntos animados + estrellas con twinkle.
- **Colores alternados**: Secciones alternan entre oscuro (`#0f172a`, `.section-dark`) y claro (`#f8fafc`, `.section-light`). Hero=dark, Actividades=light, Servicios=dark, Equipo=light, Footer=dark.
- **Carrusel Servicios**: Swiper horizontal responsive (1 slide mobile, 2-3 desktop). Slide fijo "Tramitar solicitud" (gradiente cyan) + slides de servicios de BD. Autoplay solo si >3 slides totales.
- **Carrusel Plana Directiva**: Cilindro 3D con `rotateY` + `translateZ` (inspirado en coverflow). Drag + flechas + dots + autoplay 4s. 5 visible desktop, 3 tablet, 1 móvil.
- **Subida imágenes**: Diferida (solo al guardar). Validación: 5MB, JPG/PNG/WebP/GIF. Instaladores FirmaUNA: 200MB, extensiones específicas.
- **Enlaces normalizados**: Tabla `enlaces` con FK en `actividades`, `servicios`, `unidades`. Admin UI con 3 campos: URL, texto del botón, abrir en nueva pestaña.
- **Panel admin**: Sidebar colapsable (desktop) / overlay (móvil). Tablas responsive con vista de tarjeta en móvil (≤768px). CSS Grid layout + columnas compactas.
- **API Tickets**: Proxy server-side en `views/api/` (`persona-dni.jsp`, `tipo-solicitudes.jsp`, `crear-ticket.jsp`, `ticket-pdf.jsp`). API Key en `context.xml`.
- **Subida PDFs**: `views/api/` proxy protege la API key; `Documento.java` CRUD con upload de PDF (max 10MB) a `assets/img/docs/`.
- **Seguridad**: Password BCrypt real (`jBCrypt 0.4`) sin fallback; `javax.sql.DataSource` es correcto para JNDI (API del JDK, no se renombró a `jakarta.sql.DataSource`).
- **Sin `.env`**: Configuración en `docker-compose.yml` (dev) y `context.xml` (prod).
- **Volúmenes dev**: Solo para desarrollo local (`./assets/img/*` montados en container). En producción, imágenes en filesystem del servidor.