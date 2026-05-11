<%-- 
    Document   : editarCultivo
    Created on : 16/04/2026, 12:48:33 a. m.
    Author     : Usuario
--%>

<%@page import="Modelo.Cultivo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
    <link rel="icon" type="image/png" href="images/img1.png">

    <title>Editar Cultivo</title>

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

Cultivo c = (Cultivo) request.getAttribute("cultivo");

if (c == null) {
    response.sendRedirect("ServletCultivos?accion=listar");
    return;
}
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    
<div class="card-custom">

    <div class="d-flex justify-content-between mb-3">
        <a href="ServletCultivos?accion=listar" class="btn btn-secondary btn-sm">Volver</a>
    </div>

    <h2 class="text-center">Editar Cultivo</h2>

    <form action="ServletCultivos" method="post">
        
        <input type="hidden" name="accion" value="actualizar">
        
        <input type="hidden" name="id" value="<%= c.getId() %>">

        <div class="mb-3">
            
            <label class="form-label">Tipo</label>
            <input type="text" name="tipo"   value="<%= c.getTipo() %>" class="form-control" required>
            
        </div>
        <div class="mb-3">
            
            <label class="form-label">Area (hectareas)</label>  
            <input type="number" step="0.1" name="area" value="<%= c.getArea() %>" class="form-control" required>
            
        </div>
            
        <div class="mb-3">
            <label class="form-label">Ubicacion</label> 
            <input type="text" name="ubicacion" value="<%= c.getUbicacion() %>" class="form-control" required>
            
        </div>
            
        <div class="mb-3">
            <label class="form-label">Fecha de siembra</label>
            <input type="date" name="fechaSiembra" value="<%= c.getFechaSiembra() %>" class="form-control" required>
        </div>
        
        <div class="mb-3">
            
            <label class="form-label">Estado</label>
            
            <select name="estado" class="form-select">
                <option value="Activo"
                    <%= "Activo".equals(c.getEstado()) ? "selected" : "" %>>
                    Activo
                </option>
                
                <option value="Finalizado"
                    <%= "Finalizado".equals(c.getEstado()) ? "selected" : "" %>>
                    Finalizado
                </option>
            </select>
        </div>
                    
        <div class="mb-3">
            
            <label class="form-label">
                Imagen del cultivo
                <span class="text-muted">(opcional)</span>
            </label>
            
            <% if (c.getImagen() != null && !c.getImagen().isEmpty()) { %>
                <div class="mb-2">
                    <img src="<%= c.getImagen() %>"
                         width="100" height="100"
                         style="object-fit:cover; border-radius:10px; border:2px solid #c8e6c9;"
                         alt="Imagen actual"
                         onerror="this.style.display='none'">
                </div>
            <% } %>
            <input type="url" name="imagen" class="form-control"
                   value="<%= c.getImagen() %>"
                   placeholder="https://ejemplo.com/imagen.jpg">
            
            <small class="text-muted">
                Dejar vacio para usar la imagen automatica segun el tipo.
            </small>
        </div>

        <div class="d-grid">
            <button class="btn btn-success">Guardar Cambios</button>
        </div>
                   
    </form>

</div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>
