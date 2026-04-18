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
    

<%
if (session.getAttribute("usuario") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">

<div class="card-custom">

<div class="d-flex justify-content-between mb-3">

    <a href="index.jsp" class="btn btn-secondary btn-sm">
        Inicio
    </a>

    <a href="ServletCultivos?accion=listar"
       class="btn btn-success btn-sm">
       Ver Cultivos
    </a>

</div>

<h2 class="text-center">Administrar Cultivos</h2>

<p class="text-center text-muted">
    Registra nuevos cultivos agrícolas
</p>

<form action="ServletCultivos" method="post">

    <input type="hidden" name="accion" value="crear">

    <div class="mb-3">
        <label class="form-label">Tipo de cultivo</label>
        <input type="text"
               name="tipo"
               class="form-control"
               placeholder="Ej: Papa, Café..."
               required>
    </div>

    <div class="mb-3">
        <label class="form-label">Área (hectáreas)</label>
        <input type="number"
               step="0.1"
               name="area"
               class="form-control"
               required>
    </div>

    <div class="mb-3">
        <label class="form-label">Ubicación</label>
        <input type="text"
               name="ubicacion"
               class="form-control"
               placeholder="Ej: Nariño"
               required>
    </div>

    <div class="mb-3">
        <label class="form-label">Fecha de siembra</label>
        <input type="date"
               name="fechaSiembra"
               class="form-control"
               required>
    </div>

    <div class="mb-3">
        <label class="form-label">Estado del cultivo</label>

        <select name="estado" class="form-select">

            <option value="Activo">Activo</option>
            <option value="Finalizado">Finalizado</option>

        </select>
    </div>

    <div class="d-grid">
        <button type="submit" class="btn btn-success">
            Guardar Cultivo
        </button>
    </div>

</form>

</div>
</div>

<jsp:include page="lib/footer.jsp"/>

</body>
</html>