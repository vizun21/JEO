<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xl-2 col-md-3 col-sm-4">
				<div class="form-group">
					<select class="select2" id="year" data-minimum-results-for-search="Infinity" style="width: 100%;">
						<c:forEach var="ghm_year" items="${ghm_year_list}">
							<option value="${ghm_year.ghm_year}">${ghm_year.ghm_year}</option>
						</c:forEach>
					</select>
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
							<div class="col-md-5"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>년</th>
										<th>월</th>
										<th>마감잔액</th>
										<th>마감등록일</th>
										<th>마감등록자</th>
										<th>마감</th>
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
		var maxIndex = $("#listTable th").length - 1
		var args = {
			orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#year").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/deadline/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				year: $("#year").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				var deadline = true;
				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.dead_year + "년");
					html.push(item.dead_month + "월");
					html.push(item.dead_balance.comma());
					html.push(item.dead_reg_date);
					html.push(item.dead_reg_user_name);
					if (item.is_closed == 'Y') {
				<c:choose>
					<c:when test="${adminVO ne null}">
						html.push("<button type='button' class='btn btn-sm btn-danger' onclick=\"deadlineDelete('" + item.dead_code + "')\">마감취소</button>");
					</c:when>
					<c:otherwise>
						html.push("마감완료");
					</c:otherwise>
				</c:choose>
					} else {
						if (deadline) {
							deadline = false;
							html.push("<button type='button' class='btn btn-sm btn-info' onclick=\"deadlineRegist('" + item.dead_year + "', '" + item.dead_month + "')\">마감등록</button>");
						} else {
							html.push("");
						}
					}

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function deadlineRegist(year, month) {
		if (!confirm("마감처리하시겠습니까?")) return false;

		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/deadline/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				dead_year: year
				, dead_month: month
			})
			, success: function (data) {
				if (data == 'success') {
					getPage();
				} else if (data == '은행거래없음') {
					/* 신규등록자여서 은행거래내역이 없는 경우 등록할 수 있도록 함 */
					if (confirm('은행거래내역이 없습니다.\n거래내역잔액으로 마감등록하시겠습니까?')) {
						$.ajax({
							type: "POST"
							, url: "/accounting/deadline/regist/tranBalance"
							, headers: {"Content-Type": "application/json"}
							, dataType: "text"
							, data: JSON.stringify({
								dead_year: year
								, dead_month: month
							})
							, success: function (data) {
								if (data == 'success') {
									getPage();
								} else {
									alert(data);
								}
							}
							, error: function (request, status, error) {
								alertAjaxError(request, status, error);
							}
						});
					}
				} else {
					alert(data);
				}

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function deadlineDelete(dead_code) {
		if (!confirm("마감취소하시겠습니까?")) return false;

		$(".overlay").show();

		$.ajax({
			type: "DELETE"
			, url: "/accounting/deadline/delete/" + dead_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({})
			, success: function (data) {
				$(".overlay").hide();

				if (data == 'success') {
					getPage();
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
