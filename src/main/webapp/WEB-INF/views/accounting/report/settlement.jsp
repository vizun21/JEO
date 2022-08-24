<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-5">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default"
											onclick='datatablesButtonTrigger({tableID:"listTable", extend:"excel"});'><i
											class="far fa-file-excel"></i> 엑셀
									</button>
									<button type="button" class="btn btn-sm btn-default"
											onclick='datatablesButtonTrigger({tableID:"listTable", extend:"print"});'><i
											class="fas fa-print"></i> 인쇄
									</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover"
									   style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>
										<%-- dtr-control 위치 --%>
										<th>년도</th>
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
								<th>상태</th>
								<td>
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
						<table id="listTable2" class="table-list table table-sm table-bordered table-hover mt-2"
							   style="font-size: 10pt;">
							<thead>
							<tr>
								<th>구분</th>
								<th>계정코드</th>
								<th>결산금액</th>
								<th>비고</th>
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

<!-- Modal -->
<div class="modal fade" id="formModal" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">결산내용</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm">
					<input type="hidden" id="pop_repo_code">
					<input type="hidden" id="pop_repo_year">
					<table id="listTable3" class="table-list table table-sm table-bordered table-hover mb-0"
						   style="font-size: 10pt;">
						<thead>
						<tr>
							<th>구분</th>
							<th>계정코드</th>
							<th>결산금액</th>
							<th>비고</th>
						</tr>
						</thead>
						<tbody></tbody>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnRegist">저장</button>
			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="popTemplate" type="text/x-handlebars-template">
	<tr class="row_{{numb}}">
		<td>{{gb}}</td>
		<td>{{cd}}</td>
		<td class="text-right">{{cscnn}}</td>
		<td>
			<input type="hidden" name="pop_gb" value="{{gb}}">
			<input type="hidden" name="pop_cd" value="{{cd}}">
			<input type="hidden" name="pop_cscnn" value="{{cscnn}}">
			<input type="text" class="form-control form-control-sm" name="pop_rmk">
		</td>
	</tr>
</script>

<script>
	$(function () {
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex - 2, maxIndex - 1, maxIndex]
			, excludeOrderColumns: [1, 2, 3, 4, 5, 6, 7]
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
			, url: "/accounting/report/settlement/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: $("#year").val()
			})
			, success: function (data) {
				if ($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function (index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.ghm_year + "년");

					html.push("<button type='button' class='btn btn-sm btn-danger' onclick=\"getData('" + item.repo_code + "', '" + item.ghm_year + "')\">" + (item.is_reported == 'N' ? "전송" : "재전송") + "</button>");

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
				var list = xmlDoc.getElementsByTagName("STR");
				$.each(list, function (index, item) {
					var GB = $(item)[0].getElementsByTagName("GB")[0].childNodes[0].nodeValue;
					var CD = $(item)[0].getElementsByTagName("CD")[0].childNodes[0].nodeValue;
					var CSCNN = $(item)[0].getElementsByTagName("CSCNN")[0].childNodes[0].nodeValue;
					var RMK = $(item)[0].getElementsByTagName("RMK")[0].childNodes[0] ? $(item)[0].getElementsByTagName("RMK")[0].childNodes[0].nodeValue : "";
					var html = "<tr>";
					html += "<td>" + GB + "</td>";
					html += "<td>" + CD + "</td>";
					html += "<td class='text-right'>" + CSCNN.comma() + "</td>";
					html += "<td class='text-left'><pre class='p-0 mb-0'>" + RMK + "</pre></td>";
					html += "</tr>";
					$("#listTable2 tbody").append(html);
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getData(repo_code, repo_year) {
		$("#formModal").modal("show");

		$("#pop_repo_code").val(repo_code);
		$("#pop_repo_year").val(repo_year);

		$.ajax({
			type: "POST"
			, url: "/accounting/report/settlement/data"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				repo_year: repo_year
			})
			, success: function (data) {
				$("#listTable3 tbody").empty();

				$.each(data, function (index, item) {
					addRow(item);
				});

			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	var f_row_numb = 0;

	function addRow(data, index) {
		var template = $("#popTemplate").html();
		var bindTemplate = Handlebars.compile(template);

		var html = "";
		var item = {
			numb: ++f_row_numb
			, gb: data.gb
			, cd: data.cd
			, cscnn: data.cscnn.comma()
		}

		html += bindTemplate(item);
		$("#listTable3 tbody").append(html);
	}

	$("#btnRegist").on("click", function () {
		var repo_code = $("#pop_repo_code").val() === "undefined" ? null : $("#pop_repo_code").val();
		var repo_year = $("#pop_repo_year").val();

		if (isNull(repo_code)) {
			if (!confirm("전송하시겠습니까?")) return false;
		} else {
			if (!confirm("이미 제출한 이력이 있습니다. 덮어쓰시겠습니까?")) return false;
		}

		$(".overlay").show();

		var gb_list = [];
		var cd_list = [];
		var cscnn_list = [];
		var rmk_list = [];
		$.each($("#listTable3 tbody tr"), function () {
			gb_list.push($(this).find("input[name=pop_gb]").val());
			cd_list.push($(this).find("input[name=pop_cd]").val());
			cscnn_list.push($(this).find("input[name=pop_cscnn]").val().removeComma());
			rmk_list.push($(this).find("input[name=pop_rmk]").val());
		});

		$.ajax({
			type: "POST"
			, url: "/accounting/report/settlement/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				repo_code: repo_code
				, repo_year: repo_year
				, gb_list: gb_list
				, cd_list: cd_list
				, cscnn_list: cscnn_list
				, rmk_list: rmk_list
			})
			, success: function (data) {
				$(".overlay").hide();

				if (data == 'success') {
					$("#formModal").modal("hide");
					getPage();
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

</script>