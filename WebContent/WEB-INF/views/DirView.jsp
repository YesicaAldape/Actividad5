<%-- 4(a) validar que el parámetro locale se encuentre en la solicitud
	 	de lo contrario, validar si la variable locale es vacia y asignar ese valor, 
	 	de lo contrario, asignar el valor pageContext.request.locale a la variable local 
 --%>
<%-- Escribe aquí tu código/tag --%>
<c:set var="locale" value = "${not empty param.locale ? param.locale: not empty locale ? locale: pageContent.request.locale}" scope ="session"/>

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
              <li><a href="${pageContext.request.contextPath}/index.jsp">
              	<%-- escribe aquí tu tag fmt:message para el toolbar menu home --%>
              		<fmt:message key ="app.toolbar.home" bundle="${appBundle }" />
              	
              	</a>
              </li>
              <!-- /.menu de Home/Inicio -->
              <!-- menu de browse/explorar -->
              <li class="active"><a href="${pageContext.request.contextPath}/Lista.do">
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
                  <li><a href="${requestScope.realURI}?locale=es">
                  	  <%-- escribe aquí tu tag fmt:message para el lenguaje español --%>
                  	  <fmt:message key ="app.language.spanish" bundle="${appBundle }" />
                  	  </a>
                  </li>
                  <li><a href="${requestScope.realURI}?locale=en">
                  	  <%-- escribe aquí tu tag fmt:message para el lenguaje ingles --%>>
                  	  <fmt:message key ="app.language.english" bundle="${appBundle }" />
                  	  
                  	  </a>
                  </li>
                </ul>
              </li> <!-- /menu de lenguaje -->
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      <ol class="breadcrumb">
 		 <li><a href="${pageContext.request.contextPath}/index.jsp">
              <fmt:message key="app.toolbar.home" bundle="${appBundle }" />
         </a></li>
         <li><a href="${pageContext.request.contextPath}/Lista.do">
	              	<fmt:message key="app.toolbar.browse" bundle="${appBundle }" /></a>
	     </li>
 		 <li class="active">${path }</li>
	  </ol>
		<c:if test="${fn:length(requestScope.paths) lt 1}">
			<br>
			<div class="alert alert-info">
				<fmt:message key="app.browse.results.zero" bundle="${appBundle }"/>
			</div>
		</c:if>
		<%-- Si el tamaño es mayor a 0, hay al menos un elemento --%>
		<c:if test="${fn:length(requestScope.paths) gt 0}">
		<p><fmt:message key="app.browse.results.instructions" bundle="${appBundle }"/></p>
			 <%-- Inicia la creación de la tabla --%>
			<table class="table table-striped">
				<tr>
					<th><fmt:message key="app.browse.results.table.name" bundle="${appBundle }"/></th>
					<th><fmt:message key="app.browse.results.table.path" bundle="${appBundle }"/></th>
					<th><fmt:message key="app.browse.results.table.size" bundle="${appBundle }"/> (B)</th>
				</tr>
				<%--
					Se obtiene cada uno de los atributos
					 y se genera el URI para descargar el
					 archivo
				 --%>
				<c:forEach items="${requestScope.paths}" var="element">
					<tr>
						<td><a href="Download.do?archivo=${element}">${element.getFileName()}</a></td>
						<td>${element}</td>
						<td>${element.toFile().length() }</td>

					</tr>
				</c:forEach>
			</table>
		</c:if>
		<%-- Form para volver a buscar --%>
        <form action ="Admin.do">            
                <button type="submit" class="btn btn-info">
                    <span class="glyphicon glyphicon-search"></span> 
                    <fmt:message key="app.browse.results.back" bundle="${appBundle }"/>
                </button>
       </form>
	</div>
	<%-- 1(b) Importar el archivo BootstrapJS.jsp --%>
	<%-- Escribe aquí tu código/tag --%>
	<c:import url ="/WEB-INF/includes/BootstrapJS.jsp"></c:import>
</body>
</html>