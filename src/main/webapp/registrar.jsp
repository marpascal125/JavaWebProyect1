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

<jsp:include page="lib/header.jsp"/>

<div class="container">
    <div class="card-custom">
        
        <img src="images/img1.png" class="logo" alt="Logo" width="150">

        <h2>Registrar</h2>
        <br><br>

        
        <form action="ServletUsuarios" method="post">

           
            <input type="hidden" name="accion" value="registrar">

            <label>Nombre</label>
            <input type="text" name="nombre" class="form-control">

            <br>

            <label>Correo</label>
            <input type="email" name="correo" class="form-control">

            <br>

            <label>Usuario</label>
            <input type="text" name="usuario" class="form-control">

            <br>

            <label>Teléfono</label>
            <input type="tel" name="telefono" class="form-control">

            <br>

            <label>Contraseña</label>
            <input type="password" name="password" class="form-control">

            <br>

            <label>Confirmar contraseña</label>
            <input type="password" name="confirmar" class="form-control">

            <br>

            
            <button type="submit" class="btn btn-success">Registrarse</button>

        </form>

        <br>

        <a href="index.jsp" class="btn btn-success">Salir</a>

    </div>
</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>