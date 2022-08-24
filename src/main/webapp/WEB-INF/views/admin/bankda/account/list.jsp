<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-xl-2 col-md-3 col-sm-4">
				<div class="form-group">
					<select class="select2" id="bank_code" style="width: 100%;">
						<option value="">[은행선택]</option>
					<c:forEach var="bank" items="${bank_list}">
						<option value="${bank.bank_code}" data-bank_web_yn="${bank.bank_web_yn}">${bank.bank_name}</option>
					</c:forEach>
					</select>
				</div>
			</div>
			<div class="col-xl-10 col-md-9 col-sm-8">
				<div class="form-group">
					<div class="input-group input-group-md">
						<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
							<option value="acnt_name">계좌명(별칭)</option>
							<option value="acnt_numb">계좌번호</option>
							<option value="comp_name">사업자명</option>
							<option value="bsns_name">사업명</option>
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
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" onclick="window.open('/admin/bankda/account/popup/list', '_blank', 'width=1200, height=800, scrollbars=yes');">뱅크다 전체계좌 조회</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
										<th>사업자코드</th>
										<th>구분</th>
										<th>사업자번호</th>
										<th>사업자명</th>
										<th>사업명</th>
										<th>은행</th>
										<th>계좌명(별칭)</th>
										<th>계좌번호</th>
										<th>계좌상태</th>
										<th>계좌조회결과</th>
										<th>최근조회일시</th>
										<th>등록일</th>
										<th>수정일</th>
										<th>최종수정자</th>
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
	</div>
</div>

<script>
	$(function () {
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex-4, maxIndex-3, maxIndex-2]
			, orderColumns: [[1, "asc"]]
			, excludeOrderColumns: []
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#bank_code").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/bankda/account/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bank_code: $("#bank_code").val()
				, keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.comp_code);
					html.push(item.comp_type_name);
					html.push(item.comp_reg_numb);
					html.push(item.comp_name);
					html.push(item.bsns_name);
					html.push(item.bank_name);
					html.push(item.acnt_name);
					html.push(item.acnt_numb);
					if (item.act_tag == "F") {
						html.push("<div class='text-danger text-bold'>" + item.act_tag_name + "</div>");
					} else {
						html.push(item.act_tag_name);
					}
					html.push("<div class='text-danger text-bold'>" + item.act_status + "</div>");
					html.push(item.last_scraping_dtm);
					html.push(item.acnt_reg_date);
					html.push(item.acnt_mod_date);
					html.push(item.acnt_mod_user_name);
					html.push(item.acnt_note);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-acnt_code", item.acnt_code);
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

</script>