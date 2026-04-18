/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Usuario
 */

import java.util.ArrayList;

public class GestionarCultivos {

    private static ArrayList<Cultivo> lista = new ArrayList<>();

    
    public static void agregar(Cultivo c) {
        if (c != null) {
            lista.add(c);
        }
    }

    public static ArrayList<Cultivo> listar() {
        return lista;
    }


    public static Cultivo buscar(int id) {

        for (Cultivo c : lista) {
            if (c.getId() == id) {
                return c;
            }
        }

        return null;
    }


    public static void eliminar(int id) {
        lista.removeIf(c -> c.getId() == id);
    }


    public static void actualizar(int id,
                                  String tipo,
                                  double area,
                                  String ubicacion,
                                  String fechaSiembra,
                                  String estado) {

        Cultivo c = buscar(id);

        if (c != null) {
            c.setTipo(tipo);
            c.setArea(area);
            c.setUbicacion(ubicacion);
            c.setFechaSiembra(fechaSiembra);
            c.setEstado(estado);
        }
    }


    public static ArrayList<Cultivo> filtrar(String tipo, String ubicacion) {

        ArrayList<Cultivo> resultado = new ArrayList<>();

        for (Cultivo c : lista) {

            boolean coincideTipo =
                    (tipo == null || tipo.isEmpty()
                    || c.getTipo().toLowerCase().contains(tipo.toLowerCase()));

            boolean coincideUbicacion =
                    (ubicacion == null || ubicacion.isEmpty()
                    || c.getUbicacion().toLowerCase().contains(ubicacion.toLowerCase()));

            if (coincideTipo && coincideUbicacion) {
                resultado.add(c);
            }
        }

        return resultado;
    }
}