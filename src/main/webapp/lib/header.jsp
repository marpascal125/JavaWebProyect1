<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow">

    <div class="container-fluid">

        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="images/img1.png" width="40" style="margin-right:10px;">
            AgroSmart Nariño
        </a>

        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">

                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Inicio</a>
                </li>

                <%
                    Usuario usuario = (Usuario) session.getAttribute("usuario");
                %>

                <% if (usuario == null) { %>

                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">
                            Iniciar Sesión
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="registrar.jsp">
                            Registrarse
                        </a>
                    </li>

                <% } else { %>


                    <li class="nav-item">
                        <a class="nav-link" href="adminCultivos.jsp">
                            Registrar Cultivo
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="ServletCultivos?accion=listar">
                            Ver Cultivos
                        </a>
                    </li>

                    <li class="nav-item">
                        <span class="nav-link">
                            <%= usuario.getUsuario() %>
                        </span>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link text-warning"
                           href="ServletUsuarios?accion=logout">
                           Cerrar sesión
                        </a>
                    </li>

                <% } %>

            </ul>
        </div>

    </div>
</nav>

<hr>