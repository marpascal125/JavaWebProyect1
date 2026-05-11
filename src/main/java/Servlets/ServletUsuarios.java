/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Servlets;

import Modelo.Usuario;
import Modelo.GestionarUsuarios;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class ServletUsuarios extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        switch (accion) {

            case "registrar": {
                String nombre = request.getParameter("nombre");
                String correo = request.getParameter("correo");
                String usuario = request.getParameter("usuario");
                String telefono = request.getParameter("telefono");
                String password = request.getParameter("password");
                String confirmar = request.getParameter("confirmar");

                if (usuario == null || usuario.isEmpty() ||
                    password == null || password.isEmpty()) {
                    response.sendRedirect("registrar.jsp?error=1");
                    return;
                }
                
                if (!password.equals(confirmar)) {
                    response.sendRedirect("registrar.jsp?error=2");
                    return;
                }
                
                if (GestionarUsuarios.buscar(usuario) != null) {
                    response.sendRedirect("registrar.jsp?error=3");
                    return;
                }
                
                Usuario u = new Usuario(nombre, correo, usuario, telefono, password, "usuario");
                
                GestionarUsuarios.agregar(u);
                response.sendRedirect("login.jsp?registro=ok");
                return;
            }

            case "login": {
                String usuario  = request.getParameter("usuario");
                String password = request.getParameter("password");

                if (usuario == null || usuario.isEmpty() ||
                    password == null || password.isEmpty()) {
                    response.sendRedirect("login.jsp?error=1");
                    return;
                }
                
                Usuario u = GestionarUsuarios.validar(usuario, password);
                
                if (u != null) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("usuario", u);
                    response.sendRedirect("index.jsp");
                    
                } else {
                    response.sendRedirect("login.jsp?error=1");
                }
                
                return;
            }

            case "logout": {
                HttpSession session = request.getSession(false);
                if (session != null) session.invalidate();
                response.sendRedirect("login.jsp");
                return;
            }

            case "cambiarPassword": {
                HttpSession session = request.getSession(false);
                
                if (session == null || session.getAttribute("usuario") == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                Usuario u = (Usuario) session.getAttribute("usuario");
                String passwordActual = request.getParameter("passwordActual");
                String passwordNueva = request.getParameter("passwordNueva");
                String passwordConfirmar = request.getParameter("passwordConfirmar");

                String resultado = GestionarUsuarios.cambiarPassword( u.getUsuario(), passwordActual, passwordNueva, passwordConfirmar);

                response.sendRedirect("cambiarPassword.jsp?resultado=" + resultado);
                return;
            }

            case "listarUsuarios": {
                if (!esAdmin(request)) {
                    response.sendRedirect("index.jsp");
                    return;
                }
                request.setAttribute("listaUsuarios", GestionarUsuarios.listar());
                request.getRequestDispatcher("adminUsuarios.jsp")
                       .forward(request, response);
                return;
            }

            case "editarUsuario": {
                
                if (!esAdmin(request)) {
                    response.sendRedirect("index.jsp");
                    return;
                }
                
                String nombreUsuario = request.getParameter("usuario");
                
                Usuario u = GestionarUsuarios.buscar(nombreUsuario);
                
                if (u == null) {
                    response.sendRedirect("ServletUsuarios?accion=listarUsuarios");
                    return;
                }
                
                request.setAttribute("usuarioEditar", u);
                request.getRequestDispatcher("editarUsuario.jsp").forward(request, response);
                return;
            }

            case "actualizarUsuario": {
                
                if (!esAdmin(request)) {
                    response.sendRedirect("index.jsp");
                    return;
                }
                
                String usuarioOriginal = request.getParameter("usuarioOriginal");
                String nombre = request.getParameter("nombre");
                String correo = request.getParameter("correo");
                String telefono = request.getParameter("telefono");
                String password = request.getParameter("password");
                String rol = request.getParameter("rol");

                GestionarUsuarios.actualizar(usuarioOriginal, nombre, correo, telefono, password, rol);
                
                response.sendRedirect("ServletUsuarios?accion=listarUsuarios&actualizado=ok");
                return;
            }

            case "eliminarUsuario": {
                
                if (!esAdmin(request)) {
                    response.sendRedirect("index.jsp");
                    return;
                }
                
                String nombreUsuario = request.getParameter("usuario");
                
                boolean eliminado = GestionarUsuarios.eliminar(nombreUsuario);
                
                if (!eliminado) {
                    response.sendRedirect("ServletUsuarios?accion=listarUsuarios&error=noEliminar");
                } else {
                    response.sendRedirect("ServletUsuarios?accion=listarUsuarios&eliminado=ok");
                }
                return;
            }

            default:response.sendRedirect("index.jsp");
        }
    }

    private boolean esAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        Usuario u = (Usuario) session.getAttribute("usuario");
        return u != null && u.esAdmin();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}