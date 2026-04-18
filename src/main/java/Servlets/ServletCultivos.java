/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Servlets;

import Modelo.Cultivo;
import Modelo.GestionarCultivos;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ServletCultivos extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {

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

                double area = 0;

                try {
                    if (areaStr != null && !areaStr.isEmpty()) {
                        area = Double.parseDouble(areaStr);
                    }
                } catch (Exception e) {
                    area = 0;
                }

                Cultivo c = new Cultivo(tipo, area, ubicacion, fechaSiembra, estado);

                GestionarCultivos.agregar(c);

                response.sendRedirect("ServletCultivos?accion=listar");
                return;
            }


            case "listar": {

                request.setAttribute("lista",
                        GestionarCultivos.listar());

                request.getRequestDispatcher("listCultivos.jsp")
                        .forward(request, response);
                return;
            }

            case "eliminar": {

                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    GestionarCultivos.eliminar(id);
                } catch (Exception e) {
                 
                }

                response.sendRedirect("ServletCultivos?accion=listar");
                return;
            }


            case "editar": {

                try {
                    int id = Integer.parseInt(request.getParameter("id"));

                    Cultivo c = GestionarCultivos.buscar(id);

                    request.setAttribute("cultivo", c);

                    request.getRequestDispatcher("editarCultivo.jsp")
                            .forward(request, response);

                } catch (Exception e) {
                    response.sendRedirect("ServletCultivos?accion=listar");
                }

                return;
            }

            case "actualizar": {

                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String tipo = request.getParameter("tipo");
                    String areaStr = request.getParameter("area");
                    String ubicacion = request.getParameter("ubicacion");
                    String fechaSiembra = request.getParameter("fechaSiembra");
                    String estado = request.getParameter("estado");

                    double area = 0;

                    if (areaStr != null && !areaStr.isEmpty()) {
                        area = Double.parseDouble(areaStr);
                    }

                    GestionarCultivos.actualizar(
                            id, tipo, area, ubicacion, fechaSiembra, estado
                    );

                } catch (Exception e) {
                    
                }

                response.sendRedirect("ServletCultivos?accion=listar");
                return;
            }


            case "filtrar": {

                String tipo = request.getParameter("tipo");
                String ubicacion = request.getParameter("ubicacion");

                request.setAttribute("lista",
                        GestionarCultivos.filtrar(tipo, ubicacion));

                request.getRequestDispatcher("listCultivos.jsp")
                        .forward(request, response);
                return;
            }

            default:
                response.sendRedirect("adminCultivos.jsp");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }
}