<%@ page contentType="application/pdf" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.nio.file.*" %>
<%
    String sid = request.getParameter("sid");

    if (sid == null || sid.isEmpty() || !sid.matches("[a-f0-9]{12}")) {
        response.setStatus(400);
        return;
    }

    String uploadDir = System.getProperty("java.io.tmpdir") + File.separator + "firmauna";
    String pdfPath = uploadDir + File.separator + sid + ".pdf";
    String signedPath = uploadDir + File.separator + sid + "_signed.pdf";
    String statusPath = uploadDir + File.separator + sid + ".status";

    File signedFile = new File(signedPath);
    File pdfFile = new File(pdfPath);
    String status = "PENDING";
    try { status = Files.readString(Path.of(statusPath)).trim(); } catch (Exception e) {}

    File targetFile;
    if ("COMPLETE".equals(status) && signedFile.exists()) {
        targetFile = signedFile;
    } else if (pdfFile.exists()) {
        targetFile = pdfFile;
    } else {
        response.setStatus(404);
        return;
    }

    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "inline; filename=\"FUT.pdf\"");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setContentLengthLong(targetFile.length());

    try (InputStream is = new FileInputStream(targetFile);
         OutputStream os = response.getOutputStream()) {
        byte[] buffer = new byte[8192];
        int bytesRead;
        while ((bytesRead = is.read(buffer)) != -1) {
            os.write(buffer, 0, bytesRead);
        }
        os.flush();
    }
%>