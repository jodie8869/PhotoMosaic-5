<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/stylesheets/reset.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/header.css">
<link rel="stylesheet" type="text/css" href="/stylesheets/result.css">
<title>show mosaic</title>
</head>
<body>
	<article id="lightBox"></article>
	<jsp:include page="header.jsp" flush="false" />
	<aside>
		<section class="thumbnail">
			<img id="mosaic" src="/images/thumbnail.png" />
		</section>
		<section class="info">
			<ul>
				<li>
					<p>subject</p>
					<p>subject value</p>
				</li>
				<li>
					<p>comment</p>
					<p>comment value</p>
				</li>
				<li>
					<p>producer</p>
					<p>producer value</p>
				</li>
				<li>
					<p>date</p>
					<p>date value</p>
				</li>
			</ul>
		</section>
		<section class="share">
			<input type="button" value="share" />
		</section>
	</aside>
	<article id="list">
		<ul>
			<li data-list="0"><img src="/images/bobby.jpg" /></li>
			<li data-list="1"><img src="/images/baemin.jpg" /></li>
			<li data-list="2"><img src="/images/captain.jpg" /></li>
			<li data-list="3"><img src="/images/clan.png" /></li>
			<li data-list="4"><img src="/images/comment.jpg" /></li>
			<li data-list="5"><img src="/images/dog.jpg" /></li>
			<li data-list="6"><img src="/images/pio.jpg" /></li>
			<li data-list="7"><img src="/images/pitcher.jpg" /></li>
		</ul>
	</article>
	<script src="/javascripts/PhotoListSlide.js"></script>
	<script src="/javascripts/ShareTool.js"></script>
	<script src="/javascripts/PhotoLightBox.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var mosaic = document.querySelector("img#mosaic");
			var originalImages = document
					.querySelectorAll("article#list ul li img");
			var lightBox = document.querySelector("article#lightBox");

			new PhotoLightBox(lightBox, mosaic);
			//new PhotoListSlide(originalImages, lightBox);

			var sButton = document
					.querySelector("section.share input[type='button']");
			var sTool = new ShareTool();
			sTool.URL(sButton);
		});
	</script>
</body>
</html>