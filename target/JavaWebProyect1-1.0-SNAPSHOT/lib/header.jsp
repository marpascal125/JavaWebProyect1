<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">

    <a class="navbar-brand" href="index.jsp">AgroSmart Nariño</a>

    <div class="collapse navbar-collapse">
      <ul class="navbar-nav me-auto">

        <li class="nav-item">
          <a class="nav-link" href="index.jsp">Inicio</a>
        </li>

        <%
            String usuario = (String) session.getAttribute("usuario");
        %>

        <% if (usuario == null) { %>

            
            <li class="nav-item">
              <a class="nav-link" href="login.jsp">Iniciar Sesión</a>
            </li>

            <li class="nav-item">
              <a class="nav-link" href="registrar.jsp">Registrarse</a>
            </li>

        <% } else { %>

            
            <li class="nav-item">
              <span class="nav-link">👤 <%= usuario %></span>
            </li>

            <li class="nav-item">
              <a class="nav-link" href="logout.jsp">Cerrar sesión</a>
            </li>

        <% } %>

      </ul>
    </div>

  </div>
</nav>

<hr>