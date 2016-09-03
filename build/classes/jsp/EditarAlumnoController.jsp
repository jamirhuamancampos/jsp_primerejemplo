<%@page import="java.util.Date"%>
<%@page import="com.pe.colegio.dao.AlumnoDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String codigotmp = request.getParameter("codigo");
int codigo = Integer.parseInt(codigotmp);

String nombre  = request.getParameter("nombre");
String apellidopaterno  = request.getParameter("apellidopaterno");
String apellidomaterno  = request.getParameter("apellidomaterno");			

Date d = new Date(System.currentTimeMillis());			
java.sql.Date fecharegistro = new java.sql.Date(d.getTime());

String observacion  = request.getParameter("observacion");

AlumnoDao da = new AlumnoDao();
da.editar(codigo, nombre, apellidopaterno, apellidomaterno, fecharegistro, observacion);

response.sendRedirect("/ERPColegio/ListarServlet");

%>
</body>
</html>