<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%-- <%@ page isELIgnored="false" %> --%>
<link rel="stylesheet" type="text/css" href="/stylesheets/reset.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/result.css">
<title>show mosaic</title>
</head>
<body>
	<article id="lightBox" class="thumbnail"></article>
	<jsp:include page="../include/header.jsp" flush="false" />
	<div id="wrapper">
	<aside>
		<section class="thumbnail">
			<img id="mosaic" src="/images/test/test1.jpg" />
		</section>
		<section class="info">
			<ul>
				<li>
					<p>title</p> <%-- <p>${mosaic.title}</p> --%>
					<c:choose>
						<c:when test="${mosaic.title!=null}">
							<p>${mosaic.title}</p>
						</c:when>
						<c:otherwise>
							<p>test subject</p>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					<p>comment</p> <%-- <p>${mosaic.comment}</p> --%> <c:choose>
						<c:when test="${mosaic.comment!=null}">
							<p>${mosaic.comment}</p>
						</c:when>
						<c:otherwise>
							<p>test value</p>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					<p>producer</p> <c:choose>
						<c:when test="${requestScope.producer!=null}">
							<p>${requestScope.producer}</p>
						</c:when>
						<c:otherwise>
							<p>anonymous</p>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					<p>date</p> <%-- <p>${mosaic.createdDate}</p> --%> <c:choose>
						<c:when test="${mosaic.createdDate!=null}">
							<p>${mosaic.createdDate}</p>
						</c:when>
						<c:otherwise>
							<p>test value</p>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</section>
		<section class="share">
			<input type="button" value="share" />
		</section>
	</aside>
	<article id="list">
		<ul>
			<li class="container" data-list="0"><img class="original"
				src="/images/test/test2.png"></li>
			<li class="container" data-list="1"><img class="original"
				src="/images/test/test3.jpg"></li>
			<li class="container" data-list="2"><img class="original"
				src="/images/test/test4.jpg"></li>
			<li class="container" data-list="3"><img class="original"
				src="/images/test/test5.jpg"></li>
			<li class="container" data-list="4"><img class="original"
				src="/images/test/test6.png"></li>
			<li class="container" data-list="5"><img class="original"
				src="/images/test/test7.jpg"></li>
			<li class="container" data-list="6"><img class="original"
				src="/images/test/test8.jpg"></li>
			<li class="container" data-list="7"><img class="original"
				src="/images/test/pngtest1.png"></li>
			<li class="container" data-list="8"><img class="original"
				src="/images/test/pngtest2.png"></li>
			<li class="container" data-list="9"><img class="original"
				src="/images/test/pngtest3.png"></li>

			<%-- 			<c:forEach var="photo" items="${mosaic.getPhotos()}"
				varStatus="status">
				<li class="container" data-list="${status.index}"><img
					class="original" src="/images/${photo.getUniqueId()}" /></li>
			</c:forEach>
 --%>
		</ul>
	</article>
	</div>
	
	<script src="/javascripts/PhotoListSlide.js?20141112"></script>
	<script src="/javascripts/ShareTool.js?20141112"></script>
	<script src="/javascripts/PhotoLightBox.js?20141112"></script>
	<script src="/javascripts/result.js"></script>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var mosaic = document.querySelector("img#mosaic");
			var comments = document.querySelector("aside section.info ul li:nth-child(1) p:nth-child(2)").innerHTML;
			var lightBox = document.querySelector("article#lightBox");

			new PhotoLightBox(lightBox, mosaic, [ comments ], function() {
				//for ul li img.original
				var listWrapper = document.querySelector("article#list ul");
				new PhotoListSlide(listWrapper, lightBox);
			});

			var sButton = document.querySelector("section.share input[type='button']");
			var sTool = new ShareTool();
			sTool.URL(sButton);
		});
	</script>
</body>
</html>