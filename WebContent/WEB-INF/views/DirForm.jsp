<%-- 4(a) validar que el parámetro locale se encuentre en la solicitud
	 	de lo contrario, validar si la variable locale es vacia y asignar ese valor, 
	 	de lo contrario, asignar el valor pageContext.request.locale a la variable local 
 --%>
<%-- Escribe aquí tu código/tag --%>

<c:set var="locale" value = "${ not empty param.locale ? param.locale: not empty locale ? locale: pageContent.request.locale}" scope ="session"/>

<%-- 4(b) asignar la var locale con setLocale y scope de session --%>
<%-- Escribe aquí tu código/tag --%>
<fmt:setLocale value="${locale}" scope ="session"/>

<%-- 4(c) cargar bundle me.jmll.i18n.app en la variable appBundle --%>
<%-- Escribe aquí tu código/tag --%>
<fmt:setBundle basename="me.jmll.i18n.app" var="appBundle"/>

<html lang="${locale}">
<head>
	<%-- Importa los CSS y JS de Twitter Bootstrap --%>
	<c:import url="/WEB-INF/includes/Bootstrap.jsp"></c:import>
	<title>
		<fmt:message key="app.name" bundle="${appBundle }"/>
    </title>
</head>
<body>
	<div class="container">
      <!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <!-- App name  -->
            <a class="navbar-brand" href="${pageContext.request.contextPath}">
            		<%-- escribe aquí tu tag fmt:message para el título --%>
            		
            <fmt:message key ="app.toolbar.title" bundle="${appBundle }" />
            </a>
            <!-- /. App name  -->
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <!-- menu de Home/Inicio -->
              <li class="active"><a href="${pageContext.request.contextPath}/index.jsp">
              	<%-- escribe aquí tu tag fmt:message para el toolbar menu home --%>
              	<fmt:message key ="app.toolbar.home" bundle="${appBundle }" />
              	</a>
              </li>
              <!-- /.menu de Home/Inicio -->	
              <!-- menu de browse/explorar -->
              <li><a href="${pageContext.request.contextPath}/Lista.do">
              	<fmt:message key="app.toolbar.browse" bundle="${appBundle }" /></a>
              	</li>
              <!-- /.menu de browse/explorar -->
              <!-- menu de lenguaje -->
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" 
                role="button" aria-haspopup="true" aria-expanded="false"> 
                	<%-- escribe aquí tu tag fmt:message para el titulo del lenguaje --%>
                	<fmt:message key ="app.language.title" bundle="${appBundle }" />
                	</a>
                <span class="caret"></span></a>
                <ul class="dropdown-menu">
                
                <%-- 4(d) crear los links para el cambio de idioma con el param locale = es o en --%>
                  <li><a href="${requestScope.realURI}">
                   		<%-- escribe aquí tu tag fmt:message para el lenguaje español --%>
                  		<fmt:message key ="app.language.spanish" bundle="${appBundle }" />
                  		</a>
                  <li><a href="${requestScope.realURI}">
                  		<%-- escribe aquí tu tag fmt:message para el lenguaje ingles --%>
                   		<fmt:message key ="app.language.english" bundle="${appBundle }" />
                  		</a>
                  	  </a>
                  </li>
                </ul>
              </li>
              <!-- /.menu de lenguaje -->
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
  
		<p>
			<fmt:message key="app.browse.form.instructions" bundle="${appBundle }"/>
		</p>
		
		<%-- Form para iniciar el listado de elementos en un directorio --%>
		<form id="form-saludo" method="post" action="Lista.do" 
		role="form" data-toggle="validator">
			<div class="form-group">
				<label for="path" class="control-label">
					<fmt:message key="app.browse.form.path.label" bundle="${appBundle}"/>
				</label>
				<input type="text" name="path" id="path" 
					 placeholder="/Users/jm/Documents" 
					 class="form-control" required="true" />
			</div>
			<div class="form-group">
			<button type="submit" class="btn btn-info">
                    <span class="glyphicon glyphicon-search"></span> 
                    <fmt:message key="app.browse.form.submit" bundle="${appBundle }"/>
            </button>
			</div>
				<%-- Muestra los errores encapsulados
					 como atributos en request. --%>
				<div class="form-group">
					<c:if test="${fn:length(requestScope.errores) gt 0}">
					<div class=" alert alert-danger">
						<%-- Imprime los errores 
							 guardados en el atributo
						     errores de la request --%>
						<c:forEach items="${requestScope.errores}" var="error">
							${error}
						</c:forEach>
					</div>
					</c:if>
				</div>
			</form>
	</div>
	<%-- 1(b) Importar el archivo BootstrapJS.jsp --%>
	<%-- Escribe aquí tu código/tag --%>
	<c:import url ="/WEB-INF/includes/BootstrapJS.jsp"></c:import>
	
</body>
</html>