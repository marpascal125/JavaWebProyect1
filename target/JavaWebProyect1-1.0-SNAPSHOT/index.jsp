<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>
<!DOCTYPE html>

<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Inicio</title>

    
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
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">

    <div class="card-custom text-center">

        <img src="images/img1.png" class="logo" alt="Logo">

        <h2>Bienvenido, <%= usuario.getUsuario() %></h2>

        <p class="mt-3">
            Sistema de gestión de cultivos en Nariño que permite
            administrar cultivos de manera eficiente.
        </p>

        <hr>

        <div class="row mt-4">

            <div class="col-md-12 mb-3">
                <a href="ServletCultivos?accion=listar"
                   class="btn btn-success w-100">
                    Ver Cultivos
                </a>
            </div>

        </div>

        <div class="mt-4">
            <ul class="list-group">
                <li class="list-group-item">Registrar cultivos</li>
                <li class="list-group-item">Editar y eliminar cultivos</li>
                <li class="list-group-item">Filtrar por tipo y ubicación</li>
            </ul>
        </div>

    </div>

</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>