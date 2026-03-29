<%-- 
    Document   : listUsuarios
    Created on : 26/03/2026, 7:36:19 a. m.
    Author     : INTERNET
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Cultivo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Lista de Usuarios</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>

<jsp:include page="lib/header.jsp"/>

<%
    
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    
    ArrayList<Cultivo> lista = (ArrayList<Cultivo>) request.getAttribute("lista");
%>

<div class="container">
    <div class="card-custom">

        <h2>Lista de Cultivos</h2>

        
        <form class="mb-3">
            <input type="text" class="form-control mb-2" placeholder="Filtrar por tipo">
            <input type="text" class="form-control mb-2" placeholder="Filtrar por ubicación">
            <button class="btn btn-success">Buscar</button>
        </form>

        
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Tipo</th>
                    <th>Área</th>
                    <th>Ubicación</th>
                </tr>
            </thead>
            <tbody>

            <%
                if (lista != null && !lista.isEmpty()) {
                    int i = 1;
                    for (Cultivo c : lista) {
            %>

                <tr>
                    <td><%= i++ %></td>
                    <td><%= c.getTipo() %></td>
                    <td><%= c.getArea() %></td>
                    <td><%= c.getUbicacion() %></td>
                </tr>

            <%
                    }
                } else {
            %>

                <tr>
                    <td colspan="4" class="text-center">No hay cultivos registrados</td>
                </tr>

            <%
                }
            %>

            </tbody>
        </table>

    </div>
</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>