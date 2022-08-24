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
			<div class="col-5">
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
										<th>년도</th>
										<th>예산구분</th>
										<th>전송</th>
										<th>상태</th>
										<th>전송데이터조회</th>
										<th>등록일</th>
										<th>수정일</th>
										<th>최종수정자</th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-7">
				<div class="card" id="card-data" style="display: none;">
					<div class="card-body">
						<table id="dataTable" class="table-form table table-sm table-bordered">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<tr>
								<th>회계연도</th>
								<td>
									<span id="frm_repo_year"></span>
								</td>
								<th>예산구분</th>
								<td>
									<span id="frm_budg_type_name"></span>
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td colspan="3">
									<span id="frm_repo_result_status"></span>
								</td>
							</tr>
							<tr>
								<th>결과메시지</th>
								<td colspan="3">
									<span id="frm_repo_result_msg"></span>
								</td>
							</tr>
						</table>
						<table id="listTable2" class="table-list table table-sm table-bordered table-hover mt-2" style="font-size: 10pt;">
							<thead>
							<tr>
								<th>구분</th>
								<th>계정코드</th>
								<th>예산금액</th>
								<th>산출기초</th>
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

<script>
	$(function () {
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex-2, maxIndex-1, maxIndex]
			, excludeOrderColumns: [1,2,3,4,5,6,7,8]
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#year").on("change", function () {
		getPage();
	});

	function getPage() {
		$("#card-data").hide();
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/report/budget/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				budg_year: $("#year").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.budg_year + "년");
					html.push(item.budg_type_name);

					html.push("<button type='button' class='btn btn-sm btn-danger' onclick=\"reportRegist('" + item.repo_code + "', '" + item.budg_year + "', '" + item.budg_type + "')\">"+ (item.is_reported == 'N' ? "전송" : "재전송") +"</button>");

					html.push("<div class='text-bold text-" + item.repo_result_status_color + "'>" + item.repo_result_status + "</div>");

					if (item.is_reported == 'Y') {
						html.push("<button type='button' class='btn btn-sm btn-danger' onclick=\"getItem('" + item.repo_code + "')\">전송데이터조회</button>");
					} else {
						html.push("");
					}
					html.push(item.repo_reg_date);
					html.push(item.repo_mod_date);
					html.push(item.repo_mod_user_name);

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

	function getItem(repo_code) {
		$("#card-data").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/report/item/" + repo_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({})
			, success: function (data) {
				setFrmValue(data);

				var xmlText = data.repo_content;
				var xmlParser = new DOMParser();
				var xmlDoc = xmlParser.parseFromString(xmlText, "text/xml");

				$("#listTable2 tbody").empty();
				var list = xmlDoc.getElementsByTagName("BGTR");
				$.each(list, function (index, item) {
					var GB = $(item)[0].getElementsByTagName("GB")[0].childNodes[0].nodeValue;
					var CD = $(item)[0].getElementsByTagName("CD")[0].childNodes[0].nodeValue;
					var BGTAMT = $(item)[0].getElementsByTagName("BGTAMT")[0].childNodes[0].nodeValue;
					var COMPUTBSIS = $(item)[0].getElementsByTagName("COMPUTBSIS")[0].childNodes[0] ? $(item)[0].getElementsByTagName("COMPUTBSIS")[0].childNodes[0].nodeValue : "";
					var html = "<tr>";
					html += "<td>" + GB + "</td>";
					html += "<td>" + CD + "</td>";
					html += "<td class='text-right'>" + BGTAMT.comma() + "</td>";
					html += "<td class='text-left'><pre class='p-0 mb-0'>" + COMPUTBSIS + "</pre></td>";
					html += "</tr>";
					$("#listTable2 tbody").append(html);
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function reportRegist(repo_code, repo_year, repo_type) {
		if (repo_code === "undefined") {
			if (!confirm("전송하시겠습니까?")) return false;
		} else {
			if (!confirm("이미 제출한 이력이 있습니다. 덮어쓰시겠습니까?")) return false;
		}

		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/report/budget/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				repo_code: repo_code === "undefined" ? null : repo_code
				, repo_year: repo_year
				, repo_type: repo_type
			})
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