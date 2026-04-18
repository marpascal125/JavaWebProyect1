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

    private int id;      
    private String tipo;    
    private double area;      
    private String ubicacion;  
    private String fechaSiembra; 
    private String estado;       

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
    }

    public Cultivo(String tipo, double area,
                   String ubicacion,
                   String fechaSiembra,
                   String estado) {

        this.id = contador++;
        this.tipo = tipo;
        this.area = area;
        this.ubicacion = ubicacion;
        this.fechaSiembra = fechaSiembra;
        this.estado = estado;
    }


    public int getId() {
        return id;
    }

    public String getTipo() {
        return tipo;
    }

    public double getArea() {
        return area;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public String getFechaSiembra() {
        return fechaSiembra;
    }

    public String getEstado() {
        return estado;
    }

    public void setTipo(String tipo) {
        if (tipo != null && !tipo.isEmpty()) {
            this.tipo = tipo;
        }
    }

    public void setArea(double area) {
        if (area >= 0) {
            this.area = area;
        }
    }

    public void setUbicacion(String ubicacion) {
        if (ubicacion != null && !ubicacion.isEmpty()) {
            this.ubicacion = ubicacion;
        }
    }

    public void setFechaSiembra(String fechaSiembra) {
        if (fechaSiembra != null && !fechaSiembra.isEmpty()) {
            this.fechaSiembra = fechaSiembra;
        }
    }

    public void setEstado(String estado) {
     
        if (estado != null && (estado.equals("Activo") || estado.equals("Finalizado"))) {
            this.estado = estado;
        }
    }


    @Override
    public String toString() {
        return "Cultivo{" +
                "id=" + id +
                ", tipo='" + tipo + '\'' +
                ", area=" + area +
                ", ubicacion='" + ubicacion + '\'' +
                ", fechaSiembra='" + fechaSiembra + '\'' +
                ", estado='" + estado + '\'' +
                '}';
    }
}