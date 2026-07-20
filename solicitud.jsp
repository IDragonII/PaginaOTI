<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="jx" uri="http://example.com/jx" %>
<%
    request.setAttribute("ChildLayer", "laySolicitud");
    request.setAttribute("IsLayerFile", true);
    request.getRequestDispatcher("/views/web.jsp").forward(request, response);
%>