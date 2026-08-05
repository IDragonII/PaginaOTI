<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.nio.file.*" %>
<%
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    String sid = request.getParameter("sid");
    if (sid == null || sid.isEmpty() || !sid.matches("[a-f0-9]{12}")) {
        response.setStatus(400);
        out.print("{\"error\": \"sid invalido\"}");
        return;
    }

    String uploadDir = System.getProperty("java.io.tmpdir") + File.separator + "firmauna";
    String statusPath = uploadDir + File.separator + sid + ".status";
    String signedPath = uploadDir + File.separator + sid + "_signed.pdf";

    String status = "PENDING";
    try { status = Files.readString(Path.of(statusPath)).trim(); } catch (Exception e) {}

    boolean signed = "COMPLETE".equals(status) && new File(signedPath).exists();

    out.print("{\"state\":" + signed + ",\"status\":\"" + status + "\"}");
%>