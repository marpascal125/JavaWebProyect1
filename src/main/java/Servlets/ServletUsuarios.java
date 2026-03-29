/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.ArrayList;

public class ServletUsuarios extends HttpServlet {

    
    private static ArrayList<Usuario> listaUsuarios = new ArrayList<>();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        
        if ("registrar".equals(accion)) {

            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String usuario = request.getParameter("usuario");
            String telefono = request.getParameter("telefono");
            String password = request.getParameter("password");

            Usuario u = new Usuario(nombre, correo, usuario, telefono, password);

            
            listaUsuarios.add(u);

            response.sendRedirect("login.jsp");
            return;
        }

        
        if ("login".equals(accion)) {

            String usuario = request.getParameter("usuario");
            String password = request.getParameter("password");

            for (Usuario u : listaUsuarios) {

                if (u.getUsuario().equals(usuario) && u.getPassword().equals(password)) {

                    HttpSession session = request.getSession();
                    session.setAttribute("usuario", usuario);

                    response.sendRedirect("index.jsp");
                    return;
                }
            }

            
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();

            out.println("<h2>Usuario o contraseña incorrectos</h2>");
            out.println("<a href='login.jsp'>Volver</a>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}