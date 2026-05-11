<%-- 
    Document   : adminUsuarios
    Created on : 6/05/2026, 4:25:26 p. m.
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Administrar Usuarios</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<%
Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

if (usuarioSesion == null || !usuarioSesion.esAdmin()) {
    response.sendRedirect("index.jsp");
    return;
}

ArrayList<Usuario> listaUsuarios = (ArrayList<Usuario>) request.getAttribute("listaUsuarios");

String actualizado = request.getParameter("actualizado");
String eliminado   = request.getParameter("eliminado");
String error       = request.getParameter("error");
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    
<div class="card-custom card-wide">

    <div class="d-flex justify-content-between align-items-center mb-3">
        
        <a href="index.jsp" class="btn btn-secondary btn-sm">Inicio</a>
        
        <h2 class="mb-0">Panel de Administrador</h2>
        
        <a href="ServletCultivos?accion=listar" class="btn btn-success btn-sm">
            Ver Cultivos
        </a>
    </div>

    <% if ("ok".equals(actualizado)) { %>
    
        <div class="alert alert-success alert-dismissible fade show">
            Usuario actualizado correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    
    <% } %>
    <% if ("ok".equals(eliminado)) { %>
    
        <div class="alert alert-success alert-dismissible fade show">
            Usuario eliminado correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    
    <% } %>
    <% if ("noEliminar".equals(error)) { %>
    
        <div class="alert alert-danger alert-dismissible fade show">
            No se puede eliminar al administrador principal.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    
    <% } %>

    <p class="text-muted text-center">
        Lista de todas las cuentas registradas en el sistema.
    </p>

    <table class="table table-bordered table-hover mt-3 text-center">
        
    <thead>
    <tr>
        <th>Nombre</th>
        <th>Correo</th>
        <th>Usuario</th>
        <th>Telefono</th>
        <th>Rol</th>
        <th>Acciones</th>
    </tr>
    
    </thead>
    
    <tbody>
    <%
    if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
        for (Usuario u : listaUsuarios) {
    %>
    
    <tr>
        <td><%= u.getNombre() %></td>
        <td><%= u.getCorreo() %></td>
        <td><%= u.getUsuario() %></td>
        <td><%= u.getTelefono() %></td>
        
        <td>
            <% if (u.esAdmin()) { %>
                <span class="badge bg-primary">Admin</span>
                
            <% } else { %>
                <span class="badge bg-secondary">Usuario</span>
            <% } %>
        </td>
        
        <td>
            <div class="d-flex justify-content-center gap-2">
                
                <a href="ServletUsuarios?accion=editarUsuario&usuario=<%= u.getUsuario() %>"
                   class="btn btn-warning btn-sm">Editar</a>
                <% if (!u.esAdmin()) { %>
                
                <a href="ServletUsuarios?accion=eliminarUsuario&usuario=<%= u.getUsuario() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Eliminar usuario <%= u.getUsuario() %>?')">
                   Eliminar
                </a>
                <% } %>
            </div>
        </td>
    </tr>
    <%
        }
    } else { %>
    <tr>
        <td colspan="6">No hay usuarios registrados.</td>
    </tr>
    <% } %>
    </tbody>
    </table>

</div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>