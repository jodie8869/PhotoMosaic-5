<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Album page</title>
	<link type="text/css" rel="stylesheet" href="/stylesheets/reset.css" />
	<link type="text/css" rel="stylesheet" href="/stylesheets/album.css" />
</head>

<body>
	<!-- HEADER -->
	<jsp:include page="./include/header.jsp" flush="false" />

	<section class="albums">
		<div class="positioner">
			<c:forEach var="mosaic" items="${mosaics}" varStatus="status">
				<a class="album" href="/result/${mosaic.getUrl()}">
					<img src="/images/${mosaic.getId()}/${mosaic.getFileName()}" />
				</a>
			</c:forEach>
			<div class="clear"></div>
		</div>
	</section>
</body>
</html>