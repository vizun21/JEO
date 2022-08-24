<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    .form-control-sm {
        height: calc(1.5125rem + 2px);
    }
	.revenue {
		background-color: rgba(0, 102, 153, 0.8);
	}
	.expenditure {
        background-color: rgba(153, 0, 0, 0.8);
	}
</style>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-2">
				<div class="card" id="side-card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-7">
								<select class="select2 form-control-sm" id="budg_year" data-minimum-results-for-search="Infinity" style="width: 100%;">
									<c:forEach var="ghm_year" items="${ghm_year_list}">
										<option value="${ghm_year.ghm_year}">${ghm_year.ghm_year}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-5">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" id="btnAdd"><i class="fas fa-plus"></i> 예산추가</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th>예산구분</th>
									</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="card-footer">
						<div>
							<span class="text-bold">세입</span>
							<input type="text" class="form-control form-control-sm" id="scroll_revenue_amount" readonly>
						</div>
						<div>
							<span class="text-bold">세출</span>
							<input type="text" class="form-control form-control-sm" id="scroll_expenditure_amount" readonly>
						</div>
						<div>
							<span class="text-bold">차액</span>
							<input type="text" class="form-control form-control-sm" id="scroll_diff_amount" readonly>
						</div>
					</div>
				</div>
			</div>
			<div class="col-10">
				<div class="card">
					<div class="card-body" style="padding: .4rem;">
						<div class="row">
							<div class="col-2 text-center">
								<span class="text-bold">예산금액</span>
							</div>
							<div class="col-10">
								<div class="row d-flex justify-content-between">
									<div class="col-4">
										<span class="text-bold">세입</span>
										<input type="text" class="form-control form-control-sm" id="revenue_amount" style="display: inline;width: 60%;" readonly>
									</div>
									<div class="col-4">
										<span class="text-bold">세출</span>
										<input type="text" class="form-control form-control-sm" id="expenditure_amount" style="display: inline;width: 60%;" readonly>
									</div>
									<div class="col-4">
										<span class="text-bold">차액</span>
										<input type="text" class="form-control form-control-sm" id="diff_amount" style="display: inline;width: 60%;" readonly>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-7"></div>
							<div class="col-md-5">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info btn-hide" id="btnRegist"><i class="far fa-save"></i> 저장</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<form id="submitForm">
									<input type="hidden" id="frm_budg_code">
									<input type="hidden" id="frm_budg_year">
									<table id="listTable2" class="table-list table table-sm table-bordered table-hover mt-2" style="font-size: 9pt;">
										<colgroup>
											<col width="3%">
											<col width="3%">
											<col width="10%">
											<col width="10%">
											<col width="10%">
											<col width="10%">
											<col width="13%">
											<col width="8%">
											<col width="7%">
											<col width="5%">
											<col width="5%">
											<col width="10%">
											<col width="3%">
											<col width="3%">
										</colgroup>
										<thead>
										<tr>
											<th>구분</th>
											<th>번호</th>
											<th>관</th>
											<th>항</th>
											<th>목</th>
											<th>예산합</th>
											<th>내용</th>
											<th>금액</th>
											<th>수량</th>
											<th>개월</th>
											<th>백분율</th>
											<th>예산액</th>
											<th>삭제</th>
											<th>추가</th>
										</tr>
										</thead>
										<tbody>
										<tr>
											<td colspan="14">예산항목을 선택해주세요.</td>
										</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info btn-hide" id="btnRegist2"><i class="far fa-save"></i> 저장</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="frmTemplate" type="text/x-handlebars-template">
	<tr class="row_{{numb}} row_{{mock_code}}" data-numb="{{numb}}" data-mock_code="{{mock_code}}">
		<td class="{{td_color}} text-white text-bold">{{gwan_io_type_name}}</td>
		<td>{{gwan_numb}}{{hang_numb}}{{mock_numb}}</td>
		<td>{{gwan_name}}</td>
		<td>{{hang_name}}</td>
		<td>
			<input type="hidden" name="frm_gwan_numb" value="{{gwan_numb}}">
			<input type="hidden" name="frm_gwan_name" value="{{gwan_name}}">
			<input type="hidden" name="frm_gwan_io_type" value="{{gwan_io_type}}">
			<input type="hidden" name="frm_gwan_io_type_name" value="{{gwan_io_type_name}}">
			<input type="hidden" name="frm_hang_numb" value="{{hang_numb}}">
			<input type="hidden" name="frm_hang_name" value="{{hang_name}}">
			<input type="hidden" name="frm_mock_code" value="{{mock_code}}">
			<input type="hidden" name="frm_mock_numb" value="{{mock_numb}}">
			<input type="hidden" name="frm_mock_name" value="{{mock_name}}">
			{{mock_name}}
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="frm_bgdt_total" readonly>
		</td>
		<td>
			<input type="hidden" name="frm_bgdt_code" value="{{bgdt_code}}">
			<input type="text" class="form-control form-control-sm" name="frm_bgdt_content" title="내용" value="{{bgdt_content}}">
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="frm_bgdt_price" title="금액" value="{{bgdt_price}}"
				   data-parsley-max="2147483647">
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="frm_bgdt_qty" title="수량" value="{{bgdt_qty}}"
				   data-parsley-max="99999.99999">
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="frm_bgdt_month" title="개월" value="{{bgdt_month}}"
				   data-parsley-max="999">
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="frm_bgdt_per" title="백분율" value="{{bgdt_per}}"
				   data-parsley-max="100">
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="frm_bgdt_amount" readonly>
		</td>
		<td>
			<button type="button" class="btn btn-xs btn-danger" onclick="deleteRow('{{numb}}');"><i class="fas fa-minus"></i> 삭제</button>
		</td>
		<td>
			<button type="button" class="btn btn-xs btn-info" onclick="addMockRow($(this).closest('tr'));"><i class="fas fa-plus"></i> 추가</button>
		</td>
	</tr>
</script>

<style>
	#side-card.fixed {
		position: fixed;
		top: 10px;
	}
</style>
<script>
	$(function () {
		var args = {
			useColvis: false
			, ordering: false
			, paging: false
			, info: false
		}
		setDatatables("listTable", args);

		getPage();

		var headerHeight = $("#side-card").offset().top;
		$(window).scroll(function () {
			var scrollHeight = $(window).scrollTop();
			if (scrollHeight > headerHeight - 10) {
				$("#side-card").width($("#side-card").width());
				$("#side-card").addClass("fixed");
			} else {
				$("#side-card").removeAttr("style", "width");
				$("#side-card").removeClass("fixed");
			}
		});
	});

	$("#budg_year").on("change", function () {
		getPage();
	});

	$("#listTable tbody").on("click", "tr", function () {
		var budg_code = $(this).data("budg_code");
		if (budg_code) getItem(budg_code);
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/budget/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				budg_year: $("#budg_year").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push(item.budg_type_name);

					var rowNode = $("#listTable").DataTable().row.add(html).node();
					$(rowNode).attr("data-budg_code", item.budg_code);
					$(rowNode).css("cursor", "pointer");
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

	$("#btnAdd").on("click", function () {
		if (!confirm($("#budg_year").val() + "년도 예산항목을 추가하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/budget/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				budg_year: $("#budg_year").val()
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
	})

	function getItem(budg_code) {
		$(".overlay").show();
		$("#btnRegist").show();
		$("#btnRegist2").show();

		$.ajax({
			type: "POST"
			, url: "/accounting/budget/item/" + budg_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({})
			, success: function (data) {
				setFrmValue(data);
				getSubList();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getSubList() {
		$.ajax({
			type: "POST"
			, url: "/accounting/budget/detail/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bsns_cate: '${businessVO.bsns_cate}'
				, budg_code: $("#frm_budg_code").val()
				, budg_year: $("#frm_budg_year").val()
				// , budg_io_type: budg_io_type
			})
			, success: function (data) {
				$("#listTable2 tbody").empty();
				if (data.length > 0) {
					$.each(data, function (index, item) {
						addRow(item);
					});
				}

				$("#listTable2").rowspan([0,1,2,3,4,5,13]);

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	var f_row_numb = 0;
	function addRow(data, index) {
		var frmTemplate = $("#frmTemplate").html();
		var frmBindTemplate = Handlebars.compile(frmTemplate);

		var html = "";
		var item = {
			numb: ++f_row_numb
			, td_color: data.gwan_io_type == "I" ? 'revenue' : 'expenditure'
			, gwan_numb: data.gwan_numb
			, gwan_name: data.gwan_name
			, gwan_io_type: data.gwan_io_type
			, gwan_io_type_name: data.gwan_io_type_name
			, hang_numb: data.hang_numb
			, hang_name: data.hang_name
			, mock_code: data.mock_code
			, mock_numb: data.mock_numb
			, mock_name: data.mock_name
			, bgdt_code: data.bgdt_code
			, bgdt_content: data.bgdt_content
			, bgdt_price: data.bgdt_price ? data.bgdt_price.number() : ""
			, bgdt_qty: data.bgdt_qty ? data.bgdt_qty.number(5) : ""
			, bgdt_month: data.bgdt_month ? data.bgdt_month.number() : ""
			, bgdt_per: data.bgdt_per ? data.bgdt_per.number(5) : ""
		}

		html += frmBindTemplate(item);

		if (isNull(index)) {
			$("#listTable2 tbody").append(html);
		} else {
			$("#listTable2 tbody tr:eq(" + index + ")").after(html);
		}

		calc(data.mock_code);

		$("#listTable2 tbody tr.row_" + f_row_numb).find("input[name=frm_bgdt_price], input[name=frm_bgdt_month]")
			.on("keyup focusout", function () {
				$(this).val($(this).val().number());
				calc($(this).closest("tr").data("mock_code"));
			});
		$("#listTable2 tbody tr.row_" + f_row_numb).find("input[name=frm_bgdt_qty], input[name=frm_bgdt_per]")
			.on("keyup focusout", function () {
				$(this).val($(this).val().number(5));
				calc($(this).closest("tr").data("mock_code"));
			});
	}

	function addMockRow(row) {
		var rowIndex = $(row).prevAll().length;
		var rowspan = Number($(row).find("td:eq(13)").attr("rowspan")) || 1;

		var data = {
			gwan_numb: $(row).find("input[name=frm_gwan_numb]").val()
			, gwan_name: $(row).find("input[name=frm_gwan_name]").val()
			, gwan_io_type: $(row).find("input[name=frm_gwan_io_type]").val()
			, gwan_io_type_name: $(row).find("input[name=frm_gwan_io_type_name]").val()
			, hang_numb: $(row).find("input[name=frm_hang_numb]").val()
			, hang_name: $(row).find("input[name=frm_hang_name]").val()
			, mock_code: $(row).find("input[name=frm_mock_code]").val()
			, mock_numb: $(row).find("input[name=frm_mock_numb]").val()
			, mock_name: $(row).find("input[name=frm_mock_name]").val()
		}
		addRow(data, rowIndex + rowspan - 1);

		$("#listTable2").rowspan([0,1,2,3,4,5,13]);
	}

	function deleteRow(numb) {
		var mock_code = $("#listTable2 tbody tr.row_" + numb).data("mock_code");
		if ($("#listTable2 tbody tr.row_" + mock_code).length == 1) {
			alert("첫행은 삭제 불가합니다.");
			return false;
		}

		var row = $("#listTable2 tbody tr.row_" + numb).remove();
		calc($(row).data("mock_code"));

		var bgdt_code = $(row).find("input[name=frm_bgdt_code]").val();
		if (isNotNull(bgdt_code)) {	// 데이터 삭제 목록 추가
			$("#submitForm").append("<input type='hidden' name='frm_delete_bgdt_code' value='" + bgdt_code + "'>");
		}

		$("#listTable2").rowspan([0,1,2,3,4,5,13]);
	}

	function calc(mock_code) {
		var bgdt_total = 0;
		$("#listTable2 tbody tr.row_" + mock_code).each(function () {
			var bgdt_price = $(this).find("input[name=frm_bgdt_price]").val();
			var bgdt_qty = $(this).find("input[name=frm_bgdt_qty]").val();
			var bgdt_month = $(this).find("input[name=frm_bgdt_month]").val();
			var bgdt_per = $(this).find("input[name=frm_bgdt_per]").val() / 100;
			var bgdt_amount = Math.round(bgdt_price * bgdt_qty * bgdt_month * bgdt_per);	// 예산액 반올림
			$(this).find("input[name=frm_bgdt_amount]").val(bgdt_amount.comma());

			// 예산합 계산
			bgdt_total += bgdt_amount;
		});
		$("#listTable2 tbody tr.row_" + mock_code).find("input[name=frm_bgdt_total]").val(bgdt_total.comma());

		// 세입/세출합 및 차액 계산
		var revenue_amount = 0;
		var expenditure_amount = 0;
		$("#listTable2 tbody tr").each(function () {
			var gwan_io_type = $(this).find("input[name=frm_gwan_io_type]").val();
			var bgdt_amount = parseInt($(this).find("input[name=frm_bgdt_amount]").val().removeComma());
			revenue_amount += gwan_io_type == "I" ? bgdt_amount : 0;
			expenditure_amount += gwan_io_type == "O" ? bgdt_amount : 0;
		});
		$("#revenue_amount").val(revenue_amount.comma());
		$("#expenditure_amount").val(expenditure_amount.comma());
		$("#diff_amount").val((revenue_amount - expenditure_amount).comma());
		$("#scroll_revenue_amount").val(revenue_amount.comma());
		$("#scroll_expenditure_amount").val(expenditure_amount.comma());
		$("#scroll_diff_amount").val((revenue_amount - expenditure_amount).comma());
	}

	$("#btnRegist, #btnRegist2").on("click", function () {
		$("#listTable2 tbody tr").each(function () {
			var check_input = [];
			check_input.push($(this).find("input[name=frm_bgdt_content]"));
			check_input.push($(this).find("input[name=frm_bgdt_price]"));
			check_input.push($(this).find("input[name=frm_bgdt_qty]"));
			check_input.push($(this).find("input[name=frm_bgdt_month]"));
			check_input.push($(this).find("input[name=frm_bgdt_per]"));

			// 내용/금액/수량/개월/백분율 중 하나라도 입력값이 있으면 전체입력체크하기 위해 data-parsley-required true로 설정
			if ($(check_input[0]).val() || $(check_input[1]).val() || $(check_input[2]).val() || $(check_input[3]).val() || $(check_input[4]).val()) {
				$(check_input).each(function (index, input) {
					$(input).attr("data-parsley-required", true);
				});
			} else {	// 하나도 입력되지 않았으면 data-parsley-required false로 설정
				$(check_input).each(function (index, input) {
					$(input).attr("data-parsley-required", false);
				});
			}
		})

		if (!parsleyFormValidate("submitForm")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		var bgdt_code_list = [];
		var mock_code_list = [];
		var bgdt_content_list = [];
		var bgdt_price_list = [];
		var bgdt_qty_list = [];
		var bgdt_month_list = [];
		var bgdt_per_list = [];

		$("#listTable2 tbody tr").each(function () {
			if ($(this).find("input[name=frm_bgdt_content]").attr("data-parsley-required") == 'true' || $(this).find("input[name=frm_bgdt_code]").val() != "") {
				bgdt_code_list.push($(this).find("input[name=frm_bgdt_code]").val());
				mock_code_list.push($(this).find("input[name=frm_mock_code]").val());
				bgdt_content_list.push($(this).find("input[name=frm_bgdt_content]").val());
				bgdt_price_list.push($(this).find("input[name=frm_bgdt_price]").val());
				bgdt_qty_list.push($(this).find("input[name=frm_bgdt_qty]").val());
				bgdt_month_list.push($(this).find("input[name=frm_bgdt_month]").val());
				bgdt_per_list.push($(this).find("input[name=frm_bgdt_per]").val());
			}
		});

		var delete_bgdt_code_list = [];
		$.each($("input[name=frm_delete_bgdt_code]"), function () {
			delete_bgdt_code_list.push($(this).val());
		});

		$.ajax({
			type: "POST"
			, url: "/accounting/budget/detail/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				budg_code: $("#frm_budg_code").val()
				, bgdt_code_list: bgdt_code_list
				, mock_code_list: mock_code_list
				, bgdt_content_list: bgdt_content_list
				, bgdt_price_list: bgdt_price_list
				, bgdt_qty_list: bgdt_qty_list
				, bgdt_month_list: bgdt_month_list
				, bgdt_per_list: bgdt_per_list
				, delete_bgdt_code_list: delete_bgdt_code_list
			})
			, success: function (data) {
				if (data == 'success') {
					getPage();
					getItem($("#frm_budg_code").val());
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

</script>
