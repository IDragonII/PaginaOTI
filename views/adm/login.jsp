<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin OTI - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://oti.unap.edu.pe/recursos/oti-icon.png" rel="icon">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --primary: #0891B2;
            --primary-light: #22D3EE;
            --primary-dark: #0E7490;
            --surface: rgba(255, 255, 255, 0.12);
            --surface-solid: #ffffff;
            --border: rgba(255, 255, 255, 0.18);
            --text: #0F172A;
            --text-muted: #475569;
            --error-bg: #FEF2F2;
            --error-border: #FECACA;
            --error-text: #DC2626;
        }

        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 40%, #0E7490 70%, #0891B2 100%);
            overflow: hidden;
            position: relative;
        }

        /* ── Animated Background Orbs ─────────────────── */
        .bg-orbs {
            position: fixed;
            inset: 0;
            z-index: 0;
            overflow: hidden;
            pointer-events: none;
        }

        .orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.4;
            animation: orbFloat 12s ease-in-out infinite;
        }

        .orb-1 {
            width: 400px; height: 400px;
            background: radial-gradient(circle, #22D3EE, transparent);
            top: -10%; left: -5%;
            animation-duration: 14s;
        }

        .orb-2 {
            width: 350px; height: 350px;
            background: radial-gradient(circle, #06B6D4, transparent);
            bottom: -15%; right: -8%;
            animation-duration: 18s;
            animation-delay: -4s;
        }

        .orb-3 {
            width: 250px; height: 250px;
            background: radial-gradient(circle, #67E8F9, transparent);
            top: 50%; left: 60%;
            animation-duration: 16s;
            animation-delay: -8s;
        }

        @keyframes orbFloat {
            0%, 100% { transform: translate(0, 0) scale(1); }
            25% { transform: translate(30px, -40px) scale(1.05); }
            50% { transform: translate(-20px, 20px) scale(0.95); }
            75% { transform: translate(40px, 30px) scale(1.02); }
        }

        /* ── Glass Card ───────────────────────────────── */
        .login-wrapper {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 440px;
            padding: 20px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 24px;
            padding: 44px 36px 36px;
            box-shadow:
                0 8px 32px rgba(0, 0, 0, 0.25),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            animation: cardEntry 0.8s cubic-bezier(0.16, 1, 0.3, 1) both;
        }

        @keyframes cardEntry {
            from {
                opacity: 0;
                transform: translateY(30px) scale(0.96);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* ── Logo & Header ────────────────────────────── */
        .login-header {
            text-align: center;
            margin-bottom: 36px;
        }

        .login-logo-wrap {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 72px; height: 72px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            margin-bottom: 20px;
            animation: logoPulse 3s ease-in-out infinite;
        }

        @keyframes logoPulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(34, 211, 238, 0.2); }
            50% { box-shadow: 0 0 0 12px rgba(34, 211, 238, 0); }
        }

        .login-logo-wrap img {
            height: 40px;
            width: auto;
            filter: brightness(0) invert(1);
        }

        .login-title {
            font-family: 'Poppins', sans-serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: -0.02em;
            margin-bottom: 6px;
        }

        .login-subtitle {
            font-size: 0.875rem;
            color: rgba(255, 255, 255, 0.6);
            font-weight: 400;
        }

        /* ── Error Message ────────────────────────────── */
        .login-error {
            background: rgba(220, 38, 38, 0.12);
            border: 1px solid rgba(220, 38, 38, 0.25);
            color: #FCA5A5;
            border-radius: 12px;
            padding: 12px 14px;
            font-size: 0.85rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shake 0.4s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            20% { transform: translateX(-6px); }
            40% { transform: translateX(6px); }
            60% { transform: translateX(-4px); }
            80% { transform: translateX(4px); }
        }

        /* ── Form ─────────────────────────────────────── */
        .login-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .input-group {
            position: relative;
        }

        .input-group label {
            display: block;
            font-size: 0.8rem;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            transition: color 0.2s;
        }

        .input-group:focus-within label {
            color: var(--primary-light);
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            color: rgba(255, 255, 255, 0.35);
            transition: color 0.2s;
            pointer-events: none;
            display: flex;
        }

        .input-group:focus-within .input-icon {
            color: var(--primary-light);
        }

        .input-group input {
            width: 100%;
            padding: 14px 14px 14px 44px;
            background: rgba(255, 255, 255, 0.07);
            border: 1.5px solid rgba(255, 255, 255, 0.12);
            border-radius: 14px;
            color: #ffffff;
            font-size: 0.95rem;
            font-family: 'Inter', sans-serif;
            outline: none;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .input-group input::placeholder {
            color: rgba(255, 255, 255, 0.3);
        }

        .input-group input:focus {
            border-color: var(--primary-light);
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 0 3px rgba(34, 211, 238, 0.15);
        }

        .toggle-pass {
            position: absolute;
            right: 12px;
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.35);
            cursor: pointer;
            padding: 4px;
            display: flex;
            transition: color 0.2s;
        }

        .toggle-pass:hover {
            color: rgba(255, 255, 255, 0.7);
        }

        /* ── Submit Button ────────────────────────────── */
        .btn-login {
            position: relative;
            width: 100%;
            padding: 15px;
            margin-top: 8px;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            color: #ffffff;
            font-family: 'Inter', sans-serif;
            font-size: 0.95rem;
            font-weight: 600;
            border: none;
            border-radius: 14px;
            cursor: pointer;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            opacity: 0;
            transition: opacity 0.3s;
        }

        .btn-login:hover::before {
            opacity: 1;
        }

        .btn-login:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 25px rgba(8, 145, 178, 0.35);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .btn-login span,
        .btn-login svg {
            position: relative;
            z-index: 1;
        }

        .btn-login.loading span { display: none; }
        .btn-login.loading svg { display: none; }
        .btn-login.loading::after {
            content: '';
            width: 22px; height: 22px;
            border: 2.5px solid rgba(255,255,255,0.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin 0.7s linear infinite;
            position: relative;
            z-index: 1;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* ── Footer ───────────────────────────────────── */
        .login-footer {
            text-align: center;
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
        }

        .login-footer a {
            color: rgba(255, 255, 255, 0.5);
            text-decoration: none;
            font-size: 0.82rem;
            transition: color 0.2s;
        }

        .login-footer a:hover {
            color: var(--primary-light);
        }

        /* ── Responsive ───────────────────────────────── */
        @media (max-width: 480px) {
            .login-card {
                padding: 36px 24px 28px;
                border-radius: 20px;
            }
            .login-title { font-size: 1.3rem; }
            .orb-1 { width: 250px; height: 250px; }
            .orb-2 { width: 200px; height: 200px; }
            .orb-3 { width: 150px; height: 150px; }
        }

        /* ── Reduced Motion ───────────────────────────── */
        @media (prefers-reduced-motion: reduce) {
            .orb { animation: none; }
            .login-card { animation: none; }
            .login-logo-wrap { animation: none; }
            .login-error { animation: none; }
            .btn-login { transition: none; }
            .input-group input { transition: none; }
        }
    </style>
</head>
<body>

    <!-- Animated Background -->
    <div class="bg-orbs" aria-hidden="true">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>

    <div class="login-wrapper">
        <div class="login-card">

            <!-- Header -->
            <div class="login-header">
                <div class="login-logo-wrap">
                    <img src="https://oti.unap.edu.pe/recursos/oti-ofic.png" alt="OTI UNA">
                </div>
                <h1 class="login-title">Panel de Administracion</h1>
                <p class="login-subtitle">Oficina de Tecnologias de la Informacion</p>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="login-error" role="alert">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form method="POST" action="${pageContext.request.contextPath}/adm/login" class="login-form" id="loginForm">

                <div class="input-group">
                    <label for="username">Usuario</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                        </span>
                        <input type="text" id="username" name="username"
                               placeholder="Ingresa tu usuario" required autofocus
                               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
                    </div>
                </div>

                <div class="input-group">
                    <label for="password">Contrasena</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
                        </span>
                        <input type="password" id="password" name="password"
                               placeholder="Ingresa tu contrasena" required>
                        <button type="button" class="toggle-pass" onclick="togglePassword()" aria-label="Mostrar contrasena">
                            <svg id="eyeOpen" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                            <svg id="eyeClosed" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display:none"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line></svg>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-login" id="btnLogin">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path><polyline points="10 17 15 12 10 7"></polyline><line x1="15" y1="12" x2="3" y2="12"></line></svg>
                    <span>Iniciar Sesion</span>
                </button>

            </form>

            <div class="login-footer">
                <a href="${pageContext.request.contextPath}/">Volver al sitio web</a>
            </div>

        </div>
    </div>

    <script>
        function togglePassword() {
            var pwd = document.getElementById('password');
            var eyeO = document.getElementById('eyeOpen');
            var eyeC = document.getElementById('eyeClosed');
            if (pwd.type === 'password') {
                pwd.type = 'text';
                eyeO.style.display = 'none';
                eyeC.style.display = 'block';
            } else {
                pwd.type = 'password';
                eyeO.style.display = 'block';
                eyeC.style.display = 'none';
            }
        }

        document.getElementById('loginForm').addEventListener('submit', function() {
            var btn = document.getElementById('btnLogin');
            btn.classList.add('loading');
            btn.disabled = true;
        });
    </script>

</body>
</html>
