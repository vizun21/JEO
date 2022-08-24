<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@include file="../include/header.jsp"%>
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">

	<!-- Navbar -->
	<nav class="main-header navbar navbar-expand navbar-white navbar-light">
		<!-- Left navbar links -->
		<ul class="navbar-nav">
			<li class="nav-item">
				<a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
			</li>
		</ul>

		<!-- Right navbar links -->
		<ul class="navbar-nav ml-auto">

			<!-- 사용자전환 -->
			<c:if test="${adminVO ne null}">
				<div class="d-inline mt-1 ml-3">
					<div class="input-group input-group-sm">
						<div class="input-group-append">
							<button type="button" class="btn btn-default" id="btnUserTransform"><i class="fas fa-exchange-alt"></i> 사용자전환</button>
						</div>
					</div>
				</div>
			</c:if>

			<!-- 사업선택 -->
			<div class="business-box d-inline mt-1 ml-3">
				<div class="input-group input-group-sm">
					<input type="text" class="form-control form-control-navbar text-center" value="${businessVO.bsns_name}" disabled>
					<div class="input-group-append">
						<button type="button" class="btn btn-default" id="btnTransform"><i class="fas fa-sync"></i> 사업전환</button>
					</div>
				</div>
				<div class="business-select-box" style="display: none;">
					<ul>
			<c:choose>
				<c:when test="${fn:length(businessList) > 0}">
					<c:forEach var="business" items="${businessList}">
						<li onclick="transformBusiness('${business.bsns_code}')">${business.bsns_name}</li>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<li style="cursor: text;">전환할 사업이 없습니다.<br><small><a href="/mybusiness" target="_blank">사업추가하기</a></small></li>
				</c:otherwise>
			</c:choose>
					</ul>
				</div>
			</div>

			<!-- Messages Dropdown Menu -->
			<li class="nav-item dropdown">
				<a class="nav-link" data-toggle="dropdown" href="#">
					<i class="far fa-comments"></i>
					<span class="badge badge-danger navbar-badge">3</span>
				</a>
				<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
					<a href="#" class="dropdown-item">
						<!-- Message Start -->
						<div class="media">
							<img src="/resources/img/user1-128x128.jpg" alt="User Avatar" class="img-size-50 mr-3 img-circle">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									Brad Diesel
									<span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
								</h3>
								<p class="text-sm">Call me whenever you can...</p>
								<p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
							</div>
						</div>
						<!-- Message End -->
					</a>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item">
						<!-- Message Start -->
						<div class="media">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									John Pierce
									<span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
								</h3>
								<p class="text-sm">I got your message bro</p>
								<p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
							</div>
						</div>
						<!-- Message End -->
					</a>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item">
						<!-- Message Start -->
						<div class="media">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									Nora Silvester
									<span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
								</h3>
								<p class="text-sm">The subject goes here</p>
								<p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
							</div>
						</div>
						<!-- Message End -->
					</a>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
				</div>
			</li>
			<!-- Notifications Dropdown Menu -->
			<li class="nav-item dropdown">
				<a class="nav-link" data-toggle="dropdown" href="#">
					<i class="far fa-bell"></i>
					<span class="badge badge-warning navbar-badge">15</span>
				</a>
				<div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
					<span class="dropdown-header">15 Notifications</span>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item">
						<i class="fas fa-envelope mr-2"></i> 4 new messages
						<span class="float-right text-muted text-sm">3 mins</span>
					</a>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item">
						<i class="fas fa-users mr-2"></i> 8 friend requests
						<span class="float-right text-muted text-sm">12 hours</span>
					</a>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item">
						<i class="fas fa-file mr-2"></i> 3 new reports
						<span class="float-right text-muted text-sm">2 days</span>
					</a>
					<div class="dropdown-divider"></div>
					<a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link" data-toggle="dropdown" href="#">
					<i class="far fa-user"></i>
				</a>
				<div class="dropdown-menu dropdown-menu-md dropdown-menu-right">
					<a href="/mybusiness" class="dropdown-item">
						<div class="media">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									사업관리
									<span class="float-right text-sm text-secondary"><i class="fas fa-briefcase"></i></span>
								</h3>
							</div>
						</div>
					</a>
					<div class="dropdown-divider"></div>
					<a href="/myemployee" class="dropdown-item">
						<div class="media">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									근로자관리
									<span class="float-right text-sm text-secondary"><i class="fas fa-users"></i></span>
								</h3>
							</div>
						</div>
					</a>
					<div class="dropdown-divider"></div>
					<a href="/mypage" class="dropdown-item">
						<div class="media">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									계정관리
									<span class="float-right text-sm text-secondary"><i class="fas fa-user-edit"></i></span>
								</h3>
							</div>
						</div>
					</a>
					<div class="dropdown-divider"></div>
					<a href="/user/logout" class="dropdown-item">
						<div class="media">
							<div class="media-body">
								<h3 class="dropdown-item-title">
									로그아웃
									<span class="float-right text-sm text-secondary"><i class="fas fa-sign-out-alt"></i></span>
								</h3>
							</div>
						</div>
					</a>
				</div>
			</li>
		</ul>
	</nav>

	<!-- Main Sidebar Container -->
	<aside class="main-sidebar sidebar-dark-info elevation-2">
		<!-- Brand Logo -->
		<a href="/" class="brand-link text-center">
			<span class="brand-text font-weight-bold">JEO</span>
		</a>

		<!-- Sidebar -->
		<div class="sidebar">
			<!-- Sidebar user panel (optional) -->
			<div class="user-panel mt-3 pb-3 mb-3 d-flex">
				<div class="info">
					<a href="/mypage" class="d-block">
						<div class="text-light">${loginVO.comp_name}</div>
						<span style="font-size: 10pt;">${loginVO.user_name}</span>
					</a>
				</div>
			</div>

			<!-- Sidebar Menu -->
			<nav class="mt-2">
				<ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
					<c:forEach var="side_menu" items="${menu}" varStatus="status">
						<c:if test="${side_menu.menu_depth eq 1}">
							<li class="nav-item">
								<a href="${side_menu.menu_url}" class="text-bold nav-link nav-first-link">
									<c:choose>
										<c:when test="${side_menu.menu_icon != ''}"><i class="${side_menu.menu_icon} nav-icon"></i></c:when>
										<c:otherwise><i class="far fa-circle nav-icon"></i></c:otherwise>
									</c:choose>
									<p>${side_menu.menu_name}</p>
								</a>
								<c:if test="${side_menu.has_child eq 1}">
									<ul class="nav nav-treeview">
										<c:forEach var="side_menu2" items="${menu}" varStatus="status">
											<c:if test="${side_menu2.menu_depth eq 2 and side_menu2.high_menu_code eq side_menu.menu_code}">
												<li class="nav-item">
													<a href="${side_menu2.menu_url}" class="text-bold nav-link nav-second-link">
														<c:choose>
															<c:when test="${side_menu2.menu_icon != ''}"><i class="${side_menu2.menu_icon} nav-icon"></i></c:when>
															<c:otherwise><i class="far fa-circle nav-icon"></i></c:otherwise>
														</c:choose>
														<p>${side_menu2.menu_name}</p>
													</a>
													<c:if test="${side_menu2.has_child eq 1}">
														<ul class="nav nav-treeview">
															<c:forEach var="side_menu3" items="${menu}" varStatus="status">
																<c:if test="${side_menu3.menu_depth eq 3 and side_menu3.high_menu_code eq side_menu2.menu_code}">
																	<li class="nav-item">
																		<a href="${side_menu3.menu_url}" class="text-bold nav-link nav-third-link">
																			<c:choose>
																				<c:when test="${side_menu3.menu_icon != ''}"><i class="${side_menu3.menu_icon} nav-icon"></i></c:when>
																				<c:otherwise><i class="far fa-circle nav-icon"></i></c:otherwise>
																			</c:choose>
																			<p>${side_menu3.menu_name}</p>
																		</a>
																	</li>
																</c:if>
															</c:forEach>
														</ul>
													</c:if>
												</li>
											</c:if>
										</c:forEach>
									</ul>
								</c:if>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</nav>
		</div>
	</aside>

	<div class="content-wrapper">
		<div class="content-header">
			<div class="container-fluid">
				<div class="row mb-2">
					<div class="col-sm-6">
						<h1 class="m-0" id="content_title">${menu_name}</h1>
					</div>
					<div class="col-sm-6">
						<ol class="breadcrumb float-sm-right">
							<c:if test="${breadcrumb[0].menu_name1 != null}">
								<li class="breadcrumb-item active">${breadcrumb[0].menu_name1}</li>
							</c:if>
							<c:if test="${breadcrumb[0].menu_name2 != null}">
								<li class="breadcrumb-item active">${breadcrumb[0].menu_name2}</li>
							</c:if>
							<c:if test="${breadcrumb[0].menu_name3 != null}">
								<li class="breadcrumb-item active">${breadcrumb[0].menu_name3}</li>
							</c:if>
						</ol>
					</div>
				</div>
			</div>
		</div>

		<div class="overlay">
<%--			<div class="overlay-icon">--%>
				<i class="overlay-icon fas fa-sync-alt fa-spin fa-5x"></i>
<%--			</div>--%>
		</div>
		<decorator:body></decorator:body>

	</div>

	<!-- Control Sidebar -->
	<aside class="control-sidebar control-sidebar-dark">
		<!-- Control sidebar content goes here -->
		<div class="p-3">
			<h5>Title</h5>
			<p>Sidebar content</p>
		</div>
	</aside>

	<footer class="main-footer">
		<div class="float-right d-none d-sm-inline"></div>
		<strong>Copyright &copy; 2020-<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> <a href="http://lmsystems.co.kr/">Esoft.corp</a>.</strong> All rights reserved.
	</footer>

</div>

<%@include file="../include/script.jsp"%>

</body>

</html>
