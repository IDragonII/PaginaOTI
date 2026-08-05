<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.util.*, java.nio.file.*, java.util.UUID" %>
<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(405);
        out.print("{\"error\": \"Metodo no permitido\"}");
        return;
    }

    String pdfBase64 = null;
    String codigoTicket = null;

    try {
        Collection<Part> parts = request.getParts();
        for (Part part : parts) {
            String name = part.getName();
            if ("pdf_base64".equals(name)) {
                pdfBase64 = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            } else if ("codigo_ticket".equals(name)) {
                codigoTicket = new String(part.getInputStream().readAllBytes(), "UTF-8").trim();
            }
        }
    } catch (Exception e) {
        response.setStatus(400);
        out.print("{\"error\": \"Error leyendo multipart: " + e.getMessage().replace("\"", "'") + "\"}");
        return;
    }

    if (pdfBase64 == null || pdfBase64.isEmpty()) {
        response.setStatus(400);
        out.print("{\"error\": \"El campo pdf_base64 es requerido\"}");
        return;
    }
    if (codigoTicket == null || codigoTicket.isEmpty()) {
        response.setStatus(400);
        out.print("{\"error\": \"El campo codigo_ticket es requerido\"}");
        return;
    }

    try {
        String sessionId = UUID.randomUUID().toString().replace("-", "").substring(0, 12);

        String uploadDir = System.getProperty("java.io.tmpdir") + File.separator + "firmauna";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        byte[] pdfBytes = Base64.getDecoder().decode(pdfBase64);
        String pdfPath = uploadDir + File.separator + sessionId + ".pdf";
        String statusPath = uploadDir + File.separator + sessionId + ".status";
        String codigoPath = uploadDir + File.separator + sessionId + ".codigo";

        Files.write(Path.of(pdfPath), pdfBytes);
        Files.writeString(Path.of(statusPath), "PENDING");
        Files.writeString(Path.of(codigoPath), codigoTicket);

        String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();

        response.setStatus(200);
        out.print("{\"success\":true"
                + ",\"session_id\":\"" + sessionId + "\""
                + ",\"host\":\"" + request.getServerName() + "\""
                + ",\"id\":\"" + sessionId + "\""
                + ",\"down\":\"/views/api/firmauna-display.jsp?sid=" + sessionId + "\""
                + ",\"up\":\"/views/api/firmauna-receive.jsp?sid=" + sessionId + "\""
                + ",\"display_url\":\"" + baseUrl + "/views/api/firmauna-display.jsp?sid=" + sessionId + "\""
                + ",\"sentinel_url\":\"" + baseUrl + "/views/api/firmauna-sentinel.jsp?sid=" + sessionId + "\""
                + ",\"receive_url\":\"" + baseUrl + "/views/api/firmauna-receive.jsp?sid=" + sessionId + "\""
                + "}");
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"error\": \"Error guardando PDF: " + e.getMessage().replace("\"", "'") + "\"}");
    }
%>