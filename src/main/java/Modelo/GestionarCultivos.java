/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

/**
 *
 * @author Usuario
 */

import java.io.*;
import java.util.ArrayList;

public class GestionarCultivos {

    private static final String DIRECTORIO = System.getProperty("user.home") + "/agrosmart/";
    private static final String ARCHIVO_DATOS = DIRECTORIO + "cultivos.txt";
    private static final String ARCHIVO_REPORTE = DIRECTORIO + "reporte_cultivos.txt";
    private static final String SEP = ";";

    private static ArrayList<Cultivo> lista = new ArrayList<>();

    static {
        crearDirectorio();
        cargar();
    }

    
    public static void agregar(Cultivo c) {
        if (c != null) { lista.add(c); guardar(); }
    }

    public static ArrayList<Cultivo> listar() { return lista; }

    public static Cultivo buscar(int id) {
        for (Cultivo c : lista) if (c.getId() == id) return c;
        return null;
    }

    public static void eliminar(int id) {
        lista.removeIf(c -> c.getId() == id);
        guardar();
    }

    public static void actualizar(int id, String tipo, double area, String ubicacion, String fechaSiembra, String estado, String imagen) {
        Cultivo c = buscar(id);
        
        if (c != null) {
            c.setTipo(tipo);
            c.setArea(area);
            c.setUbicacion(ubicacion);
            c.setFechaSiembra(fechaSiembra);
            c.setEstado(estado);
            c.setImagen(imagen);
            guardar();
        }
    }

    public static ArrayList<Cultivo> filtrar(String tipo, String ubicacion) {
        ArrayList<Cultivo> resultado = new ArrayList<>();
        
        for (Cultivo c : lista) {
            boolean okTipo = (tipo == null || tipo.isEmpty() || c.getTipo().toLowerCase().contains(tipo.toLowerCase()));
            
            boolean okUbic = (ubicacion == null || ubicacion.isEmpty() || c.getUbicacion().toLowerCase().contains(ubicacion.toLowerCase()));
            
            if (okTipo && okUbic) resultado.add(c);
        }
        return resultado;
    }
    
    public static ArrayList<Cultivo> listarPorUsuario(String usuarioRegistro) {
        
        ArrayList<Cultivo> resultado = new ArrayList<>();
        
        for (Cultivo c : lista) {
            if (c.getUsuarioRegistro().equalsIgnoreCase(usuarioRegistro))
                resultado.add(c);
        }
        return resultado;
    }

    public static void guardar() {
        FileWriter  writer = null;
        PrintWriter pw     = null;
        
        try {
            crearDirectorio();
            File archivo = new File(ARCHIVO_DATOS);
            writer = new FileWriter(archivo, false);
            pw     = new PrintWriter(writer);
            
            for (Cultivo c : lista) {
                pw.println(
                    c.getId()               + SEP +
                    c.getTipo()             + SEP +
                    c.getArea()             + SEP +
                    c.getUbicacion()        + SEP +
                    c.getFechaSiembra()     + SEP +
                    c.getEstado()           + SEP +
                    c.getImagen()           + SEP +
                    c.getUsuarioRegistro()
                );
            }
            
        } catch (IOException e) {
            System.err.println("[AgroSmart] Error al guardar: " + e.getMessage());
            
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
                
                String[] p = linea.split(SEP, 8);
                
                if (p.length >= 6) {
                    int    id              = Integer.parseInt(p[0].trim());
                    String tipo            = p[1].trim();
                    double area            = Double.parseDouble(p[2].trim());
                    String ubicacion       = p[3].trim();
                    String fechaSiembra    = p[4].trim();
                    String estado          = p[5].trim();
                    String imagen          = (p.length >= 7) ? p[6].trim() : "";
                    String usuarioRegistro = (p.length == 8) ? p[7].trim() : "";
                    lista.add(new Cultivo(id, tipo, area, ubicacion, fechaSiembra, estado, imagen, usuarioRegistro));
                }
            }
            
        } catch (IOException e) {
            System.err.println("[AgroSmart] Error al cargar: " + e.getMessage());
            
        } finally {
            
            try {
                if (buffer != null) buffer.close();
                if (reader != null) reader.close();
                
            } catch (IOException e2) { e2.printStackTrace(); }
        }
    }

    
    public static String generarReporte(String estado, String usuario) {
        FileWriter  writer = null;
        PrintWriter pw     = null;
        
        try {
            
            crearDirectorio();
            File archivo = new File(ARCHIVO_REPORTE);
            writer = new FileWriter(archivo, false);
            pw     = new PrintWriter(writer);

            ArrayList<Cultivo> filtrados = new ArrayList<>();
            for (Cultivo c : lista) {
                boolean okEstado  = (estado == null   ||
                                     estado.isEmpty() ||
                                     "Todos".equals(estado) ||
                                     estado.equals(c.getEstado()));
                boolean okUsuario = (usuario == null   ||
                                     usuario.isEmpty() ||
                                     c.getUsuarioRegistro().equalsIgnoreCase(usuario));
                if (okEstado && okUsuario) {
                    filtrados.add(c);
                }
            }

            String tituloEstado  = (estado == null || estado.isEmpty() || "Todos".equals(estado)) ? "Todos" : estado + "s";
            String tituloUsuario = (usuario == null || usuario.isEmpty())? "Todos los usuarios" : usuario;

            int totalActivos = 0, totalFinalizados = 0;
            
            for (Cultivo c : filtrados) {
                if ("Activo".equals(c.getEstado())) totalActivos++;
                else totalFinalizados++;
            }

            pw.println("==============================================");
            pw.println("       REPORTE DE CULTIVOS - AgroSmart        ");
            pw.println("==============================================");
            pw.println("Filtro de estado  : " + tituloEstado);
            pw.println("Filtro de usuario : " + tituloUsuario);
            pw.println("Total encontrados : " + filtrados.size());
            pw.println("  Activos         : " + totalActivos);
            pw.println("  Finalizados     : " + totalFinalizados);
            pw.println();
            pw.println("----------------------------------------------");

            if (filtrados.isEmpty()) {
                pw.println("  No se encontraron cultivos con los filtros aplicados.");
                pw.println("----------------------------------------------");
            } else {
                for (Cultivo c : filtrados) {
                    pw.println("ID              : " + c.getId());
                    pw.println("Tipo            : " + c.getTipo());
                    pw.println("Area            : " + c.getArea() + " ha");
                    pw.println("Ubicacion       : " + c.getUbicacion());
                    pw.println("Fecha siembra   : " + c.getFechaSiembra());
                    pw.println("Estado          : " + c.getEstado());
                    pw.println("Registrado por  : " + c.getUsuarioRegistro());
                    pw.println("----------------------------------------------");
                }
            }

            pw.println("==============================================");
            pw.println("           FIN DEL REPORTE                   ");
            pw.println("==============================================");

            return archivo.getAbsolutePath();

        } catch (IOException e) {
            
            System.err.println("[AgroSmart] Error al generar reporte: " + e.getMessage());
            return null;
            
        } finally {
            
            try {
                if (pw     != null) pw.close();
                if (writer != null) writer.close();
            } catch (IOException e2) { e2.printStackTrace(); }
        }
    }

    private static void crearDirectorio() {
        File dir = new File(DIRECTORIO);
        if (!dir.exists()) dir.mkdirs();
    }
}