<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setAttribute("ChildLayer", "layDocumentacion");
    request.setAttribute("IsLayerFile", true);
    request.getRequestDispatcher("/views/web.jsp").forward(request, response);
%>
