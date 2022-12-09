<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header"><h5 class="mb-0">문서출력</h5></div>
					<div class="card-body">
						<form id="searchForm">
							<table class="table-list table table-sm table-bordered">
								<colgroup>
									<col/>
									<col/>
									<col/>
									<col/>
									<col/>
									<col width="10%"/>
								</colgroup>
								<tr>
									<th>수리일자</th>
									<th>공종</th>
									<th>구분</th>
									<th>TAG NO.</th>
									<th>설비명</th>
									<th rowspan="4">
										<button type="button" class="btn btn-md btn-primary btn-block" id="btnPrint">
											<i class="fas fa-print"></i> 인쇄
										</button>
									</th>
								</tr>
								<tr>
									<td>
										<input type="text" class="datepicker-removable form-control" id="repair_date"
											   name="repair_date" title="수리일자" placeholder="수리일자" readonly>
									</td>
									<td>
										<select class="select2" name="construction_code"
												data-minimum-results-for-search="Infinity" style="width: 100%;">
											<option value="">공종선택</option>
											<c:forEach var="constructionType" items="${constructionTypes}"
													   varStatus="status">
												<option value="${constructionType.construction_code}">${constructionType.construction_name}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<select class="select2" name="category_code"
												data-minimum-results-for-search="Infinity" style="width: 100%;">
											<option value="">구분선택</option>
											<c:forEach var="category" items="${categories}"
													   varStatus="status">
												<option value="${category.category_code}">${category.category_name}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<input type="hidden" id="facility_tag_no" name="facility_tag_no">
										<input class="form-control" id="facility_tag_no_keyword" title="TAG NO."
											   name="facility_tag_no_keyword" data-parsley-required="true"
											   placeholder="TAG NO. 및 설비명으로 검색">
									</td>
									<td>
										<input class="form-control" id="facility_name" name="facility_name"
											   readonly="readonly">
									</td>
								</tr>
								<tr>
									<td colspan="5">
										<input type="checkbox" id="print_equipment_card" name="print_equipment_card" checked="checked">
										<label for="print_equipment_card" class="my-1">설비이력카드</label>
									</td>
								</tr>
								<tr>
									<td colspan="5">
										<input type="checkbox" id="print_repair_list" name="print_repair_list" checked="checked">
										<label for="print_repair_list" class="my-1">수리내역목록</label>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
		<%--row--%>

		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header"><h5 class="mb-0">보고서출력</h5></div>
					<div class="card-body">
						<table class="table-list table table-sm table-bordered">
							<colgroup>
								<col/>
								<col/>
								<col/>
								<col width="10%"/>
							</colgroup>
							<tr>
								<th>일자선택</th>
								<td>
									<input type="text" class="datepicker form-control" name="start_date" readonly>
								</td>
								<td>
									<input type="text" class="datepicker form-control" name="end_date" readonly>
								</td>
								<th rowspan="4">
									<button type="button" class="btn btn-md btn-primary btn-block" id="btnPrint2">
										<i class="fas fa-print"></i> 인쇄
									</button>
								</th>
							</tr>
							<tr>
								<td colspan="3">
									<input type="checkbox" id="report-cover" name="report-cover">
									<label for="report-cover" class="my-1">보고서표지</label>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<input type="checkbox" id="facility-spec-list" name="facility-spec-list">
									<label for="facility-spec-list" class="my-1">설비명세목록</label>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<input type="checkbox" id="repair-list2" name="repair-list2">
									<label for="repair-list2" class="my-1">수리내역목록</label>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		<%--row--%>
	</div>
</div>

<script>
	$.each($("#facility_tag_no_keyword"), function () {
		initAutoComplete(this);
	});

	$("#btnPrint").on("click", function () {
		if (!parsleyFormValidate("searchForm")) return false;

		var url = "<c:url value='/print/html/report1'/>"
			+ "?repair_date=" + $("#repair_date").val()
			+ "&facility_tag_no=" + $("#facility_tag_no").val()
			+ "&print_equipment_card=" + $("#print_equipment_card").is(":checked")
			+ "&print_repair_list=" + $("#print_repair_list").is(":checked");
		window.open(url, '_blank');
	});

	function initAutoComplete(obj) {
		$(obj).autocomplete({
			minLength: ($(obj).data("parsley-length") ? $(obj).data("parsley-length")[0] : 1)	// bootstrap-select 적용 후 수정
			, delay: 300
			, search: function (event) {
				if (event.keyCode == 37 || event.keyCode == 38 || event.keyCode == 39 || event.keyCode == 40) {
					event.preventDefault();
				}
			}
			, source: function (request, response) {
				$.ajax({
					type: "POST",
					url: "/facility-list/equipment/page",
					cache: false,
					dataType: "json",
					data: $("#searchForm").serialize(),
					success: function (data) {
						// loading 종료 신호보내기 위해..
						setTimeout(function () {
							response($.map(data, function (item) {
								return {
									label: '[' + item.facility_tag_no + '] ' + item.facility_name
									, value: item.facility_tag_no
									, facility_name: item.facility_name
								}
							}));
						}, 100);
					},
					error: function (xhr, status, message) {
						alertAjaxError(xhr, status, message);
						response();
					}
				});
			}
			, select: function (event, ui) {
				$("#facility_tag_no").val(ui.item.value);
				$("#facility_name").val(ui.item.facility_name);
			}
		});
	}
</script>
