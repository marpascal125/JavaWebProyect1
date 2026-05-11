<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>
<%@page import="Modelo.GestionarCultivos"%>
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
Usuario usuario = (Usuario) session.getAttribute("usuario");

if (usuario == null) { response.sendRedirect("login.jsp"); return; }

int totalCultivos = GestionarCultivos.listar().size();

long activos = GestionarCultivos.listar().stream()
               .filter(c -> "Activo".equals(c.getEstado())).count();
%>

<jsp:include page="lib/header.jsp"/>

<div class="container">
    <div class="card-custom text-center" style="max-width:700px;">

        <img src="images/img1.png" class="logo" alt="Logo">
        <h2>Bienvenido, <%= usuario.getUsuario() %></h2>
        <p class="text-muted mt-2">
            Gestiona tus cultivos de forma eficiente desde un solo lugar.
        </p>

        <div class="row mt-4 g-3">
            <div class="col-6">
                <div style="background:#e8f5e9; border-radius:12px; padding:16px;">
                    <div style="font-size:2rem; font-weight:700; color:#1a4a1e;">
                        <%= totalCultivos %>
                    </div>
                    <div style="font-size:0.82rem; color:#546e5a; font-weight:500;">
                        Total Cultivos
                    </div>
                </div>
            </div>
            <div class="col-6">
                <div style="background:#e8f5e9; border-radius:12px; padding:16px;">
                    <div style="font-size:2rem; font-weight:700; color:#2d6a34;">
                        <%= activos %>
                    </div>
                    <div style="font-size:0.82rem; color:#546e5a; font-weight:500;">
                        Activos
                    </div>
                </div>
            </div>
        </div>

        <div class="d-grid gap-2 mt-4">
            <a href="ServletCultivos?accion=listar" class="btn btn-success">
                Ver todos los cultivos
            </a>
            <a href="adminCultivos.jsp" class="btn btn-secondary">
                Registrar nuevo cultivo
            </a>
        </div>

        <hr style="margin: 28px 0 20px 0;">
        
        <div class="row g-3 text-center">
            <div class="col-md-4">
                <div class="feature-card">
                    <span class="feature-icon">🌾</span>
                    <h5>Registrar</h5>
                    <p>Agrega nuevos cultivos con tipo, area y ubicacion.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <span class="feature-icon">✏️</span>
                    <h5>Administrar</h5>
                    <p>Edita o elimina cultivos obsoletos facilmente.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <span class="feature-icon">🔍</span>
                    <h5>Filtrar</h5>
                    <p>Busca cultivos por tipo de planta o ubicacion.</p>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="lib/footer.jsp"/>
</body>
</html>
