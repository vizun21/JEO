<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.jeo.common.config.TypeVal" %>

<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-12">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="user_name">이름</option>
								</select>
								<input type="search" class="form-control" id="keyword" placeholder="검색어 입력">
								<div class="input-group-append">
									<button type="button" class="btn btn-md btn-default" id="btnSearch">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5">
								<c:if test="${loginVO.user_level == TypeVal.LEVEL_COMP_ADMIN}">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" id="btnRetirement"><i class="fas fa-check"></i> 퇴직</button>
								</div>
								</c:if>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
										<th>연번</th>
										<th>사원번호</th>
										<th>직책</th>
										<th>이름</th>
										<th>핸드폰번호</th>
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

<script>
	$(function () {
		var args = {
			orderColumns: [[2, "asc"]]
			, excludeOrderColumns: [1]
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#user_yn").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/myemployee/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				user_yn: 'Y'
				, keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if ($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function (index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push("<input type='checkbox' name='tb_check_list' value='" + item.user_id + "' data-ceo_id='" + item.ceo_id + "'>");
					html.push(index + 1);
					html.push(item.user_id);
					html.push(item.user_position_name);
					html.push(item.user_name);
					html.push(item.user_mobile);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-user_id", item.user_id);
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$("input[name=tb_check_all]").prop("checked", false);
				$("input[name=tb_check_list]").on("change", function () {
					syncCheckbox("listTable");
				});

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnRetirement").on("click", function () {
		if ($("input[name=tb_check_list]:checked").length == 0) {
			alert("선택된 항목이 없습니다.");
			return false;
		}
		if (!confirm("퇴직처리하시겠습니까?")) return false;

		// 퇴직처리
		var user_id_list = [];
		$("input[name=tb_check_list]:checked").each(function () {
			user_id_list.push($(this).val());
		});

		$.ajax({
			type: "POST"
			, url: "/user/batch-retirement"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				user_id_list: user_id_list
			})
			, async: false
			, success: function (data) {
				if (data == 'success') {
					getPage();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

	});

</script>
