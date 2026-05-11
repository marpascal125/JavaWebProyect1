<%-- 
    Document   : cultivosUsuario
    Created on : 9/05/2026, 1:07:17 p. m.
    Author     : Usuario
--%>

<%@page import="Modelo.Cultivo"%>
<%@page import="Modelo.Usuario"%>
<%@page import="Modelo.GestionarUsuarios"%>
<%@page import="Modelo.GestionarCultivos"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Cultivos Por Usuarios</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<%
Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
if (usuarioSesion == null) {
    response.sendRedirect("login.jsp");
    return;
}

ArrayList<Usuario> listaUsuarios = GestionarUsuarios.listar();
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
<div class="card-custom card-wide">

    <div class="d-flex justify-content-between align-items-center mb-3">
        <a href="index.jsp" class="btn btn-secondary btn-sm">Inicio</a>
        <h2 class="mb-0">Cultivos por Usuario</h2>
        <a href="ServletCultivos?accion=listar" class="btn btn-success btn-sm">
            Ver todos
        </a>
    </div>


    <%
    for (Usuario u : listaUsuarios) {

        if (!usuarioSesion.esAdmin() &&
            !u.getUsuario().equalsIgnoreCase(usuarioSesion.getUsuario())) {
            continue;
        }

        ArrayList<Cultivo> cultivosU = GestionarCultivos.listarPorUsuario(u.getUsuario());
    %>

    <div class="asoc-card mb-4">

        <div class="asoc-header">
            
            <div class="asoc-avatar">
                <%= u.getUsuario().substring(0,1).toUpperCase() %>
            </div>
            
            <div>
                <div class="asoc-nombre"><%= u.getNombre() %></div>
                <div class="asoc-usuario">@<%= u.getUsuario() %></div>
            </div>
            
            <span class="asoc-badge <%= u.esAdmin() ? "asoc-badge-admin" : "asoc-badge-usuario" %>">
                <%= u.esAdmin() ? "Administrador" : "Usuario" %>
            </span>
            
            <span class="asoc-contador ms-auto">
                <%= cultivosU.size() %> cultivo<%= cultivosU.size() != 1 ? "s" : "" %>
            </span>
        </div>

        <% if (cultivosU.isEmpty()) { %>
            <div class="asoc-vacio">
                🌱 Este usuario aun no tiene cultivos registrados.
            </div>
            
        <% } else { %>
        
            <div class="row g-3 p-3">
                
            <% for (Cultivo c : cultivosU) {
                String urlImg = c.getImagenMostrar();
            %>
                <div class="col-md-4">
                    
                    <div class="asoc-cultivo-card">
                        
                        <% if (urlImg != null && !urlImg.isEmpty()) { %>
                            <img src="<%= urlImg %>"
                                 width="100%" height="120"
                                 style="object-fit:cover; border-radius:10px; margin-bottom:10px;"
                                 alt="<%= c.getTipo() %>"
                                 onerror="this.style.display='none'">
                        <% } else { %>
                            <div class="asoc-img-placeholder">🌱</div>
                        <% } %>
                        
                        <div class="asoc-cultivo-tipo"><%= c.getTipo() %></div>
                        <div class="asoc-cultivo-info">
                            📍 <%= c.getUbicacion() %><br>
                            📐 <%= c.getArea() %> ha<br>
                            📅 <%= c.getFechaSiembra() %>
                        </div>
                        
                        <div class="mt-2">
                            
                            <% if ("Activo".equals(c.getEstado())) { %>
                                <span class="badge bg-success">Activo</span>
                            <% } else { %>
                                <span class="badge bg-secondary">Finalizado</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
            </div>
        <% } %>

    </div>

    <% } %>

</div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>
