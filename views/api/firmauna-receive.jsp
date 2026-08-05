<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.nio.file.*, jakarta.servlet.http.Part" %>
<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.setStatus(405);
        out.print("{\"error\": \"Metodo no permitido\"}");
        return;
    }

    String sid = request.getParameter("sid");
    if (sid == null || sid.isEmpty() || !sid.matches("[a-f0-9]{12}")) {
        response.setStatus(400);
        out.print("{\"error\": \"sid invalido\"}");
        return;
    }

    String uploadDir = System.getProperty("java.io.tmpdir") + File.separator + "firmauna";

    try {
        String signedPath = uploadDir + File.separator + sid + "_signed.pdf";
        String statusPath = uploadDir + File.separator + sid + ".status";

        for (Part part : request.getParts()) {
            if ("signed_pdf".equals(part.getName()) || part.getSubmittedFileName() != null) {
                byte[] data = part.getInputStream().readAllBytes();
                Files.write(Path.of(signedPath), data);
                Files.writeString(Path.of(statusPath), "COMPLETE");

                out.print("{\"success\":true,\"message\":\"PDF firmado recibido\",\"bytes\":" + data.length + "}");
                return;
            }
        }

        byte[] allBytes = request.getInputStream().readAllBytes();
        if (allBytes.length > 0) {
            Files.write(Path.of(signedPath), allBytes);
            Files.writeString(Path.of(statusPath), "COMPLETE");
            out.print("{\"success\":true,\"message\":\"PDF firmado recibido\",\"bytes\":" + allBytes.length + "}");
        } else {
            response.setStatus(400);
            out.print("{\"error\": \"No se recibio el PDF firmado\"}");
        }
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"error\": \"Error guardando PDF firmado: " + e.getMessage().replace("\"", "'") + "\"}");
    }
%>