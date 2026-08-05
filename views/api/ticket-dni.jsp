<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.net.*, java.io.*" %>
<%
    String apiKey = application.getInitParameter("OTI_API_KEY");
    String apiBase = application.getInitParameter("OTI_API_BASE");
    String dni = request.getParameter("dni");

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (dni == null || !dni.matches("^\\d{8}$")) {
        response.setStatus(400);
        out.print("{\"error\": \"DNI debe ser 8 digitos numericos\"}");
        return;
    }

    HttpURLConnection conn = null;
    try {
        URL url = new URL(apiBase + "/api/ext/tickets/dni/" + dni);
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setConnectTimeout(5000);
        conn.setReadTimeout(5000);

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