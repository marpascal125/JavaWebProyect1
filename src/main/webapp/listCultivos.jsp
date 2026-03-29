<%-- 
    Document   : listCultivos
    Created on : 26/03/2026, 7:35:33 a. m.
    Author     : INTERNET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Lista de Cultivos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

    
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    <div class="card-custom">

        <h2>Lista de Cultivos</h2>

        <form>
            <input type="text" placeholder="Filtrar por tipo">
            <input type="text" placeholder="Filtrar por ubicación">
            <button>Buscar</button>
        </form>

        <table>
            <tr>
                <th>ID</th>
                <th>Tipo</th>
                <th>Área</th>
                <th>Ubicación</th>
                <th>Fecha</th>
            </tr>
            <tr>
                <td>1</td>
                <td>Papa</td>
                <td>2 AH</td>
                <td>Nariño</td>
                <td>2026-03-01</td>
            </tr>
        </table>

    </div>
</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>

