<%-- 
    Document   : restaurar
    Created on : 25/03/2026, 11:09:37 p. m.
    Author     : Usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Recuperar contraseña</title>

   
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    <div class="card-custom">

        <h2>Recuperar contraseña</h2>

        <p>Ingresa tu correo para recuperar tu contraseña.</p>

        <form>

            <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <input type="email" class="form-control" placeholder="ejemplo@gmail.com">
            </div>

            <div class="d-grid">
                <button class="btn btn-success">
                    Enviar
                </button>
            </div>

        </form>

        <p class="text-center mt-3">
            <a href="login.jsp">Volver al login</a>
        </p>

    </div>
</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>
