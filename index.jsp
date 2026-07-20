<%-- 
  Project    : OpenSource JxMVC
  Created on : 12 set. 2024, 8:09:01 a. m.
  Author     : RPLM

  OJO : Este index.jsp inicia solo en Tomcat en Payara salta al Servlet

--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP init for JxMVC</title>
</head>
<body>
    <h4> Hi, JxMVC v0.2.b </h4>

    <%@ page import="jakarta.servlet.*" %>
    <%@ page import="jakarta.servlet.http.*" %>
    <%@ page import="jxmvc.Jx" %>
    <%
        // obj para redirigir al controlador base sin cambiar el URL
        RequestDispatcher dispatcher = request.getRequestDispatcher( Jx.Controller );

        // include o fusion & probaremos luego
        //dispatcher.include(request, response);
        dispatcher.forward(request, response);
        
        // modifica el URL
        //response.sendRedirect( Jx.Controller );
    %>
    
</body>
</html>
