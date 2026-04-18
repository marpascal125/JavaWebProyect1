<%-- 
    Document   : listCultivos
    Created on : 26/03/2026, 7:35:33 a. m.
    Author     : INTERNET
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Cultivo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Lista de cultivos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

   
    <link rel="stylesheet" href="styles/style.css">

</head>
<body>


<%
if (session.getAttribute("usuario") == null) {
    response.sendRedirect("login.jsp");
    return;
}

ArrayList<Cultivo> lista = (ArrayList<Cultivo>) request.getAttribute("lista");

String idStr = request.getParameter("id");
Integer idFiltro = null;

try {
    if (idStr != null && !idStr.isEmpty()) {
        idFiltro = Integer.parseInt(idStr);
    }
} catch (Exception e) {
    idFiltro = null;
}
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">

<div class="card-custom card-wide">

<div class="d-flex justify-content-between mb-3">

    <a href="index.jsp" class="btn btn-secondary btn-sm">
        Inicio
    </a>

    <a href="ServletCultivos?accion=listar"
       class="btn btn-success btn-sm">
        Actualizar lista
    </a>

</div>

<h2 class="text-center">Lista de Cultivos</h2>

<form action="ServletCultivos" method="get" class="row g-2 mt-3">

    <input type="hidden" name="accion" value="filtrar">

    <div class="col-md-3">
        <input type="number" name="id" class="form-control"
               placeholder="Buscar por ID">
    </div>

    <div class="col-md-3">
        <input type="text" name="tipo" class="form-control"
               placeholder="Filtrar por tipo">
    </div>

    <div class="col-md-3">
        <input type="text" name="ubicacion" class="form-control"
               placeholder="Filtrar por ubicación">
    </div>

    <div class="col-md-3 d-grid">
        <button class="btn btn-success">
            Filtrar
        </button>
    </div>

</form>

<table class="table table-bordered table-hover mt-4 text-center">

<thead class="table-success">
<tr>
    <th>ID</th>
    <th>Tipo</th>
    <th>Área</th>
    <th>Ubicación</th>
    <th>Fecha Siembra</th>
    <th>Estado</th>
    <th>Acciones</th>
</tr>
</thead>

<tbody>

<%
boolean hayResultados = false;

if (lista != null && !lista.isEmpty()) {

    for (Cultivo c : lista) {

        if (idFiltro != null && c.getId() != idFiltro) {
            continue;
        }

        hayResultados = true;
%>

<tr>

    <td><%= c.getId() %></td>
    <td><%= c.getTipo() %></td>
    <td><%= c.getArea() %></td>
    <td><%= c.getUbicacion() %></td>
    <td><%= c.getFechaSiembra() %></td>

    <td>
        <% if ("Activo".equals(c.getEstado())) { %>
            <span class="badge bg-success">Activo</span>
        <% } else { %>
            <span class="badge bg-secondary">Finalizado</span>
        <% } %>
    </td>

    <td>
        <div class="d-flex justify-content-center gap-2">

            <a href="ServletCultivos?accion=editar&id=<%= c.getId() %>"
               class="btn btn-warning btn-sm">
                Editar
            </a>

            <a href="ServletCultivos?accion=eliminar&id=<%= c.getId() %>"
               class="btn btn-danger btn-sm"
               onclick="return confirm('¿Eliminar este cultivo?')">
                Eliminar
            </a>

        </div>
    </td>

</tr>

<%
    }
}

if (!hayResultados) {
%>

<tr>
    <td colspan="7">
        No hay cultivos registrados o no coinciden con el filtro
    </td>
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