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
	<jsp:include page="header.jsp" flush="false" />
	<aside>
		<section class="thumbnail">
			<img id="mosaic" src="/images/${mosaic.fileName}" />
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
	
<%-- 	<c:forEach var="result" items="${resultList}" varStatus="status">
<tr>
	<td align="center" class="listtd"><c:out value="${status.count}"/></td>
	<td align="center" class="listtd"><a href="javascripｔ:fn_egov_select('<c:out  value="${result.id}"/>')"><c:out value="${result.id}"/></a></td>
	<td align="left" class="listtd"><c:out value="${result.name}"/> </td>
	<td align="center" class="listtd"><c:out value="${result.useYn}"/> </td>
	<td align="center" class="listtd"><c:out value="${result.description}"/> </td>
	<td align="center" class="listtd"><c:out value="${result.regUser}"/> </td>
</tr>
</c:forEach>
 --%>	
	
		<ul>
			<c:forEach var="photo" items="${mosaic.getPhotos()}" varStatus="status">
				<li class="container" data-list="${status.index}">
					<img class="original" src="/images/${photo.getOriginalFileName()}" />
				</li>
			</c:forEach>
		
<!-- 			<li class="container" data-list="0"><img class="original"
				src="/images/bobby.jpg" /></li>
			<li class="container" data-list="1"><img class="original"
				src="/images/baemin.jpg" /></li>
			<li class="container" data-list="2"><img class="original"
				src="/images/captain.jpg" /></li>
			<li class="container" data-list="3"><img class="original"
				src="/images/clan.png" /></li>
			<li class="container" data-list="4"><img class="original"
				src="/images/comment.jpg" /></li>
			<li class="container" data-list="5"><img class="original"
				src="/images/dog.jpg" /></li>
			<li class="container" data-list="6"><img class="original"
				src="/images/test.png" /></li>
			<li class="container" data-list="7"><img class="original"
				src="/images/pitcher.jpg" /></li>
 -->		</ul>
	</article>
	<script src="/javascripts/PhotoListSlide.js?20141112"></script>
	<script src="/javascripts/ShareTool.js?20141112"></script>
	<script src="/javascripts/PhotoLightBox.js?20141112"></script>
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