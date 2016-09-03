<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="jquery-3.1.0/jquery-3.1.0.js"></script>
<script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="//maps.googleapis.com/maps/api/js?key=AIzaSyAB0V76Pamz3MwGjFAQOnybU_9ufXegihE"></script>	            
   	
<style type="text/css">
    #google_map {width: 80%; height: 500px;margin-right:0px;}
    
    /* Marker Info Window */
	h1.marker-heading{color: #585858;margin: 0px;padding: 0px;font: 18px "Trebuchet MS", Arial;border-bottom: 1px dotted #D8D8D8;}
	div.marker-info-win {min-width: 230px;max-width: 230px;margin-right: -20px;}
	div.marker-info-win p{padding: 0px;margin: 10px 0px 10px 0;}
	div.marker-inner-win{padding: 5px;}
	button.save-marker, button.remove-marker{border: none;background: rgba(0, 0, 0, 0);color: #00F;padding: 0px;text-decoration: underline;margin-right: 10px;cursor: pointer;
	}  
</style>

</head>
<body>
		<h1>
			Editar Alumno 
		</h1>
	
		<div style="width:900px;margin-left:auto;margin-right:auto">
			<c:forEach items="${alumno}" var="p">
				<form action="jsp/EditarAlumnoController.jsp" method="post">
					
					<input type="hidden" value="${p.codigo}" name="codigo" >
															
					 Nombre:<br>
					<input type="text" class="form-control" value="${p.nombre}" name="nombre" style="text-transform:uppercase;" onkeyup="javascript:this.value=this.value.toUpperCase();" ><br>
					
					Apellido Paterno:<br>
					<input type="text" class="form-control" value="${p.apellidopaterno}" name="apellidopaterno" style="text-transform:uppercase;" onkeyup="javascript:this.value=this.value.toUpperCase();"><br>
					
					Apellido Materno:<br>
					<input type="text" class="form-control" value="${p.apellidomaterno}" name="apellidomaterno" style="text-transform:uppercase;" onkeyup="javascript:this.value=this.value.toUpperCase();"><br>
					
					Fecha Registro:<br>
					<input type="text" value="${p.fecharegistro}" name="fecharegistro" style="width:200px"><br>
					
					Observacion:<br>
					<textarea name="observacion" style="width:400px; height:200px">
					${p.observacion}										
					</textarea><br>														
					
					Direccion:<br>
					<div id="google_map"></div>
				
					<script type="text/javascript">
						var points = [];
						
						var mapCenter = new google.maps.LatLng(47.6145, -122.3418); //Google map Coordinates
						
						var googleMapOptions = 
						{ 
						    center: mapCenter, // map center
						    zoom: 17, //zoom level, 0 = earth view to higher value
						    panControl: true, //enable pan Control
						    zoomControl: true, //enable zoom control
						    zoomControlOptions: {
						    style: google.maps.ZoomControlStyle.SMALL //zoom control size
						    },
						    scaleControl: true, // enable scale control
						    mapTypeId: google.maps.MapTypeId.ROADMAP // google map type
						};
					
						var map = new google.maps.Map(document.getElementById("google_map"), googleMapOptions);
						
						var EditForm = '<p><div class="marker-edit">'+
					    '<form action="ajax-save.php" method="POST" name="SaveMarker" id="SaveMarker">'+
					    '<br/><label for="pName"><span>Nombre del lugar :</span><br /><input type="text" name="pName" class="save-name" placeholder="Ingresar nombre" maxlength="40" /></label>'+
					    '<br/><label for="pDesc"><span>Descripcion :</span><br /><textarea name="pDesc" class="save-desc" placeholder="Ingresar direccion" maxlength="150"></textarea></label>'+
					    '<br/><label for="pType"><span>Tipo :</span><br /><select name="pType" class="save-type">' + 
					    '<option value="restaurant">Restaurante</option>'+
					    '<option value="hotel">Hotel</option>'+
					    '<option value="museo">Museo</option>'+
					    '<option value="bar">Bar</option>'+
					    '<option value="casa">Casa</option></select></label>'+
					    '</form>'+
					    '</div></p><button name="save-marker" class="save-marker" onclick="return false;">Guardar marcador</button>';        					    
					    
					    function create_marker(MapPos, MapTitle, MapDesc,  InfoOpenDefault, DragAble, Removable, iconPath)
						{  				
							var marker = new google.maps.Marker({
							    position: MapPos, //map Coordinates where user right clicked
							    map: map,
							    draggable:DragAble, //set marker draggable 
							    animation: google.maps.Animation.DROP, //bounce animation
							    title:"Hello World!",
							    icon:  iconPath //custom pin icon
							});
							
							var contentString = $('<div class="marker-info-win">'+
							'<div class="marker-inner-win"><span class="info-content">'+
							'<h1 class="marker-heading">' + MapTitle + '</h1>'+
							MapDesc+ 
							'</span>'+
							'<br/><button name="remove-marker" class="remove-marker" title="Remove Marker" onclick="return false;" >Eliminar marcador</button></div></div>');
							    			
							//Create an infoWindow
							var infowindow = new google.maps.InfoWindow();
						
							//set the content of infoWindow
							infowindow.setContent(contentString[0]);
							
							//Find remove button in infoWindow
						    var removeBtn   = contentString.find('button.remove-marker')[0];

						   //Find save button in infoWindow
						    var saveBtn     = contentString.find('button.save-marker')[0];
						
						 	//###### remove marker #########/		
							google.maps.event.addDomListener(removeBtn, "click", function(event) {
								 remove_marker(marker);    
							});
						 	
							if(typeof saveBtn !== 'undefined') //continue only when save button is present
							{
								//add click listner to save marker button
								google.maps.event.addDomListener(saveBtn, "click", function(event) {
									var mReplace = contentString.find('span.info-content'); //html to be replaced after success
									var mName = contentString.find('input.save-name')[0].value; //name input field value
									var mDesc  = contentString.find('textarea.save-desc')[0].value; //description input field value
									var mType = contentString.find('select.save-type')[0].value; //type of marker
									
									if(mName =='' || mDesc =='')
									{
										alert("Please enter Name and Description!");
									}else{
										save_marker(marker, mName, mDesc, mType, mReplace); //call save marker function
										infowindow.close();
									}
								});
							}
								  
							//add click event listener to marker which will open infoWindow          
							google.maps.event.addListener(marker, 'click', function() {
							    infowindow.open(map,marker); // click on marker opens info window 
							});
							
							if(InfoOpenDefault) //whether info window should be open by default
						    {
						      infowindow.open(map,marker);
						    }	
						}					    					    	   
					    
					    google.maps.event.addListener(map, 'rightclick', function(event) {
							
			    			var point     = event.latLng;
			    			var name      = 'Dirección';                       			            
			                
			                //call create_marker() function for xml loaded maker
			                create_marker(point, name, EditForm, true, true, false, "http://maps.google.com/mapfiles/ms/icons/pink.png");
			    		});
					    
					    function save_marker(Marker, mName, mAddress, mType, replaceWin)
						{
							var customIcons = {
									  bar: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/blue.png'
									  },
									  hotel: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/green.png'
									  },
									  restaurant: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/yellow.png'
									  },
									  museo: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/purple.png'
									  },
									  casa: {
										    icon: 'http://maps.google.com/mapfiles/ms/icons/red.png'
									  }
									  
									};
							
							var icon = customIcons[mType];						
							
							Marker.setIcon(icon.icon);
							
							var mPosition = Marker.getPosition().toUrlValue(); //get marker position
							var mLat = Marker.getPosition().lat();
							var mLng = Marker.getPosition().lng(); 
							var myData = {nombre : mName, direccion : mAddress, latitud : mLat , longitud : mLng, tipo : mType }; //post variables
							points.push(myData);
							var json_obj = JSON.stringify(points);		
							$('#points').val(json_obj);
						}
					    
						function remove_marker(Marker)
						{		
							if(Marker.getDraggable()) 
						    {
						        Marker.setMap(null); //just remove new marker
						    }		
						}	
					    
						function create_markerPoint(mName, mAddress, mType, mPoint)
						{							
							var MapPos = mPoint;
							var MapTitle = 'Dirección';
							var MapDesc = EditForm;
							var InfoOpenDefault = false;
							var DragAble = true;
							var Removable = false; 
							var iconPath = "http://maps.google.com/mapfiles/ms/icons/pink.png";
							 																																			
							var marker = new google.maps.Marker({
							    position: MapPos, //map Coordinates where user right clicked
							    map: map,
							    draggable:DragAble, //set marker draggable 
							    animation: google.maps.Animation.DROP, //bounce animation
							    title:"Hello World!",
							    icon:  iconPath //custom pin icon
							});
							
							var contentString = $('<div class="marker-info-win">'+
							'<div class="marker-inner-win"><span class="info-content">'+
							'<h1 class="marker-heading">' + MapTitle + '</h1>'+
							MapDesc+ 
							'</span>'+
							'<br/><button name="remove-marker" class="remove-marker" title="Remove Marker" onclick="return false;" >Eliminar marcador</button></div></div>');
							    			
							
							contentString.find('input.save-name')[0].value = mName; //name input field value
							contentString.find('textarea.save-desc')[0].value = mAddress; //description input field value
							contentString.find('select.save-type')[0].value = mType; //type of marker
							
							//Create an infoWindow
							var infowindow = new google.maps.InfoWindow();
						
							//set the content of infoWindow
							infowindow.setContent(contentString[0]);
							
							//Find remove button in infoWindow
						    var removeBtn   = contentString.find('button.remove-marker')[0];

						   //Find save button in infoWindow
						    var saveBtn     = contentString.find('button.save-marker')[0];
						
						 	//###### remove marker #########/		
							google.maps.event.addDomListener(removeBtn, "click", function(event) {
								 remove_marker(marker);    
							});
						 	
							if(typeof saveBtn !== 'undefined') //continue only when save button is present
							{
								//add click listner to save marker button
								google.maps.event.addDomListener(saveBtn, "click", function(event) {
									var mReplace = contentString.find('span.info-content'); //html to be replaced after success
									var mName = contentString.find('input.save-name')[0].value; //name input field value
									var mDesc  = contentString.find('textarea.save-desc')[0].value; //description input field value
									var mType = contentString.find('select.save-type')[0].value; //type of marker
									
									if(mName =='' || mDesc =='')
									{
										alert("Please enter Name and Description!");
									}else{
										save_marker(marker, mName, mDesc, mType, mReplace); //call save marker function
										infowindow.close();
									}
								});
							}
								  
							//add click event listener to marker which will open infoWindow          
							google.maps.event.addListener(marker, 'click', function() {
							    infowindow.open(map,marker); // click on marker opens info window 
							});
							
							if(InfoOpenDefault) //whether info window should be open by default
						    {
						      infowindow.open(map,marker);
						    }
							
							
							var customIcons = {
									  bar: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/blue.png'
									  },
									  hotel: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/green.png'
									  },
									  restaurant: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/yellow.png'
									  },
									  museo: {
									    icon: 'http://maps.google.com/mapfiles/ms/icons/purple.png'
									  },
									  casa: {
										    icon: 'http://maps.google.com/mapfiles/ms/icons/red.png'
									  }
									  
							};
							
							var icon = customIcons[mType];						
							
							marker.setIcon(icon.icon);
							
							var mPosition = marker.getPosition().toUrlValue(); //get marker position
							var mLat = marker.getPosition().lat();
							var mLng = marker.getPosition().lng();																					
							var myData = {nombre : mName, direccion : mAddress, latitud : mLat , longitud : mLng, tipo : mType }; //post variables
							points.push(myData);
							var json_obj = JSON.stringify(points);		
							$('#points').val(json_obj);
							
						}
						
					</script>	
					
					<c:forEach items="${p.direccion}" var="d" varStatus="status">
						<script type="text/javascript">
						    var nombre = '${d.nombre}';
						    var direccion = '${d.direccion}';						    						    
						    var tipo = '${d.tipo}';
						    var punto 	= new google.maps.LatLng('${d.latitud}','${d.longitud}');
						    
						    create_markerPoint(nombre,direccion,tipo,punto);						    
						</script>
					</c:forEach >
																
					<br>
					
					<button type="button" onclick="window.location='ListarServlet';return false;">Cancelar</button>
					<input type="submit" name="submit" value="Actualizar">
				
				</form>
			</c:forEach>			
		</div>
</body>           
</html>