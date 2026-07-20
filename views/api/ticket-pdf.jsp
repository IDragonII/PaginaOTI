<%@ page import="com.github.librepdf.openpdf.*" %>
<%@ page import="com.lowagie.text.*" %>
<%@ page import="com.lowagie.text.pdf.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.awt.Color" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "inline; filename=FUT_Solicitud.pdf");

    String codigo = request.getParameter("codigo") != null ? request.getParameter("codigo") : "";
    String nombre = request.getParameter("nombre") != null ? request.getParameter("nombre") : "";
    String dni = request.getParameter("dni") != null ? request.getParameter("dni") : "";
    String tipo = request.getParameter("tipo") != null ? request.getParameter("tipo") : "";
    String msg = request.getParameter("msg") != null ? request.getParameter("msg") : "";
    String vinculo = request.getParameter("vinculo") != null ? request.getParameter("vinculo") : "";
    String correo = request.getParameter("correo") != null ? request.getParameter("correo") : "";
    String telefono = request.getParameter("telefono") != null ? request.getParameter("telefono") : "";
    String direccion = request.getParameter("direccion") != null ? request.getParameter("direccion") : "";
    String fecha = request.getParameter("fecha") != null ? request.getParameter("fecha") : "";

    if (fecha.isEmpty()) {
        fecha = new SimpleDateFormat("dd 'de' MMMM 'del' yyyy").format(new Date());
    }

    Document document = new Document(PageSize.A4, 40, 40, 40, 40);
    PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    Color cAzul = new Color(0, 70, 127);
    Color cAzulClaro = new Color(220, 235, 250);
    Color cGris = new Color(200, 200, 200);
    Color cNegro = Color.BLACK;

    Font fontTitle = FontFactory.getFont(FontFactory.HELVETICA, 11, Font.BOLD, cAzul);
    Font fontSection = FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD, cAzul);
    Font fontNormal = FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL, cNegro);
    Font fontSmall = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.NORMAL, new Color(100, 100, 100));
    Font fontCheck = FontFactory.getFont(FontFactory.HELVETICA, 9, Font.NORMAL, cNegro);
    Font fontLabel = FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD, cNegro);

    float[] headerWidths = {3.5f * 72f, 8.5f * 72f, 3.5f * 72f};
    PdfPTable headerTable = new PdfPTable(headerWidths);
    headerTable.setWidthPercentage(100);
    headerTable.getDefaultCell().setBorder(Rectangle.BOX);
    headerTable.getDefaultCell().setBorderColor(cAzul);
    headerTable.getDefaultCell().setBorderWidth(1f);

    PdfPCell cellLogo = new PdfPCell();
    cellLogo.setBorder(Rectangle.BOX);
    cellLogo.setBorderColor(cAzul);
    cellLogo.setBorderWidth(1f);
    cellLogo.setHorizontalAlignment(Element.ALIGN_CENTER);
    cellLogo.setVerticalAlignment(Element.ALIGN_MIDDLE);
    try {
        String realPath = application.getRealPath("/");
        Image logoUnap = Image.getInstance(realPath + "/assets/img/unap.png");
        logoUnap.scaleToFit(60, 60);
        cellLogo.addElement(logoUnap);
    } catch (Exception e) {
        cellLogo.addElement(new Paragraph("UNAP", fontTitle));
    }
    headerTable.addCell(cellLogo);

    PdfPCell cellTitle = new PdfPCell();
    cellTitle.setBorder(Rectangle.BOX);
    cellTitle.setBorderColor(cAzul);
    cellTitle.setBorderWidth(1f);
    cellTitle.setHorizontalAlignment(Element.ALIGN_CENTER);
    cellTitle.setVerticalAlignment(Element.ALIGN_MIDDLE);
    cellTitle.addElement(new Paragraph("FORMATO", fontTitle));
    cellTitle.addElement(new Paragraph("SOLICITUDES", fontTitle));
    headerTable.addCell(cellTitle);

    PdfPCell cellOti = new PdfPCell();
    cellOti.setBorder(Rectangle.BOX);
    cellOti.setBorderColor(cAzul);
    cellOti.setBorderWidth(1f);
    cellOti.setHorizontalAlignment(Element.ALIGN_CENTER);
    cellOti.setVerticalAlignment(Element.ALIGN_MIDDLE);
    try {
        String realPath = application.getRealPath("/");
        Image logoOti = Image.getInstance(realPath + "/assets/img/oti_logo.png");
        logoOti.scaleToFit(50, 50);
        cellOti.addElement(logoOti);
    } catch (Exception e) {
        cellOti.addElement(new Paragraph("OTI", fontTitle));
    }
    headerTable.addCell(cellOti);

    document.add(headerTable);
    document.add(new Paragraph(" ", fontNormal));

    document.add(new Paragraph("FORMULARIO ÚNICO DE TRÁMITE (FUT)", fontSection));
    document.add(new Paragraph(" ", fontNormal));
    document.add(new Paragraph("Señor:", fontNormal));
    document.add(new Paragraph(" ", fontNormal));
    Paragraph jefe = new Paragraph();
    jefe.add(new Phrase("Jefe de la Oficina de Tecnologías de la Información", FontFactory.getFont(FontFactory.HELVETICA, 9, Font.BOLD, cNegro)));
    document.add(jefe);
    document.add(new Paragraph("Ing. Edison Jossep Ramos Muñoz", fontNormal));
    document.add(new Paragraph(" ", fontNormal));

    PdfPTable section1 = new PdfPTable(1);
    section1.setWidthPercentage(100);
    PdfPCell s1Header = new PdfPCell(new Phrase("1. SOLICITO:", fontSection));
    s1Header.setBackgroundColor(cAzulClaro);
    s1Header.setBorder(Rectangle.BOX);
    s1Header.setBorderColor(cAzul);
    s1Header.setBorderWidth(1f);
    s1Header.setPadding(6);
    section1.addCell(s1Header);

    PdfPCell s1Content = new PdfPCell();
    s1Content.setBorder(Rectangle.BOX);
    s1Content.setBorderColor(cAzul);
    s1Content.setBorderWidth(1f);
    s1Content.setPadding(8);
    s1Content.setFixedHeight(55);
    s1Content.addElement(new Paragraph(msg.isEmpty() ? " " : msg, fontNormal));
    section1.addCell(s1Content);
    document.add(section1);
    document.add(new Paragraph(" ", fontNormal));

    PdfPTable section2 = new PdfPTable(1);
    section2.setWidthPercentage(100);
    PdfPCell s2Header = new PdfPCell(new Phrase("2. DATOS DEL SOLICITANTE:", fontSection));
    s2Header.setBackgroundColor(cAzulClaro);
    s2Header.setBorder(Rectangle.BOX);
    s2Header.setBorderColor(cAzul);
    s2Header.setBorderWidth(1f);
    s2Header.setPadding(6);
    section2.addCell(s2Header);
    document.add(section2);

    float[] dataWidths = {5.5f * 72f, 10f * 72f};
    PdfPTable dataTable = new PdfPTable(dataWidths);
    dataTable.setWidthPercentage(100);

    String[] labels = {"APELLIDOS Y NOMBRES:", "DNI / CI / N° de Identificación:", "DOMICILIO:", "CELULAR:", "CORREO PERSONAL ALTERNATIVO:"};
    String[] values = {nombre, dni, direccion, telefono, correo};

    for (int i = 0; i < labels.length; i++) {
        PdfPCell labelCell = new PdfPCell(new Phrase(labels[i], fontLabel));
        labelCell.setBorder(Rectangle.BOX);
        labelCell.setBorderColor(cAzul);
        labelCell.setBorderWidth(1f);
        labelCell.setPadding(5);
        dataTable.addCell(labelCell);

        PdfPCell valueCell = new PdfPCell(new Phrase(values[i], fontNormal));
        valueCell.setBorder(Rectangle.BOX);
        valueCell.setBorderColor(cAzul);
        valueCell.setBorderWidth(1f);
        valueCell.setPadding(5);
        dataTable.addCell(valueCell);
    }
    document.add(dataTable);
    document.add(new Paragraph(" ", fontNormal));

    PdfPTable section3 = new PdfPTable(1);
    section3.setWidthPercentage(100);
    PdfPCell s3Header = new PdfPCell(new Phrase("3. TIPO DE VÍNCULO CON LA INSTITUCIÓN    Marcar con una (X) el CARGO / FUNCIÓN:", fontSection));
    s3Header.setBackgroundColor(cAzulClaro);
    s3Header.setBorder(Rectangle.BOX);
    s3Header.setBorderColor(cAzul);
    s3Header.setBorderWidth(1f);
    s3Header.setPadding(6);
    section3.addCell(s3Header);
    document.add(section3);

    String[] vinculos = {"DOCENTE NOMBRADO", "DOCENTE CONTRATADO", "ESTUDIANTE",
                         "ADMINISTRATIVO NOMBRADO", "ADMINISTRATIVO CONTRATADO", "OTROS:",
                         "ADMINISTRATIVO CAS", "LOCACIÓN DE SERVICIOS"};
    float[] vincWidths = {0.5f * 72f, 4.2f * 72f, 0.5f * 72f, 4.5f * 72f, 0.5f * 72f, 4.8f * 72f};
    PdfPTable vincTable = new PdfPTable(vincWidths);
    vincTable.setWidthPercentage(100);

    for (int i = 0; i < vinculos.length; i += 3) {
        for (int j = 0; j < 3; j++) {
            int idx = i + j;
            String check = "";
            if (idx < vinculos.length && vinculo.equalsIgnoreCase(vinculos[idx])) {
                check = "X";
            }
            PdfPCell checkCell = new PdfPCell(new Phrase("(" + check + ") ", fontCheck));
            checkCell.setBorder(Rectangle.BOX);
            checkCell.setBorderColor(cAzul);
            checkCell.setBorderWidth(1f);
            checkCell.setPadding(4);
            vincTable.addCell(checkCell);

            String text = idx < vinculos.length ? vinculos[idx] : " ";
            PdfPCell textCell = new PdfPCell(new Phrase(text, fontNormal));
            textCell.setBorder(Rectangle.BOX);
            textCell.setBorderColor(cAzul);
            textCell.setBorderWidth(1f);
            textCell.setPadding(4);
            vincTable.addCell(textCell);
        }
    }
    document.add(vincTable);
    document.add(new Paragraph(" ", fontNormal));

    PdfPTable section4 = new PdfPTable(1);
    section4.setWidthPercentage(100);
    PdfPCell s4Header = new PdfPCell(new Phrase("4. DETALLES DE LA SOLICITUD:", fontSection));
    s4Header.setBackgroundColor(cAzulClaro);
    s4Header.setBorder(Rectangle.BOX);
    s4Header.setBorderColor(cAzul);
    s4Header.setBorderWidth(1f);
    s4Header.setPadding(6);
    section4.addCell(s4Header);
    document.add(section4);

    String[] detalles = {"CREACIÓN DE CORREO INSTITUCIONAL", "RESTABLECIMIENTO DE CONTRASEÑA",
                         "ACTIVACIÓN DE CORREO INSTITUCIONAL", "CREACIÓN DE AULA VIRTUAL",
                         "FIRMA DIGITAL", "DOMINIO INSTITUCIONAL"};
    float[] detWidths = {0.7f * 72f, 14.8f * 72f};
    PdfPTable detTable = new PdfPTable(detWidths);
    detTable.setWidthPercentage(100);

    for (String det : detalles) {
        String check = "";
        if (tipo.toUpperCase().contains(det.substring(0, Math.min(10, det.length())).toUpperCase())) {
            check = "X";
        }
        PdfPCell checkCell = new PdfPCell(new Phrase("(" + check + ") ", fontCheck));
        checkCell.setBorder(Rectangle.BOX);
        checkCell.setBorderColor(cAzul);
        checkCell.setBorderWidth(1f);
        checkCell.setPadding(4);
        detTable.addCell(checkCell);

        PdfPCell textCell = new PdfPCell(new Phrase(det, fontNormal));
        textCell.setBorder(Rectangle.BOX);
        textCell.setBorderColor(cAzul);
        textCell.setBorderWidth(1f);
        textCell.setPadding(4);
        detTable.addCell(textCell);
    }
    document.add(detTable);
    document.add(new Paragraph(" ", fontNormal));

    PdfPTable section5 = new PdfPTable(1);
    section5.setWidthPercentage(100);
    PdfPCell s5Header = new PdfPCell(new Phrase("5. ADJUNTO:", fontSection));
    s5Header.setBackgroundColor(cAzulClaro);
    s5Header.setBorder(Rectangle.BOX);
    s5Header.setBorderColor(cAzul);
    s5Header.setBorderWidth(1f);
    s5Header.setPadding(6);
    section5.addCell(s5Header);

    PdfPCell s5Content = new PdfPCell();
    s5Content.setBorder(Rectangle.BOX);
    s5Content.setBorderColor(cAzul);
    s5Content.setBorderWidth(1f);
    s5Content.setPadding(8);
    s5Content.setFixedHeight(60);
    Paragraph notePara = new Paragraph();
    notePara.add(new Phrase("Nota: Adjuntar obligatoriamente para creaciones de correo y aula virtual:", FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD, cNegro)));
    notePara.add(new Phrase("\n     — COPIA DE DNI", fontSmall));
    notePara.add(new Phrase("\n     — COPIA DE RESOLUCIÓN RECTORAL O DECANAL", fontSmall));
    s5Content.addElement(notePara);
    section5.addCell(s5Content);
    document.add(section5);
    document.add(new Paragraph(" ", fontNormal));
    document.add(new Paragraph(" ", fontNormal));

    Paragraph fechaPara = new Paragraph();
    fechaPara.add(new Phrase("Puno, " + fecha + ".", fontNormal));
    document.add(fechaPara);
    document.add(new Paragraph(" ", fontNormal));
    document.add(new Paragraph(" ", fontNormal));

    float[] sigWidths = {10f * 72f, 5.5f * 72f};
    PdfPTable sigTable = new PdfPTable(sigWidths);
    sigTable.setWidthPercentage(100);
    sigTable.getDefaultCell().setBorder(Rectangle.NO_BORDER);

    PdfPCell emptySig = new PdfPCell(new Phrase(" ", fontNormal));
    emptySig.setBorder(Rectangle.NO_BORDER);
    sigTable.addCell(emptySig);

    PdfPCell firmaCell = new PdfPCell();
    firmaCell.setBorder(Rectangle.NO_BORDER);
    firmaCell.setHorizontalAlignment(Element.ALIGN_CENTER);
    Paragraph firmaPara = new Paragraph();
    firmaPara.setAlignment(Element.ALIGN_CENTER);
    Chunk line = new Chunk("                                          ");
    line.setUnderline(0.5f, -2f);
    firmaPara.add(line);
    firmaPara.add(new Phrase("\n", fontNormal));
    firmaPara.add(new Phrase("FIRMA", FontFactory.getFont(FontFactory.HELVETICA, 8, Font.BOLD, cNegro)));
    firmaCell.addElement(firmaPara);
    sigTable.addCell(firmaCell);

    document.add(sigTable);

    document.close();
%>