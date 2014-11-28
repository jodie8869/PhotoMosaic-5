<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%-- <%@ page isELIgnored="false" %> --%>
<link rel="stylesheet" type="text/css" href="/stylesheets/reset.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/result.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/lightbox.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/Range2Range.css">
<title>show mosaic</title>
</head>
<body>
	<article id="lightBox" class="thumbnail">
		<input type="button" value="X"></input>
	</article>
		<jsp:include page="../include/header.jsp" flush="false" />

	<div id="wrapper">
		<aside>
			<section class="thumbnail">
				<c:choose>
					<c:when test="${mosaic.fileName!=null}">
						<img id="mosaic" src="/images/${mosaic.id}/${mosaic.fileName}" />
					</c:when>
					<c:otherwise>
						<img id="mosaic" src="/images/button/no_image_thumb.gif" />
					</c:otherwise>
				</c:choose>
			</section>
			<section class="info">
				<ul>
					<li>
						<p>title</p> <%-- <p>${mosaic.title}</p> --%> <c:choose>
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
				<li class="container" data-list="0" style="background-image : url(/images/test/A0.jpg)"><img class="original"
					src="/images/test/A0.jpg"></li>
				<li class="container" data-list="1" style="background-image : url(/images/test/A1.jpg)"><img class="original"
					src="/images/test/A1.jpg"></li>
				<li class="container" data-list="2" style="background-image : url(/images/test/C2.jpg)"><img class="original"
					src="/images/test/C2.jpg"></li>
				<li class="container" data-list="3" style="background-image : url(/images/test/A3.jpg)"><img class="original"
					src="/images/test/A3.jpg"></li>
				<li class="container" data-list="4" style="background-image : url(/images/test/A2.jpg)"><img class="original"
					src="/images/test/A2.jpg"></li>
				<li class="container" data-list="5" style="background-image : url(/images/test/C0.jpg)"><img class="original"
					src="/images/test/C0.jpg"></li>
				<li class="container" data-list="6" style="background-image : url(/images/test/C1.jpg)"><img class="original"
					src="/images/test/C1.jpg"></li>
				<li class="container" data-list="7" style="background-image : url(/images/test/pngtest1.png)"><img class="original"
					src="/images/test/pngtest1.png"></li>
				<li class="container" data-list="8" style="background-image : url(/images/test/pngtest2.png)"><img class="original"
					src="/images/test/pngtest2.png"></li>
				<li class="container" data-list="9" style="background-image : url(/images/test/pngtest3.png)"><img class="original"
					src="/images/test/pngtest3.png"></li>
			</ul>
		</article>
	</div>
	<script src="/javascripts/RangeBar.js"></script>
	<script src="/javascripts/PhotoListSlide.js"></script>
	<script src="/javascripts/ShareTool.js"></script>
	<script src="/javascripts/PhotoLightBox.js"></script>
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