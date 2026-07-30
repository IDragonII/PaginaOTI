FROM tomcat:10-jdk17

COPY WEB-INF /usr/local/tomcat/webapps/ROOT/WEB-INF
COPY META-INF /usr/local/tomcat/webapps/ROOT/META-INF
COPY views /usr/local/tomcat/webapps/ROOT/views
COPY assets /usr/local/tomcat/webapps/ROOT/assets
COPY index.jsp /usr/local/tomcat/webapps/ROOT/
COPY solicitud.jsp /usr/local/tomcat/webapps/ROOT/
COPY documentacion.jsp /usr/local/tomcat/webapps/ROOT/
COPY unidades.jsp /usr/local/tomcat/webapps/ROOT/
COPY servicios.jsp /usr/local/tomcat/webapps/ROOT/
COPY firmaUNA.jsp /usr/local/tomcat/webapps/ROOT/
COPY historia-oti.jsp /usr/local/tomcat/webapps/ROOT/

# Compilar Java (models, controllers, base) usando servlet-api de Tomcat
RUN cd /usr/local/tomcat/webapps/ROOT && \
    javac -cp "/usr/local/tomcat/lib/servlet-api.jar:WEB-INF/lib/*:WEB-INF/classes" \
    -d WEB-INF/classes \
    WEB-INF/classes/jxmvc/utils/FileStorage.java \
    WEB-INF/classes/jxmvc/base/AdminDB.java \
    WEB-INF/classes/jxmvc/models/Actividad.java \
    WEB-INF/classes/jxmvc/models/PlanaDirectiva.java \
    WEB-INF/classes/jxmvc/models/Configuracion.java \
    WEB-INF/classes/jxmvc/models/AdminUser.java \
    WEB-INF/classes/jxmvc/models/Servicio.java \
    WEB-INF/classes/jxmvc/models/Unidad.java \
    WEB-INF/classes/jxmvc/models/Enlace.java \
    WEB-INF/classes/jxmvc/models/Documento.java \
    WEB-INF/classes/jxmvc/controllers/AdminController.java \
    WEB-INF/classes/jxmvc/controllers/AppspecificController.java

EXPOSE 8080
CMD ["catalina.sh", "run"]
