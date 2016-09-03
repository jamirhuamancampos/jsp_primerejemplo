package com.pe.colegio.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Alumno implements Serializable {

	private static final long serialVersionUID = 3340106145531621062L;
	  
	private int codigo;
	private String nombre;
    private String apellidopaterno;
    private String apellidomaterno;
    private Date fecharegistro;
    private String observacion;
    	
	private List<Direccion> direccion = new ArrayList<Direccion>();
    	    
    public Alumno() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Alumno(int codigo, String nombre, String apellidopaterno, String apellidomaterno,Date fecharegistro,String observacion,List<Direccion> direccion) {
		super();
		this.codigo = codigo;
		this.nombre = nombre;
		this.apellidopaterno = apellidopaterno;
		this.apellidomaterno = apellidomaterno;
		this.fecharegistro = fecharegistro;
		this.observacion = observacion;
		this.direccion = direccion;
	}
	
	public List<Direccion> getDireccion() {
		return direccion;
	}
	public void setDireccion(List<Direccion> direccion) {
		this.direccion = direccion;
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
	public String getApellidopaterno() {
		return apellidopaterno;
	}
	public void setApellidopaterno(String apellidopaterno) {
		this.apellidopaterno = apellidopaterno;
	}
	public String getApellidomaterno() {
		return apellidomaterno;
	}
	public void setApellidomaterno(String apellidomaterno) {
		this.apellidomaterno = apellidomaterno;
	}	
    
	public Date getFecharegistro() {
		return fecharegistro;
	}
	public void setFecharegistro(Date fecharegistro) {
		this.fecharegistro = fecharegistro;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
}
