/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Servlets;

import Modelo.Cultivo;
import Modelo.GestionarCultivos;
import Modelo.Usuario;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ServletCultivos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("adminCultivos.jsp");
            return;
        }

        switch (accion) {

            case "crear": {
                String tipo = request.getParameter("tipo");
                String areaStr = request.getParameter("area");
                String ubicacion = request.getParameter("ubicacion");
                String fechaSiembra = request.getParameter("fechaSiembra");
                String estado = request.getParameter("estado");
                String imagen = request.getParameter("imagen");

                HttpSession session = request.getSession(false);
                
                String usuarioRegistro = "";
                
                if (session != null && session.getAttribute("usuario") != null) {
                    Usuario u = (Usuario) session.getAttribute("usuario");
                    usuarioRegistro = u.getUsuario();
                }

                double area = 0;
                
                try {
                    if (areaStr != null && !areaStr.isEmpty())
                        area = Double.parseDouble(areaStr);
                    
                } catch (NumberFormatException e) { area = 0; }

                Cultivo c = new Cultivo(tipo, area, ubicacion, fechaSiembra, estado, imagen, usuarioRegistro);
                
                GestionarCultivos.agregar(c);
                
                response.sendRedirect("ServletCultivos?accion=listar");
                return;
            }

            case "listar": {
                request.setAttribute("lista", GestionarCultivos.listar());
                request.getRequestDispatcher("listCultivos.jsp").forward(request, response);
                return;
            }

            case "eliminar": {
                
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    GestionarCultivos.eliminar(id);
                    
                } catch (NumberFormatException e) { }
                
                response.sendRedirect("ServletCultivos?accion=listar");
                return;
            }

            case "editar": {
                try {
                    int id    = Integer.parseInt(request.getParameter("id"));
                    
                    Cultivo c = GestionarCultivos.buscar(id);
                    
                    request.setAttribute("cultivo", c);
                    
                    request.getRequestDispatcher("editarCultivo.jsp").forward(request, response);
                    
                } catch (Exception e) {
                    response.sendRedirect("ServletCultivos?accion=listar");
                }
                return;
            }

            case "actualizar": {
                try {
                    int    id = Integer.parseInt(request.getParameter("id"));
                    String tipo = request.getParameter("tipo");
                    String areaStr = request.getParameter("area");
                    String ubicacion = request.getParameter("ubicacion");
                    String fechaSiembra = request.getParameter("fechaSiembra");
                    String estado = request.getParameter("estado");
                    String imagen = request.getParameter("imagen");

                    double area = 0;
                    
                    if (areaStr != null && !areaStr.isEmpty())
                        area = Double.parseDouble(areaStr);

                    GestionarCultivos.actualizar(id, tipo, area, ubicacion, fechaSiembra, estado, imagen);
                    
                } catch (Exception e) { }
                
                response.sendRedirect("ServletCultivos?accion=listar");
                return;
            }

            case "filtrar": {
                String tipo      = request.getParameter("tipo"); 
                String ubicacion = request.getParameter("ubicacion");
                
                request.setAttribute("lista", GestionarCultivos.filtrar(tipo, ubicacion));
                request.getRequestDispatcher("listCultivos.jsp").forward(request, response);
                return;
            }

            case "cultivosUsuario": {
                String nombreUsuario = request.getParameter("usuario");
                
                request.setAttribute("listaCultivosUsuario", GestionarCultivos.listarPorUsuario(nombreUsuario));
                request.setAttribute("usuarioFiltro", nombreUsuario);
                request.getRequestDispatcher("cultivosUsuario.jsp").forward(request, response);
                return;
            }

            case "reporte": {
                String estadoFiltro  = request.getParameter("estadoFiltro");
                String usuarioFiltro = request.getParameter("usuarioFiltro");

                HttpSession session = request.getSession(false);
                
                if (session != null && session.getAttribute("usuario") != null) {
                    Usuario u = (Usuario) session.getAttribute("usuario");
                    
                    if (!u.esAdmin()) {
                        usuarioFiltro = u.getUsuario();
                    }
                }

                String rutaGenerada = GestionarCultivos.generarReporte( estadoFiltro, usuarioFiltro);

                if (rutaGenerada == null) {
                    request.setAttribute("mensajeReporte", "Error al generar el reporte. Intente de nuevo.");
                    request.setAttribute("lista", GestionarCultivos.listar());
                    request.getRequestDispatcher("listCultivos.jsp").forward(request, response);
                    return;
                }

                String nombreArchivo = "reporte_cultivos";
                
                if (estadoFiltro != null && !estadoFiltro.isEmpty() &&
                    !"Todos".equals(estadoFiltro)) {
                    nombreArchivo += "_" + estadoFiltro.toLowerCase();
                }
                
                if (usuarioFiltro != null && !usuarioFiltro.isEmpty()) {
                    nombreArchivo += "_" + usuarioFiltro;
                }
                
                nombreArchivo += ".txt";

                File archivo = new File(rutaGenerada);
                
                response.setContentType("text/plain; charset=UTF-8");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + nombreArchivo + "\"");
                response.setContentLengthLong(archivo.length());

                FileReader     fr = null;
                BufferedReader br = null;
                PrintWriter    pw = response.getWriter();
                
                try {
                    fr = new FileReader(archivo);
                    br = new BufferedReader(fr);
                    String linea;
                    while ((linea = br.readLine()) != null) pw.println(linea);
                    pw.flush();
                    
                } catch (IOException e) {
                    e.printStackTrace();
                    
                } finally {
                    try {
                        if (br != null) br.close();
                        if (fr != null) fr.close();
                        
                    } catch (IOException e2) { e2.printStackTrace(); }
                }
                return;
            }

            default:response.sendRedirect("adminCultivos.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        processRequest(request, response);
    }
}