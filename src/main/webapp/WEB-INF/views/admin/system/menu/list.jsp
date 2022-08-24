<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    ul, #menuTree {list-style-type: none;}
    #menuTree {margin: 0;padding: 0;}
    .caret {
        cursor: pointer;
        -webkit-user-select: none; /* Safari 3.1+ */
        -moz-user-select: none; /* Firefox 2+ */
        -ms-user-select: none; /* IE 10+ */
    }
    .caret::before {
        content: "\25B6";
        color: black;
        display: inline-block;
        margin-right: 6px;
        pointer-events: all;
    }
    .caret-down::before {
        -ms-transform: rotate(90deg); /* IE 9 */
        -webkit-transform: rotate(90deg); /* Safari */'
    	transform: rotate(90deg);
        pointer-events: all;
    }
    .nested {display: none;}
    .active {display: block;}

	#btnAddRootMenu {
		position: absolute;
		right: 10px;
		bottom: 10px;
	}
</style>

<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-5 col-sm-5">
				<div class="card card-info card-tabs">
					<div class="card-header p-0 pt-1">
						<ul class="nav nav-tabs" id="menu-level-tab" role="tablist">
							<c:forEach var="root_menu" items="${root_menu_list}" varStatus="status">
								<li class="nav-item">
									<a class="nav-link" data-toggle="pill" role="tab" onclick="javascript:setRootMenuInfo('${root_menu.menu_code}', '${root_menu.menu_level}', '${root_menu.cddt_name}');">
											${root_menu.cddt_name}
									</a>
								</li>
							</c:forEach>
							<c:if test="${not empty not_add_root_level_list}">
								<button type="button" class="btn btn-xs btn-default" id="btnAddRootMenu"><i class="fas fa-plus-circle"></i> 루트메뉴추가</button>
							</c:if>
						</ul>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-12">
								<ul id="menuTree">
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-7 col-sm-7">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-12">
								<input type="hidden" id="frm_menu_code">
								<input type="hidden" id="frm_menu_level">
								<table id="dataTable" class="table-form table table-sm table-bordered">
									<colgroup>
										<col width="30%">
										<col width="70%">
									</colgroup>
									<tr>
										<th>메뉴명</th>
										<td><span id="frm_menu_name"></span></td>
									</tr>
								</table>
								<table id="listTable" class="table-list table table-sm table-bordered table-hover">
									<colgroup>
										<col width="10%">
										<col width="25%">
										<col width="55%">
										<col width="10%">
									</colgroup>
									<thead>
									<tr>
										<th>순서</th>
										<th>메뉴명</th>
										<th>메뉴URL</th>
										<th><button type="button" class="btn btn-xs btn-info" id="btnAdd"><i class="fas fa-plus-circle"></i> 추가</button></th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="rootModal" tabindex="-1" role="dialog" aria-labelledby="rootModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="rootModalLabel">루트메뉴추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<table id="listTable2" class="table-list table table-sm table-bordered table-hover">
					<colgroup>
						<col width="30%">
						<col width="55%">
						<col width="15%">
					</colgroup>
					<thead>
					<tr>
						<th>메뉴레벨</th>
						<th>메뉴명</th>
						<th></th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="na_root_menu" items="${not_add_root_level_list}" varStatus="status">
						<tr>
							<td>${na_root_menu.cddt_val}</td>
							<td>${na_root_menu.cddt_name}</td>
							<td><button type="button" class="btn btn-xs btn-default" onclick="rootMenuRegist(${na_root_menu.cddt_val});"><i class="fas fa-plus-circle"></i> 루트메뉴추가</button></td>
						</tr>
					</tbody>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="listModal" tabindex="-1" role="dialog" aria-labelledby="listModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="listModalLabel">메뉴추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<table id="listTable3" class="table-list table table-sm table-bordered table-hover">
					<colgroup>
						<col width="30%">
						<col width="55%">
						<col width="15%">
					</colgroup>
					<thead>
					<tr>
						<th>페이지명</th>
						<th>페이지URL</th>
						<th></th>
					</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var args = {
			hideColumns: []
			, orderColumns: []
			, excludeOrderColumns: []
			, ordering: false
			, responsive: false
			, paging: false
			, info: false
		}
		setDatatables("listTable", args);
		setDatatables("listTable3", args);

		$("#listTable").sortable({
			handle: ".handle"
			, items: ".sort"
			, helper: function (e, ui) {
				// tr 너비유지
				ui.children().each(function () {
					$(this).width($(this).width());
				});
				return ui;
			}
			, update: function (event, ui) {
				// 순서변경
				var menu_code = $("#frm_menu_code").val();
				var child_menu_code_list = [];
				$("#listTable tbody tr.sort").each(function (index, item) {
					child_menu_code_list.push($(this).data("menu_code"));
				});

				$.ajax({
					type: "POST"
					, url: "/admin/system/menu/sort"
					, headers: {"Content-Type": "application/json"}
					, dataType: "text"
					, data: JSON.stringify({
						high_menu_code: menu_code
						, menu_code_list: child_menu_code_list
					})
					, success: function (data) {
						var menu_level = $("#frm_menu_level").val();
						getPage(menu_level);
						getItem(menu_code, menu_level);
					}
					, error: function (request, status, error) {
						alertAjaxError(request, status, error);
					}
				});
			}
		});
	});

	$("#btnAddRootMenu").on("click", function () {
		$("#rootModal").modal("show");
	});

	function rootMenuRegist(menu_level) {
		$.ajax({
			type: "POST"
			, url: "/admin/system/menu/rootRegist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				menu_level: menu_level
			})
			, success: function (data) {
				window.location.reload();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function setRootMenuInfo(menu_code, menu_level, menu_name) {
		getPage(menu_level);
		getItem(menu_code, menu_level, menu_name);
	}

	function getPage(menu_level) {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/system/menu/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				menu_level: menu_level ? menu_level : $("#frm_menu_level").val()
			})
			, success: function (data) {
				var html = "";
				// DEPTH 1
				data.forEach(function (menu, index) {
					if (menu.menu_depth == 1) {
						html += "<li>";
						if (menu.has_child) {
							html += "<span class='caret caret-down'></span>";
						}
						html += "<a href=\"javascript:getItem('" + menu.menu_code + "', '" + menu.menu_level + "')\">" + menu.menu_name + "</a>" +
								"<ul class='nested active'>";
						// DEPTH 2
						data.forEach(function (menu2, index) {
							if (menu2.menu_depth == 2 && menu2.high_menu_code == menu.menu_code) {
								html += "<li>";
								if (menu2.has_child) {
									html += "<span class='caret caret-down'></span>";
								}
								html += "<a href=\"javascript:getItem('" + menu2.menu_code + "', '" + menu.menu_level + "')\">" + menu2.menu_name + "</a>" +
									"<ul class='nested active'>";
								// DEPTH 3
								data.forEach(function (menu3, index) {
									if (menu3.menu_depth == 3 && menu3.high_menu_code == menu2.menu_code) {
										html += "<li>" + menu3.menu_name + "</li>";
									}
								});
								html += "</ul></li>";
							}
						});
						html += "</ul></li>";
					}
				});
				$("#menuTree").html(html);

				var toggler = $(".caret");

				for (var i = 0; i < toggler.length; i++) {
					toggler[i].addEventListener("click", function() {
						this.parentElement.querySelector(".nested").classList.toggle("active");
						this.classList.toggle("caret-down");
					});
				}

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getSubList(menu_code, menu_level) {
		$.ajax({
			type: "POST"
			, url: "/admin/system/menu/subList"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				menu_level: menu_level
				, high_menu_code: menu_code
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("<div class='handle'>" + (index + 1) + "</div>");
					html.push(item.menu_name);
					html.push("<div class='text-left'>" + item.menu_url + "</div>");
					html.push("<button type='button' class='btn btn-xs btn-danger' onclick=\"menuDelete('" + item.menu_code + "')\"><i class='fas fa-minus-circle'></i> 삭제</button>");

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).addClass('sort');
					$(rowNode).attr("data-menu_code", item.menu_code);
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getItem(menu_code, menu_level, menu_name) {
		$.ajax({
			type: "POST"
			, url: "/admin/system/menu/item/" + menu_code + "/" + menu_level
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setFrmValue(data);
				$("#frm_menu_name").html(menu_name ? menu_name : data.menu_name);
				getSubList(menu_code, menu_level);
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnAdd").on("click", function () {
		$("#listModal").modal("show");

		$.ajax({
			type: "POST"
			, url: "/admin/system/page/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				high_menu_code: $("#frm_menu_code").val()
				, menu_level: $("#frm_menu_level").val()
				, page_yn: 'Y'
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable3")) {
					$("#listTable3").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push(item.page_name);
					html.push(item.page_url);
					html.push("<button type='button' class='btn btn-xs btn-info' onclick=\"menuRegist('" + item.page_code + "')\"><i class='fas fa-plus'></i> 추가</button>");

					$("#listTable3").DataTable().row.add(html).node();
				});

				$("#listTable3").DataTable().draw(false);
				$("#listTable3").DataTable().columns.adjust().draw();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function menuRegist(page_code) {
		if (!confirm("추가하시겠습니까?")) return false;

		var high_menu_code = $("#frm_menu_code").val() == '' ? null : $("#frm_menu_code").val()
		$.ajax({
			type: "POST"
			, url: "/admin/system/menu/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				high_menu_code: high_menu_code
				, menu_code: page_code
				, menu_level: $("#frm_menu_level").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#listModal").modal("hide");
					getPage();
					getItem($("#frm_menu_code").val(), $("#frm_menu_level").val());
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function menuDelete(menu_code) {
		if (!confirm("삭제하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/admin/system/menu/delete"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				menu_code: menu_code
				, menu_level: $("#frm_menu_level").val()
			})
			, success: function (data) {
				if (data == 'success') {
					$("#listModal").modal("hide");
					getPage();
					getItem($("#frm_menu_code").val(), $("#frm_menu_level").val());
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}
</script>