package com.pe.colegio.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.pe.colegio.db.DBUtils;
import com.pe.colegio.model.Alumno;
import com.pe.colegio.model.Direccion;

public class AlumnoDao {
	public void registrar(Alumno a){
		String sql = "insert into alumno (nombre,apellidopaterno,apellidomaterno,fecharegistro,observacion) values(?,?,?,?,?)";
		PreparedStatement ps;
		try {
			ps = DBUtils.getPreparedStatement(sql);
			ps.setString(1,a.getNombre());
			ps.setString(2,a.getApellidopaterno());
			ps.setString(3,a.getApellidomaterno());
			ps.setDate(4,a.getFecharegistro());
			ps.setString(5,a.getObservacion());
			
			int affectedRows = ps.executeUpdate();
			
			if (affectedRows == 0) 
			{
	            throw new SQLException("Creación de alumno fallado, no hay filas afectadas.");
	        }
			
		    try (ResultSet rs = ps.getGeneratedKeys()) 
		    {
		        if (rs != null && rs.next()) 
		        {		            		        	
		        	for(Direccion direc: a.getDireccion())
		        	{		        		
		        		direc.setCodigo_alumno(rs.getInt(1));
		        		
						DireccionDao dirdao = new DireccionDao();					
						dirdao.registrar(direc);
					}
		        }
		        else 
		        {
	                throw new SQLException("Creación de alumno fallado, sin codigo obtenido.");
	            }
		        
		        rs.close();
		    }
									
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		}		
	}
	
	public static List<Alumno> listar() {
		List<Alumno> al = new LinkedList<>();
		String sql = "select codigo, nombre, apellidopaterno, apellidomaterno,fecharegistro,observacion from alumno";
				
		ResultSet rs;
		
		try{
			rs = DBUtils.getPreparedStatement(sql).executeQuery();
			while(rs.next()){
				
				List<Direccion> dir = DireccionDao.listarPorCodigoAlumno(rs.getInt(1));
								
				Alumno a = new Alumno(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDate(5),rs.getString(6),dir);
				al.add(a);
			}
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		}
				
		return al;
	}
	
	public static List<Alumno> obtener(int codigo) {
		List<Alumno> al = new LinkedList<>();
		String sql = "select * from alumno where codigo = " + codigo;
		ResultSet rs;
		
		try{
			rs = DBUtils.getPreparedStatement(sql).executeQuery();
			
			while(rs.next()){
				
				List<Direccion> dir = DireccionDao.listarPorCodigoAlumno(rs.getInt(1));
				
				Alumno a = new Alumno(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDate(5),rs.getString(6),dir);
				al.add(a);
			}
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		}
				
		return al;
	}
	
	public void editar(int codigo, String nombre, String apellidopaterno,String apellidomaterno, Date fecharegistro, String observacion)
	{
		String sql = "update alumno set nombre = ?, apellidopaterno = ?, apellidomaterno = ?, fecharegistro = ?, observacion = ?" + " where codigo = ?";
		PreparedStatement ps;
		try{				
		ps = DBUtils.getPreparedStatement(sql);
		ps.setString(1,nombre);
		ps.setString(2,apellidopaterno);
		ps.setString(3,apellidomaterno);
		ps.setDate(4,fecharegistro);
		ps.setString(5,observacion);
		ps.setInt(6,codigo);
		ps.executeUpdate();
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		}
	}
	
	public void eliminar(int codigo){
		
		String sql="delete from alumno where codigo = ?";
		PreparedStatement ps;
		try{			
			DireccionDao direc = new DireccionDao();
			direc.eliminarPorCodigoAlumno(codigo);
			
			ps = DBUtils.getPreparedStatement(sql);	
			ps.setInt(1,codigo);
			ps.executeUpdate();
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block			
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		}
	}
}
