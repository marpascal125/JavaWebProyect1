<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    
    String usuario = (String) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">

    <div class="card-custom">
        
        
        <h2>Bienvenido, <%= usuario %></h2>

        <p>Sistema de gestión de cultivos en Nariño.</p>

        <ul>
            <li>Registrar cultivos</li>
            <li>Administrar usuarios</li>
            <li>Filtrar por tipo y ubicación</li>
        </ul>

    </div>

</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>