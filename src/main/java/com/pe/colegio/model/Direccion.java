package com.pe.colegio.model;

public class Direccion {
private int codigo;
private String nombre;
private String direccion;
private float latitud;
private float longitud;
private String tipo;
private int codigo_alumno;

public Direccion(int codigo, String nombre, String direccion, float latitud, float longitud, String tipo, int codigo_alumno) {
	super();
	this.codigo = codigo;
	this.nombre = nombre;
	this.direccion = direccion;
	this.latitud = latitud;
	this.longitud = longitud;
	this.tipo = tipo;
	this.codigo_alumno = codigo_alumno; 
}
public Direccion() {
	super();
	// TODO Auto-generated constructor stub
}
public int getCodigo() {
	return codigo;
}
public void setCodigo(int codigo) {
	this.codigo = codigo;
}
public String getNombre() {
	return nombre;
}
public void setNombre(String nombre) {
	this.nombre = nombre;
}
public String getDireccion() {
	return direccion;
}
public void setDireccion(String direccion) {
	this.direccion = direccion;
}
public float getLatitud() {
	return latitud;
}
public void setLatitud(float latitud) {
	this.latitud = latitud;
}
public float getLongitud() {
	return longitud;
}
public void setLongitud(float longitud) {
	this.longitud = longitud;
}
public String getTipo() {
	return tipo;
}
public void setTipo(String tipo) {
	this.tipo = tipo;
}

public int getCodigo_alumno() {
	return codigo_alumno;
}
public void setCodigo_alumno(int codigo_alumno) {
	this.codigo_alumno = codigo_alumno;
}

}
