/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Usuario
 */


public class Usuario {

    private String nombre;
    private String correo;
    private String usuario;
    private String telefono;
    private String password;
    private String rol;

    public Usuario() {}

    public Usuario(String nombre, String correo, String usuario, String telefono, String password, String rol) {
        this.nombre = nombre;
        this.correo = correo;
        this.usuario = usuario;
        this.telefono = telefono;
        this.password = password;
        this.rol = (rol != null && rol.equals("admin")) ? "admin" : "usuario";
    }

    public Usuario(String nombre, String correo, String usuario, String telefono, String password) {
        this(nombre, correo, usuario, telefono, password, "usuario");
    }

    public String getNombre(){ 
        return nombre; 
    }
    
    public String getCorreo(){
        return correo; 
    }
    
    public String getUsuario(){
        return usuario; 
    }
    
    public String getTelefono(){ 
        return telefono; 
    }
    
    public String getPassword(){ 
        return password; 
    }
    
    public String getRol(){
        return rol; 
    }

    public boolean esAdmin(){ 
        return "admin".equals(rol); 
    }

    
    public void setNombre(String nombre) {
        if (nombre != null && !nombre.isEmpty()) this.nombre = nombre;
    }
    
    public void setCorreo(String correo) {
        if (correo != null && correo.contains("@")) this.correo = correo;
    }
    
    public void setUsuario(String usuario) {
        if (usuario != null && !usuario.isEmpty()) this.usuario = usuario;
    }
    
    public void setTelefono(String telefono) {
        if (telefono != null && !telefono.isEmpty()) this.telefono = telefono;
    }
    
    public void setPassword(String password) {
        if (password != null && password.length() >= 4) this.password = password;
    }
    
    public void setRol(String rol) {
        if ("admin".equals(rol) || "usuario".equals(rol)) this.rol = rol;
    }
   
    @Override
    public String toString() {
        return "Usuario{usuario='" + usuario + "', rol='" + rol + "'}";
    }
}