<jsp:include page="MensajeEliminar.html" />

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-3.1.0/jquery-3.1.0.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        
</head>
	<body>    		
		<a class="btn btn-default" href="Agregar.html">
	        Agregar
	    </a>
		
		<div class="container">
			<table class="table table-bordered">
			<thead>
				<tr>
					<th>Codigo</th>
					<th>Nombre</th>
					<th>Apellido Paterno</th>
					<th>Apellido Materno</th>
					<th>Fecha Registro</th>
					<th>Observacion</th>
					<th>Accion</th>
				</tr>
			</thead>
			<tbody>				
				<c:forEach var="p" items="${alumnos}">
					<tr>
						<td>${p.codigo}</td>
						<td>${p.nombre}</td>
						<td>${p.apellidopaterno}</td>
						<td>${p.apellidomaterno}</td>
						<td>${p.fecharegistro}</td>
						<td>${p.observacion}</td>
						<td>
							<a class="btn btn-default" href="EditarServlet?codigo=${p.codigo}">
						        Editar
						    </a>
						    							
							<a class="btn btn-default" data-href="EliminarServlet?codigo=${p.codigo}" data-toggle="modal" data-target="#confirm-delete">
						        Eliminar
						    </a>						    						
									    
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</body>
	
	<script>
        $('#confirm-delete').on('show.bs.modal', function(e) {
            $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));                       
        });
    </script>
    
</html>
