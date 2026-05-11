<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Modelo.Usuario"%>
<nav class="navbar navbar-expand-lg shadow">
    <div class="container-fluid px-4">

        <a class="navbar-brand d-flex align-items-center gap-2" href="index.jsp">
            <img src="images/img1.png" width="38" height="38" class="navbar-logo">
            AgroSmart Nariño
        </a>

        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <%
                    Usuario usuario = (Usuario) session.getAttribute("usuario");
                %>
                <li class="nav-item">
                    <a class="nav-link nav-pill" href="index.jsp">Inicio</a>
                </li>
                <% if (usuario == null) { %>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="login.jsp">Iniciar sesión</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="registrar.jsp">Registrarse</a>
                    </li>
                <% } else if (usuario.esAdmin()) { %>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="ServletUsuarios?accion=listarUsuarios">
                            Usuarios
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="ServletCultivos?accion=listar">
                            Ver cultivos
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="cultivosUsuario.jsp">
                            Cultivos por usuario
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="adminCultivos.jsp">
                            Registrar cultivo
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="ServletCultivos?accion=listar">
                            Ver cultivos
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link nav-pill" href="cultivosUsuario.jsp">
                            Mis cultivos
                        </a>
                    </li>
                <% } %>
            </ul>

            <%-- Menú desplegable del usuario --%>
            <% if (usuario != null) { %>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item dropdown">

                    <a class="nav-link dropdown-toggle nav-user-toggle p-0"
                       href="#" role="button"
                       data-bs-toggle="dropdown"
                       aria-expanded="false">
                        <div class="nav-user-wrapper">
                            <div class="nav-avatar">
                                <%= usuario.getUsuario().substring(0,1).toUpperCase() %>
                            </div>
                            <div class="nav-user-text">
                                <% if (usuario.esAdmin()) { %>
                                    <span class="nav-role admin">ADMINISTRADOR</span>
                                <% } else { %>
                                    <span class="nav-role user">USUARIO</span>
                                <% } %>
                                <span class="nav-username"><%= usuario.getUsuario() %></span>
                            </div>
                            <i class="bi bi-chevron-down nav-chevron"></i>
                        </div>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end nav-dropdown p-0">

                        <%-- Encabezado del perfil --%>
                        <li class="nav-dropdown-header">
                            <div class="dropdown-avatar">
                                <%= usuario.getUsuario().substring(0,1).toUpperCase() %>
                            </div>
                            <div>
                                <div class="dd-name"><%= usuario.getNombre() %></div>
                                <div class="dd-correo"><%= usuario.getCorreo() %></div>
                                <% if (usuario.esAdmin()) { %>
                                    <span class="dd-badge admin">Administrador</span>
                                <% } else { %>
                                    <span class="dd-badge user">Usuario</span>
                                <% } %>
                            </div>
                        </li>

                        <li><div class="dd-sep"></div></li>

                        <%-- Cambiar contraseña --%>
                        <li>
                            <a class="dropdown-item nav-item-option" href="cambiarPassword.jsp">
                                <div class="dd-item-icon option">🔑</div>
                                Cambiar contraseña
                            </a>
                        </li>

                        <li><div class="dd-sep"></div></li>

                        <%-- Cerrar sesión --%>
                        <li>
                            <a class="dropdown-item nav-item-logout"
                               href="ServletUsuarios?accion=logout">
                                <div class="dd-item-icon logout">🚪</div>
                                Cerrar sesión
                            </a>
                        </li>

                    </ul>
                </li>
            </ul>
            <% } %>

        </div>
    </div>
</nav>
