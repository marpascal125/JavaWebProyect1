<%-- 
    Document   : adminCultivos
    Created on : 26/03/2026, 7:34:14 a. m.
    Author     : INTERNET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Administrar Cultivos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    <div class="card-custom">

       <h2>Registrar Cultivo</h2>

        <form action="ServletCultivos" method="post">

            <label>Tipo</label>
            <input type="text" name="tipo" class="form-control">

            <label>Área</label>
            <input type="number" name="area" class="form-control">

            <label>Ubicación</label>
            <input type="text" name="ubicacion" class="form-control">

            <button class="btn btn-success">Guardar</button>

        </form>

    </div>
</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>

