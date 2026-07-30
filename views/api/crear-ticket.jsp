<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*, java.io.*, java.util.*, jakarta.servlet.http.Part" %>
<%
    String apiKey = application.getInitParameter("OTI_API_KEY");
    String apiBase = application.getInitParameter("OTI_API_BASE");

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(405);
        out.print("{\"error\": \"Metodo no permitido\"}");
        return;
    }

    String dni = null;
    String tipoSolicitudId = null;
    String vinculo = null;
    String observaciones = null;
    String motivoSolicitud = null;
    String tipoCuenta = null;
    String sistemaEspecifico = null;
    String correoPersonal = null;
    String telefono = null;
    String oficinaSoporte = null;
    String dificultad = null;
    String adjuntosUrl = null;
    List<Part> adjuntos = new ArrayList<>();

    try {
        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            String name = part.getName();
            if ("dni".equals(name)) {
                dni = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("tipo_solicitud_id".equals(name)) {
                tipoSolicitudId = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("vinculo".equals(name)) {
                vinculo = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("observaciones".equals(name)) {
                observaciones = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("motivo_solicitud".equals(name)) {
                motivoSolicitud = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("tipo_cuenta".equals(name)) {
                tipoCuenta = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("sistema_especifico".equals(name)) {
                sistemaEspecifico = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("correo_personal".equals(name)) {
                correoPersonal = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("telefono".equals(name)) {
                telefono = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("oficina_sopporte".equals(name)) {
                oficinaSoporte = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("dificultad".equals(name)) {
                dificultad = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("adjuntos_url".equals(name)) {
                adjuntosUrl = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("adjuntos[]".equals(name) && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                adjuntos.add(part);
            }
        }
    } catch (Exception e) {
        response.setStatus(400);
        out.print("{\"error\": \"No se pudo leer el multipart del request: " + e.getMessage().replace("\"", "'") + "\"}");
        return;
    }

    // DNI es requerido solo para tipos que no sean SOPORTE TECNICO
    boolean isSoporte = (oficinaSoporte != null && !oficinaSoporte.isEmpty());
    if (!isSoporte && (dni == null || dni.isEmpty())) {
        response.setStatus(400);
        out.print("{\"error\": \"El campo dni es requerido\"}");
        return;
    }
    if (tipoSolicitudId == null || tipoSolicitudId.isEmpty()) {
        response.setStatus(400);
        out.print("{\"error\": \"El campo tipo_solicitud_id es requerido\"}");
        return;
    }

    String boundary = "----WebKitFormBoundary" + System.currentTimeMillis();

    StringBuilder headerBuilder = new StringBuilder();
    headerBuilder.append("--").append(boundary).append("\r\n");
    headerBuilder.append("Content-Disposition: form-data; name=\"dni\"\r\n\r\n");
    headerBuilder.append(dni).append("\r\n");

    headerBuilder.append("--").append(boundary).append("\r\n");
    headerBuilder.append("Content-Disposition: form-data; name=\"tipo_solicitud_id\"\r\n\r\n");
    headerBuilder.append(tipoSolicitudId).append("\r\n");

    if (vinculo != null && !vinculo.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"vinculo\"\r\n\r\n");
        headerBuilder.append(vinculo).append("\r\n");
    }

    if (observaciones != null && !observaciones.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"observaciones\"\r\n\r\n");
        headerBuilder.append(observaciones).append("\r\n");
    }

    if (motivoSolicitud != null && !motivoSolicitud.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"motivo_solicitud\"\r\n\r\n");
        headerBuilder.append(motivoSolicitud).append("\r\n");
    }

    if (tipoCuenta != null && !tipoCuenta.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"tipo_cuenta\"\r\n\r\n");
        headerBuilder.append(tipoCuenta).append("\r\n");
    }

    if (sistemaEspecifico != null && !sistemaEspecifico.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"sistema_especifico\"\r\n\r\n");
        headerBuilder.append(sistemaEspecifico).append("\r\n");
    }

    if (correoPersonal != null && !correoPersonal.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"correo_personal\"\r\n\r\n");
        headerBuilder.append(correoPersonal).append("\r\n");
    }

    if (telefono != null && !telefono.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"telefono\"\r\n\r\n");
        headerBuilder.append(telefono).append("\r\n");
    }

    if (oficinaSoporte != null && !oficinaSoporte.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"oficina_sopporte\"\r\n\r\n");
        headerBuilder.append(oficinaSoporte).append("\r\n");
    }

    if (dificultad != null && !dificultad.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"dificultad\"\r\n\r\n");
        headerBuilder.append(dificultad).append("\r\n");
    }

    if (adjuntosUrl != null && !adjuntosUrl.isEmpty()) {
        headerBuilder.append("--").append(boundary).append("\r\n");
        headerBuilder.append("Content-Disposition: form-data; name=\"adjuntos_url\"\r\n\r\n");
        headerBuilder.append(adjuntosUrl).append("\r\n");
    }

    byte[] headerBytes = headerBuilder.toString().getBytes("UTF-8");
    byte[] footerBytes = ("\r\n--" + boundary + "--\r\n").getBytes("UTF-8");

    List<byte[]> fileParts = new ArrayList<>();
    long filePartsTotalLen = 0;
    for (Part filePart : adjuntos) {
        StringBuilder fileHeader = new StringBuilder();
        fileHeader.append("--").append(boundary).append("\r\n");
        String fileName = filePart.getSubmittedFileName();
        String contentType = filePart.getContentType() != null ? filePart.getContentType() : "application/octet-stream";
        fileHeader.append("Content-Disposition: form-data; name=\"adjuntos[]\"; filename=\"").append(fileName).append("\"\r\n");
        fileHeader.append("Content-Type: ").append(contentType).append("\r\n\r\n");
        byte[] fileHeaderBytes = fileHeader.toString().getBytes("UTF-8");
        byte[] fileData = filePart.getInputStream().readAllBytes();
        byte[] fileBoundary = new byte[fileHeaderBytes.length + fileData.length];
        System.arraycopy(fileHeaderBytes, 0, fileBoundary, 0, fileHeaderBytes.length);
        System.arraycopy(fileData, 0, fileBoundary, fileHeaderBytes.length, fileData.length);
        fileParts.add(fileBoundary);
        filePartsTotalLen += fileBoundary.length;
    }

    long contentLength = headerBytes.length + filePartsTotalLen + footerBytes.length;

    HttpURLConnection conn = null;
    try {
        URL url = new URL(apiBase + "/api/ext/tickets");
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
        conn.setRequestProperty("Content-Length", String.valueOf(contentLength));
        conn.setDoOutput(true);
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(15000);

        OutputStream os = conn.getOutputStream();
        os.write(headerBytes);
        for (byte[] filePartData : fileParts) {
            os.write(filePartData);
        }
        os.write(footerBytes);
        os.flush();
        os.close();

        int status = conn.getResponseCode();
        response.setStatus(status);

        InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        reader.close();

        out.print(sb.toString());
    } catch (Exception e) {
        response.setStatus(502);
        out.print("{\"error\": \"Error conectando con el servidor: " + e.getMessage().replace("\"", "'") + "\"}");
    } finally {
        if (conn != null) conn.disconnect();
    }
%>