<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/stylesheets/reset.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/result.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/lightbox.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/Range2Range.css">
<title>show mosaic</title>
</head>
<body>
	<div id="lightBoxWrapper">
		<article class="lightbox represent show">
			<input type="button" value="X" class="showingHandler">
			<section class="info">
				<h1>
					<c:choose>
						<c:when test="${mosaic.title!=null}">
							${mosaic.title}
						</c:when>
						<c:otherwise>
							cannot find title
						</c:otherwise>
					</c:choose>
				</h1>
				<c:choose>
					<c:when test="${mosaic.fileName!=null}">
						<img class="mosaic" src="/images/${mosaic.id}/${mosaic.fileName}" />
					</c:when>
					<c:otherwise>
						<img class="mosaic" src="/images/button/no_image_thumb.gif" />
					</c:otherwise>
				</c:choose>
			</section>
		</article>
		
		<article class="lightbox slide hide">
			<input type="button" value="X" class="showingHandler">
			<section>
				<div class="previous preset">
					<div><img class="original" src=""/></div>
				</div>
				<div class="currnet">
					<div><img class="original" src=""/></div>
				</div>
				<div class="next preset">
					<div><img class="original" src=""/></div>
				</div>
			</section>
			<nav>
				<div></div>
				<input type="range" min="0" max="${fn:length(mosaic.getPhotos())-1}">
			</nav>
		</article>
	
	</div>
	<div id="header">
	<jsp:include page="../include/header.jsp" flush="false" />
	</div>
	<div id="wrapper">
		<aside>
			<section class="title">
			<c:choose>
				<c:when test="${mosaic.title!=null}">
					<p>${mosaic.title}</p>
				</c:when>
				<c:otherwise>
					<p>cannot find title</p>
				</c:otherwise>
			</c:choose>
			</section>
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
						<c:choose>
							<c:when test="${mosaic.comment!=null}">
								<p>${mosaic.comment}</p>
							</c:when>
							<c:otherwise>
								<p>cannot find comment</p>
							</c:otherwise>
						</c:choose>
					</li>
					<li>
						<c:choose>
							<c:when test="${requestScope.producer!=null}">
								<p>${requestScope.producer}</p>
							</c:when>
							<c:otherwise>
								<p>anonymous</p>
							</c:otherwise>
						</c:choose>
					</li>
					<li>
						<c:choose>
							<c:when test="${mosaic.createdDate!=null}">
								<p>${mosaic.createdDate}</p>
							</c:when>
							<c:otherwise>
								<p>cannot find date</p>
							</c:otherwise>
						</c:choose>
					</li>
				</ul>
			</section>
 		</aside>
		<article id="list">
			<ul>
				<li class="container" data-list="0"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="1"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="2"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="3"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="4"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="5"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="6"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
				<li class="container" data-list="7"  style="background-image: url(/images/test/A0.jpg);">
					<img class="original" src="/images/test/A0.jpg" />
				</li>
			</ul>
		</article>
	</div>

	<script src="/javascripts/test/LightBox.js"></script>
	<script src="/javascripts/test/RepresentPhoto.js"></script>	
	<script src="/javascripts/test/PhotoSlide.js"></script>	
	<!-- <script src="/javascripts/RangeBar.js"></script> -->
	<!-- <script src="/javascripts/PhotoListSlide.js"></script> -->
	<!-- <script src="/javascripts/ShareTool.js"></script> -->
	<!-- <script src="/javascripts/PhotoLightBox.js"></script> -->
	<!-- <script src="/javascripts/result.js"></script> -->
	

	<script>
		document.addEventListener("DOMContentLoaded", function() {
/* 			var mosaic = document.querySelector("img#mosaic");
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
 */		});
	</script>
</body>
</html>