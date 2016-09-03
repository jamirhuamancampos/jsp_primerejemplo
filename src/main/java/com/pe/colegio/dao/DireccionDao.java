package com.pe.colegio.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.pe.colegio.db.DBUtils;
import com.pe.colegio.model.Direccion;

public class DireccionDao {
	public void registrar(Direccion a){
		String sql = "insert into direccion (nombre,direccion,latitud,longitud,tipo,codigo_alumno) values(?,?,?,?,?,?)";
		PreparedStatement ps;
		try {
			ps = DBUtils.getPreparedStatement(sql);
			ps.setString(1,a.getNombre());
			ps.setString(2,a.getDireccion());
			ps.setFloat(3,a.getLatitud());
			ps.setFloat(4,a.getLongitud());
			ps.setString(5,a.getTipo());
			ps.setInt(6,a.getCodigo_alumno());
			ps.executeUpdate();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			Logger.getLogger(AlumnoDao.class.getName()).log(Level.SEVERE,null,e);
		}		
	}
	
	public static List<Direccion> listarPorCodigoAlumno(int codigo_alumno) {
		List<Direccion> al = new LinkedList<>();
		String sql = "select codigo, nombre, direccion, latitud, longitud, tipo, codigo_alumno from direccion where codigo_alumno = " + codigo_alumno;
				
		ResultSet rs;
		
		try{
			rs = DBUtils.getPreparedStatement(sql).executeQuery();
			
			while(rs.next()){
				Direccion a = new Direccion(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getFloat(4),rs.getFloat(5),rs.getString(6),rs.getInt(7));
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
	
	public void eliminarPorCodigoAlumno(int codigo_alumno){
		
		String sql="delete from direccion where codigo_alumno = ?";
		PreparedStatement ps;
		try{
			ps = DBUtils.getPreparedStatement(sql);	
			ps.setInt(1,codigo_alumno);
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
