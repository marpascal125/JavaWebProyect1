/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Modelo.Cultivo;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.ArrayList;

public class ServletCultivos extends HttpServlet {

    private static ArrayList<Cultivo> listaCultivos = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipo = request.getParameter("tipo");
        String areaStr = request.getParameter("area");
        String ubicacion = request.getParameter("ubicacion");

        
        double area = 0;
        if (areaStr != null && !areaStr.isEmpty()) {
            area = Double.parseDouble(areaStr);
        }

        
        if (tipo == null) tipo = "";
        if (ubicacion == null) ubicacion = "";

        Cultivo c = new Cultivo(tipo, area, ubicacion);

        listaCultivos.add(c);

        request.setAttribute("lista", listaCultivos);
        request.getRequestDispatcher("listCultivos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}