/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Usuario
 */

public class Cultivo {

    private int    id;
    private String tipo;
    private double area;
    private String ubicacion;
    private String fechaSiembra;
    private String estado;
    private String imagen;
    private String usuarioRegistro;   
    private static int contador = 1;

    public Cultivo() {
        
    }

    public Cultivo(String tipo, double area, String ubicacion) {
        this.id = contador++;
        this.tipo = tipo;
        this.area = area;
        this.ubicacion = ubicacion;
        this.fechaSiembra = "No definida";
        this.estado = "Activo";
        this.imagen = "";
        this.usuarioRegistro = "";
    }

    public Cultivo(String tipo, double area, String ubicacion, String fechaSiembra, String estado, String imagen, String usuarioRegistro) {
        this.id               = contador++;
        this.tipo             = tipo;
        this.area             = area;
        this.ubicacion        = ubicacion;
        this.fechaSiembra     = fechaSiembra;
        this.estado           = estado;
        this.imagen           = (imagen != null) ? imagen : "";
        this.usuarioRegistro  = (usuarioRegistro != null) ? usuarioRegistro : "";
    }

    public Cultivo(int id, String tipo, double area, String ubicacion, String fechaSiembra, String estado, String imagen, String usuarioRegistro) {
        this.id = id;
        this.tipo = tipo;
        this.area = area;
        this.ubicacion = ubicacion;
        this.fechaSiembra = fechaSiembra;
        this.estado = estado;
        this.imagen = (imagen != null) ? imagen : "";
        this.usuarioRegistro = (usuarioRegistro != null) ? usuarioRegistro : "";
        if (id >= contador) contador = id + 1;
    }

    public int    getId(){ 
        return id; 
    }
    
    public String getTipo(){
        return tipo; }
    
    public double getArea(){ 
        return area; 
    }
    
    public String getUbicacion(){ 
        return ubicacion; 
    }
    
    public String getFechaSiembra(){ 
        return fechaSiembra; 
    }
    
    public String getEstado(){ 
        return estado; 
    }
    
    public String getImagen(){
        return imagen; 
    }
    
    public String getUsuarioRegistro(){ 
        return usuarioRegistro; 
    }

    
    public String getImagenMostrar() {
        if (imagen != null && !imagen.trim().isEmpty()) return imagen;
        return getImagenPredefinida(tipo);
    }

    public static String getImagenPredefinida(String tipo) {
        
        if (tipo == null) return "";
        
        String t = tipo.trim().toLowerCase();

        if (t.contains("papa"))
            return "https://sqm.com/wp-content/uploads/2018/04/papa-992x550.jpg";
        
        if (t.contains("yuca"))
            return "https://cuidateplus.marca.com/sites/default/files/styles/natural/public/cms/planta-yuca.jpg.webp";
        
        
        if (t.contains("maiz") || t.contains("maíz"))
            return "https://cdn.wikifarmer.com/images/detailed/2022/07/Valor-nutricional-del-maiz-y-beneficios-para-la-salud.jpg";
        
        if (t.contains("frijol"))
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhSUdLYHxlBAy0LjZwmS_I2UEcEGWOo4pN1w&s";
        
        if (t.contains("lulo"))
            return "https://www.gastronomiaycia.com/wp-content/uploads/2024/11/lulo_1-680x453.jpg";
        
        if (t.contains("aguacate"))
            return "https://www.gastronomiavasca.net/uploads/image/file/3311/w700_aguacate.jpg";
        
        if (t.contains("platano") || t.contains("plátano"))
            return "https://sembrandocali.org/wp-content/uploads/bb-plugin/cache/PLATANO-VERDE-square.jpg";
        
        if (t.contains("cacao"))
            return "https://grandsur.com/wp-content/uploads/2021/02/GrandSur-Our-Products-ASSS.jpg";
        
        if (t.contains("tomate"))
            return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3DRPxLp5XH4U1fUPLQwkWQn7fUd368gb2lUCx9qEKuUb5LhktbVpEcMTg_3EP_rx99pWkU_cdJ_ZETZlfswgCjwu5DhipxhHqNXYkPJ0&s=10";
        
        if (t.contains("lechuga"))
            return "https://cdn.croper.com/images/4eyenl0rs-61e9ijij51z/original.jpeg";
        
        return "";
    }

    public void setTipo(String tipo) {
        if (tipo != null && !tipo.isEmpty()) this.tipo = tipo;
    }
    
    public void setArea(double area) {
        if (area >= 0) this.area = area;
    }
    
    public void setUbicacion(String ubicacion) {
        if (ubicacion != null && !ubicacion.isEmpty()) this.ubicacion = ubicacion;
    }
    
    public void setFechaSiembra(String fechaSiembra) {
        if (fechaSiembra != null && !fechaSiembra.isEmpty()) this.fechaSiembra = fechaSiembra;
    }
    
    public void setEstado(String estado) {
        if (estado != null &&
           (estado.equals("Activo") || estado.equals("Finalizado")))
            this.estado = estado;
    }
    
    public void setImagen(String imagen) {
        this.imagen = (imagen != null) ? imagen : "";
    }
    
    public void setUsuarioRegistro(String usuarioRegistro) {
        this.usuarioRegistro = (usuarioRegistro != null) ? usuarioRegistro : "";
    }

    @Override
    public String toString() {
        return "Cultivo{id=" + id +
               ", tipo='" + tipo + '\'' +
               ", area=" + area +
               ", ubicacion='" + ubicacion + '\'' +
               ", fechaSiembra='" + fechaSiembra + '\'' +
               ", estado='" + estado + '\'' +
               ", usuarioRegistro='" + usuarioRegistro + '\'' + '}';
    }
}