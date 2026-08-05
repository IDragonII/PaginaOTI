<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*, java.io.*, java.nio.file.*, java.util.Base64" %>
<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String apiKey = application.getInitParameter("OTI_API_KEY");
    String apiBase = application.getInitParameter("OTI_API_BASE");

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(405);
        out.print("{\"error\": \"Metodo no permitido\"}");
        return;
    }

    String sid = null;
    String codigoTicket = null;

    try {
        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            String name = part.getName();
            if ("sid".equals(name)) {
                sid = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("codigo_ticket".equals(name)) {
                codigoTicket = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            }
        }
    } catch (Exception e) {
        response.setStatus(400);
        out.print("{\"error\": \"Error leyendo multipart: " + e.getMessage().replace("\"", "'") + "\"}");
        return;
    }

    if (sid == null || sid.isEmpty() || !sid.matches("[a-f0-9]{12}")) {
        response.setStatus(400);
        out.print("{\"error\": \"sid invalido\"}");
        return;
    }
    if (codigoTicket == null || codigoTicket.isEmpty()) {
        response.setStatus(400);
        out.print("{\"error\": \"codigo_ticket requerido\"}");
        return;
    }

    String uploadDir = System.getProperty("java.io.tmpdir") + File.separator + "firmauna";
    String signedPath = uploadDir + File.separator + sid + "_signed.pdf";

    File signedFile = new File(signedPath);
    if (!signedFile.exists()) {
        response.setStatus(404);
        out.print("{\"error\": \"PDF firmado no encontrado. Asegurese de haber firmado el documento.\"}");
        return;
    }

    try {
        byte[] pdfBytes = Files.readAllBytes(signedFile.toPath());
        String pdfBase64 = Base64.getEncoder().encodeToString(pdfBytes);

        String boundary = "----WebKitFormBoundary" + System.currentTimeMillis();
        StringBuilder body = new StringBuilder();

        body.append("--").append(boundary).append("\r\n");
        body.append("Content-Disposition: form-data; name=\"pdf_firmado\"\r\n\r\n");
        body.append(pdfBase64).append("\r\n");

        body.append("--").append(boundary).append("--\r\n");

        byte[] bodyBytes = body.toString().getBytes("UTF-8");

        URL url = new URL(apiBase + "/api/ext/tickets/" + codigoTicket + "/firma");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
        conn.setRequestProperty("Content-Length", String.valueOf(bodyBytes.length));
        conn.setDoOutput(true);
        conn.setConnectTimeout(15000);
        conn.setReadTimeout(15000);

        OutputStream os = conn.getOutputStream();
        os.write(bodyBytes);
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
        conn.disconnect();

        out.print(sb.toString());

        signedFile.delete();
        new File(uploadDir + File.separator + sid + ".pdf").delete();
        new File(uploadDir + File.separator + sid + ".status").delete();
        new File(uploadDir + File.separator + sid + ".codigo").delete();

    } catch (Exception e) {
        response.setStatus(502);
        out.print("{\"error\": \"Error enviando a Fotocheck API: " + e.getMessage().replace("\"", "'") + "\"}");
    }
%>