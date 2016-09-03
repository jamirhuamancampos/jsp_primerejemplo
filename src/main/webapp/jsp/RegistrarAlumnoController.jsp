<%@page import="com.pe.colegio.util.Util"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.pe.colegio.model.Direccion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.List"%>
<%@page import="com.pe.colegio.dao.AlumnoDao"%>
<%@page import="com.pe.colegio.model.Alumno"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
		String nombre  = request.getParameter("nombre");
	
		String apellidopaterno  = request.getParameter("apellidopaterno");
		
		String apellidomaterno  = request.getParameter("apellidomaterno");	
		
		String point = request.getParameter("points");
		
		Pattern regex = Pattern.compile("\\{(.*?)\\}");
		Matcher regexMatcher = regex.matcher(point);		
		List<Map<String, String>> matchList = new ArrayList<Map<String, String>>();
				
		while (regexMatcher.find()) {
			String tmp = regexMatcher.group();
			String[] arr = tmp.substring(1, tmp.length() - 1).replaceAll("\"", "").split(",");
			Map<String, String> m = new HashMap<String, String>();
			
			for(int i = 0; i < arr.length; i++){
				String[] x = arr[i].split(":");				
				m.put(x[0], x[1]);
			}	
			
			matchList.add(m);
		}
		
		List<Direccion> direcciones = new ArrayList<Direccion>();
		
		for (Map<String, String> temp : matchList)
		{		
			String nombre_ = (String)Util.getValueFromKey(temp, "nombre");			
			String direccion_ = (String)Util.getValueFromKey(temp, "direccion");
			float latitud_ = Float.parseFloat((String)Util.getValueFromKey(temp, "latitud"));
			float longitud_ = Float.parseFloat((String)Util.getValueFromKey(temp, "longitud"));
			String tipo_ = (String)Util.getValueFromKey(temp, "tipo");			
			
			Direccion dir = new Direccion(0,nombre_,direccion_,latitud_,longitud_,tipo_,0);
			direcciones.add(dir);
		}				
		    		
		Date d = new Date(System.currentTimeMillis());			
		java.sql.Date fecharegistro = new java.sql.Date(d.getTime());
		
		String observacion  = request.getParameter("observacion");
		
		Alumno a = new Alumno(0,nombre,apellidopaterno,apellidomaterno,fecharegistro,observacion,direcciones);
		AlumnoDao da = new AlumnoDao();
		da.registrar(a);
		
		response.sendRedirect("/ERPColegio/ListarServlet");
	%>
	
</body>
</html>