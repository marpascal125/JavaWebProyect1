package Modelo;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Usuario
 */

import java.util.ArrayList;

public class GestionarUsuarios {

    private static ArrayList<Usuario> lista = new ArrayList<>();


    public static void agregar(Usuario u) {
        if (u != null && buscar(u.getUsuario()) == null) {
            lista.add(u);
        }
    }


    public static ArrayList<Usuario> listar() {
        return lista;
    }


    public static Usuario buscar(String usuario) {

        for (Usuario u : lista) {
            if (u.getUsuario().equalsIgnoreCase(usuario)) {
                return u;
            }
        }

        return null; 
    }

    public static void eliminar(String usuario) {
        lista.removeIf(u -> u.getUsuario().equalsIgnoreCase(usuario));
    }


    public static Usuario validar(String usuario, String password) {

        for (Usuario u : lista) {

            if (u.getUsuario().equalsIgnoreCase(usuario) &&
                u.getPassword().equals(password)) {

                return u; 
            }
        }

        return null; 
    }
}