<%-- 
    Document   : listCultivos
    Created on : 26/03/2026, 7:35:33 a. m.
    Author     : INTERNET
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Modelo.Cultivo"%>
<%@page import="Modelo.Usuario"%>
<%@page import="Modelo.GestionarUsuarios"%>
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
Usuario usuarioSesion    = (Usuario) session.getAttribute("usuario");
ArrayList<Cultivo> lista = (ArrayList<Cultivo>) request.getAttribute("lista");
String mensajeReporte    = (String) request.getAttribute("mensajeReporte");
String idStr             = request.getParameter("id");
Integer idFiltro         = null;

try {
    if (idStr != null && !idStr.isEmpty()) idFiltro = Integer.parseInt(idStr);
} catch (Exception e) { idFiltro = null; }
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    
<div class="card-custom card-wide">

    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        
        <a href="index.jsp" class="btn btn-secondary btn-sm">Inicio</a>
        
        <div class="d-flex gap-2">
            
            <a href="ServletCultivos?accion=listar" class="btn btn-success btn-sm">
                Actualizar lista
            </a>
            
            <button type="button" class="btn btn-primary btn-sm"
                    data-bs-toggle="modal" data-bs-target="#modalReporte">
                Generar reporte
            </button>
        </div>
    </div>

    <% if (mensajeReporte != null && !mensajeReporte.isEmpty()) {
        boolean esError = mensajeReporte.startsWith("Error"); %>
        
    <div class="alert <%= esError ? "alert-danger" : "alert-success" %> alert-dismissible fade show">
        <strong><%= esError ? "Error:" : "Éxito:" %></strong> <%= mensajeReporte %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
        
    <% } %>

    <h2 class="text-center">Lista de Cultivos</h2>

    <form action="ServletCultivos" method="get" class="row g-2 mt-3">
        <input type="hidden" name="accion" value="filtrar">
        
        <div class="col-md-3">
            <input type="number" name="id" class="form-control" placeholder="Buscar por ID">
        </div>
        
        <div class="col-md-3">
            <input type="text" name="tipo" class="form-control" placeholder="Filtrar por tipo">
        </div>
        
        <div class="col-md-3">
            <input type="text" name="ubicacion" class="form-control" placeholder="Filtrar por ubicación">
        </div>
        
        <div class="col-md-3 d-grid">
            <button class="btn btn-success">Filtrar</button>
        </div>
        
    </form>

    <table class="table table-bordered table-hover mt-4 text-center">
        
    <colgroup><col style="width:80px"></colgroup>
    
    <thead>
        
    <tr>
        <th>Imagen</th>
        <th>ID</th>
        <th>Tipo</th>
        <th>Área (ha)</th>
        <th>Ubicación</th>
        <th>Fecha Siembra</th>
        <th>Estado</th>
        <th>Registrado por</th>
        <th>Acciones</th>
    </tr>
    
    </thead>
    
    <tbody>
        
    <%
    boolean hayResultados = false;
    
    if (lista != null && !lista.isEmpty()) {
        for (Cultivo c : lista) {
            if (idFiltro != null && c.getId() != idFiltro) continue;
            hayResultados = true;
            String urlImagen = c.getImagenMostrar();
    %>
    
    <tr>
        <td>
            <% if (urlImagen != null && !urlImagen.isEmpty()) { %>
                <img src="<%= urlImagen %>"
                     width="55" height="55"
                     style="object-fit:cover; border-radius:10px; border:2px solid #e8f5e9; cursor:zoom-in;"
                     alt="<%= c.getTipo() %>"
                     onerror="this.style.display='none';this.nextElementSibling.style.display='block'">
                <span style="display:none;" class="cultivo-sin-imagen">🌱</span>
                
            <% } else { %>
                <span class="cultivo-sin-imagen">🌱</span>
            <% } %>
            
        </td>
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
        
        <td><%= c.getUsuarioRegistro().isEmpty() ? "-" : c.getUsuarioRegistro() %></td>
        
        <td>
            
            <% if (usuarioSesion.esAdmin() ||
                   usuarioSesion.getUsuario().equalsIgnoreCase(c.getUsuarioRegistro())) { %>
                   
            <div class="d-flex justify-content-center gap-2">
                
                <a href="ServletCultivos?accion=editar&id=<%= c.getId() %>" class="btn btn-warning btn-sm">Editar</a>
                <a href="ServletCultivos?accion=eliminar&id=<%= c.getId() %>"  class="btn btn-danger btn-sm" onclick="return confirm('¿Eliminar este cultivo?')">Eliminar</a>
                
            </div>
                
            <% } else { %>
                <span class="text-muted" style="font-size:0.8rem;">Sin permisos</span>
            <% } %>
            
        </td>
    </tr>
    <%
        }
    }
    if (!hayResultados) { %>
    
    <tr>
        <td colspan="9">No hay cultivos registrados o no coinciden con el filtro.</td>
    </tr>
    
    <% } %>
    </tbody>
    </table>

</div>
</div>

<div class="modal fade" id="modalReporte" tabindex="-1" aria-hidden="true">
    
    <div class="modal-dialog modal-dialog-centered">
        
        <div class="modal-content" style="border-radius:16px; border:none;">

            <div class="modal-header" style="background:#1a4a1e; border-radius:16px 16px 0 0;">
                
                <h5 class="modal-title" style="color:#ffffff; font-family:'Playfair Display',serif;">
                    Opciones de reporte
                </h5>
                
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>

            <form action="ServletCultivos" method="get">
                
                <input type="hidden" name="accion" value="reporte">

                <div class="modal-body p-4">

                    <div class="mb-4">
                        
                        <label class="form-label fw-bold">Incluir cultivos:</label>
                        
                        <div class="d-flex flex-column gap-2">
                            
                            <div class="form-check">
                                
                                <input class="form-check-input" type="radio"
                                       name="estadoFiltro" value="Todos"
                                       id="todos" checked>
                                
                                <label class="form-check-label" for="todos">
                                    Todos los cultivos
                                </label>
                                
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio"
                                       name="estadoFiltro" value="Activo"
                                       id="activos">
                                
                                <label class="form-check-label" for="activos">
                                    Solo activos
                                </label>
                                
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio"
                                       name="estadoFiltro" value="Finalizado"
                                       id="finalizados">
                                
                                <label class="form-check-label" for="finalizados">
                                    Solo finalizados
                                </label>
                                
                            </div>
                        </div>
                    </div>

                    <% if (usuarioSesion.esAdmin()) { %>
                    <div class="mb-2">
                        <label class="form-label fw-bold">Filtrar por usuario:</label>
                        <select name="usuarioFiltro" class="form-select">
                            <option value="">Todos los usuarios</option>
                            <% for (Usuario u : GestionarUsuarios.listar()) { %>
                                <option value="<%= u.getUsuario() %>">
                                    <%= u.getUsuario() %>
                                </option>
                            <% } %>
                        </select>
                    </div>
                        
                    <% } else { %>
                        <input type="hidden" name="usuarioFiltro"
                               value="<%= usuarioSesion.getUsuario() %>">
                        
                        <div class="alert alert-success py-2">
                            El reporte incluirá únicamente tus cultivos.
                        </div>
                        
                    <% } %>

                </div>

                <div class="modal-footer" style="border-top:1px solid #e8f5e9;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    
                    <button type="submit" class="btn btn-primary">
                        Descargar reporte
                    </button>
                    
                </div>

            </form>
        </div>
    </div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>
