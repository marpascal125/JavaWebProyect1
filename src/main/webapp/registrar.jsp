<%-- 
    Document   : registrar
    Created on : 25/03/2026, 8:12:04 p. m.
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title> Registrar </title>

    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>
   

<%
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">

    <div class="card-custom">

        <img src="images/img1.png" class="logo" alt="Logo">

        <h2 class="text-center">Registro de Usuario</h2>

        <%
            String error = request.getParameter("error");

            if ("1".equals(error)) {
        %>
            <div class="alert alert-danger text-center">
                Debes completar todos los campos obligatorios
            </div>
        <%
            } else if ("2".equals(error)) {
        %>
            <div class="alert alert-danger text-center">
                Las contraseñas no coinciden
            </div>
        <%
            } else if ("3".equals(error)) {
        %>
            <div class="alert alert-danger text-center">
                El usuario ya existe
            </div>
        <%
            }
        %>

        <form action="ServletUsuarios" method="post">

            <input type="hidden" name="accion" value="registrar">

            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Correo</label>
                <input type="email" name="correo" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Usuario</label>
                <input type="text" name="usuario" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Teléfono</label>
                <input type="tel" name="telefono" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Confirmar contraseña</label>
                <input type="password" name="confirmar" class="form-control" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-success">
                    Registrarse
                </button>
            </div>

        </form>

        <div class="text-center mt-3">
            <a href="login.jsp">¿Ya tienes cuenta? Inicia sesión</a>
        </div>

    </div>

</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>