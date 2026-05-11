package Modelo;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Usuario
 */

import java.io.*;
import java.util.ArrayList;


public class GestionarUsuarios {

    private static final String DIRECTORIO    =
            System.getProperty("user.home") + "/agrosmart/";
    private static final String ARCHIVO_DATOS = DIRECTORIO + "usuarios.txt";
    private static final String SEP           = ";";

    private static ArrayList<Usuario> lista = new ArrayList<>();

    static {
        crearDirectorio();
        cargar();
        crearAdminPorDefecto();
    }

    public static void agregar(Usuario u) {
        if (u != null && buscar(u.getUsuario()) == null) {
            lista.add(u);
            guardar();
        }
    }
    
    public static ArrayList<Usuario> listar() { return lista; }

    public static Usuario buscar(String usuario) {
        for (Usuario u : lista) {
            if (u.getUsuario().equalsIgnoreCase(usuario)) return u;
        }
        return null;
    }

    public static boolean eliminar(String usuario) {
        Usuario u = buscar(usuario);
        if (u == null || u.esAdmin()) return false;
        lista.removeIf(x -> x.getUsuario().equalsIgnoreCase(usuario));
        guardar();
        return true;
    }

    public static void actualizar(String usuarioOriginal, String nombre, String correo, String telefono, String password, String rol) {
        Usuario u = buscar(usuarioOriginal);
        
        if (u != null) {
            u.setNombre(nombre);
            u.setCorreo(correo);
            u.setTelefono(telefono);
            
            if (password != null && password.length() >= 4)
                u.setPassword(password);
            
            if (!usuarioOriginal.equalsIgnoreCase("admin"))
                u.setRol(rol);
            guardar();
        }
    }

    public static String cambiarPassword(String nombreUsuario, String passwordActual, String passwordNueva, String passwordConfirmar) {
        Usuario u = buscar(nombreUsuario);
        if (u == null) return "errorActual";

        if (!u.getPassword().equals(passwordActual)) return "errorActual";

        if (passwordNueva == null || passwordNueva.length() < 4) return "errorCorta";

        if (!passwordNueva.equals(passwordConfirmar)) return "errorCoincide";

        u.setPassword(passwordNueva);
        guardar();
        return "ok";
    }

    public static Usuario validar(String usuario, String password) {
        for (Usuario u : lista) {
            if (u.getUsuario().equalsIgnoreCase(usuario) &&
                u.getPassword().equals(password)) return u;
        }
        return null;
    }

    public static void guardar() {
        FileWriter  writer = null;
        PrintWriter pw     = null;
        
        try {
            crearDirectorio();
            File archivo = new File(ARCHIVO_DATOS);
            writer = new FileWriter(archivo, false);
            pw     = new PrintWriter(writer);
            
            for (Usuario u : lista) {
                pw.println(
                    u.getNombre()   + SEP +
                    u.getCorreo()   + SEP +
                    u.getUsuario()  + SEP +
                    u.getTelefono() + SEP +
                    u.getPassword() + SEP +
                    u.getRol()
                );
            }
            
        } catch (IOException e) {
            System.err.println("[AgroSmart] Error al guardar usuarios: " + e.getMessage());
            
        } finally {
            
            try {
                if (pw     != null) pw.close();
                if (writer != null) writer.close();
            } catch (IOException e2) { e2.printStackTrace(); }
        }
    }

    public static void cargar() {
        FileReader     reader = null;
        BufferedReader buffer = null;
        
        try {
            
            File archivo = new File(ARCHIVO_DATOS);
            if (!archivo.exists()) return;
            reader = new FileReader(archivo);
            buffer = new BufferedReader(reader);
            lista.clear();
            String linea;
            
            while ((linea = buffer.readLine()) != null) {
                linea = linea.trim();
                
                if (linea.isEmpty()) continue;
                String[] p = linea.split(SEP);
                
                if (p.length >= 5) {
                    String nombre   = p[0].trim();
                    String correo   = p[1].trim();
                    String usuario  = p[2].trim();
                    String telefono = p[3].trim();
                    String password = p[4].trim();
                    String rol = (p.length == 6) ? p[5].trim() : "usuario";
                    lista.add(new Usuario(nombre, correo, usuario, telefono, password, rol));
                }
            }
            
        } catch (IOException e) {
            System.err.println("[AgroSmart] Error al cargar usuarios: " + e.getMessage());
            
        } finally {
            
            try {
                if (buffer != null) buffer.close();
                if (reader != null) reader.close();
            } catch (IOException e2) { e2.printStackTrace(); }
        }
    }

    private static void crearAdminPorDefecto() {
        boolean hayAdmin = false;
        
        for (Usuario u : lista) {
            if (u.esAdmin()) { hayAdmin = true; break; }
        }
        
        if (!hayAdmin) {
            Usuario admin = new Usuario(
                "Administrador", "admin@agrosmart.com",
                "admin", "0000000000", "admin123", "admin"
            );
            
            lista.add(admin);
            guardar();
        }
    }

    private static void crearDirectorio() {
        File dir = new File(DIRECTORIO);
        if (!dir.exists()) dir.mkdirs();
    }
}