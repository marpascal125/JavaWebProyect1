<%-- 
    Document   : cambiarPassword
    Created on : 7/05/2026, 6:46:17 p. m.
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Cambiar Contraseña</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<%
Usuario usuario = (Usuario) session.getAttribute("usuario");
if (usuario == null) {
    response.sendRedirect("login.jsp");
    return;
}

String resultado = request.getParameter("resultado");
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
<div class="card-custom">

    <div class="mb-3">
        <a href="index.jsp" class="btn btn-secondary btn-sm">Volver</a>
    </div>

    <h2 class="text-center">Cambiar contraseña</h2>
    <p class="text-muted text-center">
        Usuario: <strong><%= usuario.getUsuario() %></strong>
    </p>

    
    <% if ("ok".equals(resultado)) { %>
    
        <div class="alert alert-success alert-dismissible fade show">
            ✔ Contraseña actualizada correctamente.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        
    <% } else if ("errorActual".equals(resultado)) { %>
    
        <div class="alert alert-danger alert-dismissible fade show">
            ✖ La contraseña actual es incorrecta.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        
    <% } else if ("errorCoincide".equals(resultado)) { %>
    
        <div class="alert alert-danger alert-dismissible fade show">
            ✖ La nueva contraseña y su confirmación no coinciden.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    
    <% } else if ("errorCorta".equals(resultado)) { %>
    
        <div class="alert alert-danger alert-dismissible fade show">
            ✖ La nueva contraseña debe tener mínimo 4 caracteres.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    
    <% } %>

    <form action="ServletUsuarios" method="post">
        
        <input type="hidden" name="accion" value="cambiarPassword">

        <div class="mb-3">
            <label class="form-label">Contraseña actual</label>
            <input type="password" name="passwordActual" lass="form-control" required placeholder="Ingresa tu contraseña actual">
        </div>

        <div class="mb-3">
            <label class="form-label">Nueva contraseña</label>
            <input type="password" name="passwordNueva" class="form-control" required placeholder="Mínimo 4 caracteres">
        </div>

        <div class="mb-3">
            <label class="form-label">Confirmar nueva contraseña</label>
            <input type="password" name="passwordConfirmar" placeholder="Repite la nueva contraseña">
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-success">
                Guardar nueva contraseña
            </button>
        </div>
    </form>

</div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>
