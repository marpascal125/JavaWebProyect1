<%-- 
    Document   : editarUsuario
    Created on : 6/05/2026, 4:30:28 p. m.
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>

<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Editar Usuario</title>

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

Usuario u = (Usuario) request.getAttribute("usuarioEditar");
if (u == null) {
    response.sendRedirect("ServletUsuarios?accion=listarUsuarios");
    return;
}
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    
<div class="card-custom">

    <div class="d-flex justify-content-between mb-3">
        <a href="ServletUsuarios?accion=listarUsuarios" class="btn btn-secondary btn-sm">Volver</a>
    </div>

    <h2 class="text-center">Editar Usuario</h2>
    
    <p class="text-muted text-center">Modifica los datos del usuario.</p>

    <form action="ServletUsuarios" method="post">
        <input type="hidden" name="accion" value="actualizarUsuario">
        
        <input type="hidden" name="usuarioOriginal" value="<%= u.getUsuario() %>">

        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="nombre" class="form-control" value="<%= u.getNombre() %>" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Correo</label>
            <input type="email" name="correo" class="form-control" value="<%= u.getCorreo() %>" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Usuario</label>
            
            <input type="text" class="form-control" value="<%= u.getUsuario() %>" disabled>
            <small class="text-muted">El nombre de usuario no se puede cambiar.</small>
            
        </div>
            
        <div class="mb-3">
            <label class="form-label">Telefono</label>
            <input type="tel" name="telefono" class="form-control" value="<%= u.getTelefono() %>">
        </div>
        
        <div class="mb-3">
            <label class="form-label">Nueva contrasena</label>
            <input type="password" name="password" class="form-control" placeholder="Dejar vacio para no cambiar">
            <small class="text-muted">Minimo 4 caracteres.</small>
        </div>
        
        <% if (!"admin".equalsIgnoreCase(u.getUsuario())) { %>
        <div class="mb-3">
            <label class="form-label">Rol</label>
            
            <select name="rol" class="form-select">
                
                <option value="usuario" <%= "usuario".equals(u.getRol()) ? "selected" : "" %>>
                    Usuario
                </option>
                
                <option value="admin" <%= "admin".equals(u.getRol()) ? "selected" : "" %>>
                    Administrador
                </option>
            </select>
        </div>
                    
        <% } else { %>
            <input type="hidden" name="rol" value="admin">
            
            <div class="mb-3">
                <label class="form-label">Rol</label>
                <input type="text" class="form-control" value="Administrador" disabled>
                <small class="text-muted">El rol del administrador principal no se puede cambiar.</small>
            </div>
        <% } %>

        <div class="d-grid">
            <button type="submit" class="btn btn-success">
                Guardar Cambios
            </button>
        </div>
    </form>

</div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>
