<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#listTable, #listTable2 {
        font-size: 10pt;
	}
	#listTable .form-control-sm, #listTable .select2-selection__rendered {
        font-size: 10pt;
	}
    #listTable .form-control-sm, #listTable select.form-control-sm~.select2-container--default .select2-selection--single {
    	height: calc(1.75rem);
    }
</style>
<div class="content">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-12">
				<select class="select2 form-control-sm" id="year" data-minimum-results-for-search="Infinity" style="width: 180px;">
					<c:set var="year"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /></c:set>
					<c:forEach var="y" begin="2000" end="${year + 1}">
						<option value="${y}" ${y eq year ? 'selected' : ''}>${y}년</option>
					</c:forEach>
				</select>
				<select class="select2 form-control-sm" id="month" data-minimum-results-for-search="Infinity" style="width: 180px;">
					<c:set var="month"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="MM" /></c:set>
					<c:forEach var="m" begin="1" end="12">
						<option value="${m}" ${m eq month ? 'selected' : ''}>${m}월</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<span class="text-bold mr-2">은행거래내역 </span>
						<select class="select2 form-control-sm" id="acnt_code" data-minimum-results-for-search="Infinity" style="width: 300px;">
							<c:forEach var="acnt" items="${acnt_list}">
								<option value="${acnt.acnt_code}">[${acnt.acnt_name}] ${acnt.bank_name} ${acnt.acnt_numb}</option>
							</c:forEach>
						</select>
					</div>
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
									<button type="button" class="btn btn-sm btn-info" id="btnRegist"> 거래등록</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th width="2%" class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
										<th width="6%">출납일</th>
										<th width="6%">구분</th>
										<th width="11%">계정<span class="required">*</span></th>
										<th width="11%">세목</th>
										<th width="17%">적요<span class="required">*</span></th>
										<th width="11%">상대계정</th>
										<th width="11%">자금원천</th>
										<th width="6%">입금</th>
										<th width="6%">출금</th>
										<th width="6%">잔액</th>
										<th width="4%"></th>
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
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-header">
						<div class="row">
							<div class="col-3">
								<div class="float-left">
									<span class="text-bold">거래내역</span>
								</div>
							</div>
							<div class="col-6 d-flex justify-content-between">
								<div class="px-1">
									<span class="text-bold mr-2">전월이월금</span>
									<span id="span_prev_balance_amount"></span>
								</div>
								<div class="px-1">
									<span class="text-bold mr-2">수입계</span>
									<span id="span_input_amount"></span>
								</div>
								<div class="px-1">
									<span class="text-bold mr-2">지출계</span>
									<span id="span_output_amount"></span>
								</div>
								<div class="px-1">
									<span class="text-bold mr-2">잔액</span>
									<span id="span_balance_amount"></span>
								</div>
							</div>
							<div class="col-3">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-info" id="btnDirectRegist"> 직접등록</button>
								</div>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable2", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable2", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable2_colvis"></div>
							<div class="col-md-5">
								<div class="float-right">
									<button type="button" class="btn btn-sm btn-danger" id="btnDelete"><i class="fas fa-trash-alt"></i> 삭제</button>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable2" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th width="2%" class="no_toggle"><input type="checkbox" name="tb_check_all"></th>
										<th width="6%">출납일</th>
										<th width="6%">구분</th>
										<th width="11%">계정</th>
										<th width="11%">세목</th>
										<th width="17%">적요</th>
										<th width="11%">상대계정</th>
										<th width="11%">자금원천</th>
										<th width="6%">입금</th>
										<th width="6%">출금</th>
										<th width="6%">잔액</th>
										<th width="4%"></th>
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

<%-- 분할등록/수정 팝업 --%>
<!-- Modal -->
<div class="modal fade" id="formModal" role="dialog" aria-labelledby="formModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModalLabel">은행거래내역</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm">
					<input type="hidden" id="pop_bktr_code">
					<input type="hidden" id="pop_bktr_io_type">
					<table id="dataTable" class="table-form table table-sm table-bordered">
						<colgroup>
							<col width="14%">
							<col width="20%">
							<col width="13%">
							<col width="20%">
							<col width="13%">
							<col width="20%">
						</colgroup>
						<tr>
							<th>은행</th>
							<td class="text-center"><span id="pop_bank_name"></span></td>
							<th>계좌번호</th>
							<td class="text-center"><span id="pop_acnt_numb"></span></td>
							<th>거래일</th>
							<td class="text-center">
								<input type="text" class="datetimepicker-timechangeonly form-control form-control-sm" id="pop_bktr_datetime" title="거래일"
									   data-parsley-required="true" readonly>
							</td>
						</tr>
						<tr>
							<th>거래금액</th>
							<td class="text-right"><span id="pop_bktr_price"></span></td>
							<th>분할합계</th>
							<td class="text-right"><span id="pop_price_sum"></span></td>
							<th>차액</th>
							<td class="text-right"><span id="pop_price_diff"></span></td>
						</tr>
					</table>
					<table id="listTable3" class="table-list table table-sm table-bordered table-hover mt-2 mb-0" style="table-layout: fixed;">
						<colgroup>
							<col width="9%">
							<col width="14%">
							<col width="14%">
							<col width="19%">
							<col width="14%">
							<col width="14%">
							<col width="10%">
							<col width="6%">
						</colgroup>
						<thead>
						<tr>
							<th>구분<span class="required">*</span></th>
							<th>계정<span class="required">*</span></th>
							<th>세목</th>
							<th>적요<span class="required">*</span></th>
							<th>상대계정</th>
							<th>자금원천</th>
							<th>금액<span class="required">*</span></th>
							<th><button type="button" class="btn btn-xs btn-info" onclick="addPopRow()"><i class="fas fa-plus"></i> 추가</button></th>
						</tr>
						</thead>
						<tbody></tbody>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnPopRegist">저장</button>
				<button type="button" class="btn btn-info" id="btnPopModify">수정</button>
			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script id="popTemplate" type="text/x-handlebars-template">
	<tr class="row_{{numb}} main">
		<input type="hidden" name="pop_tran_code" value="{{tran_code}}">
		<td>
			<select class="select2 form-control-sm" name="pop_tran_io_type" data-minimum-results-for-search="Infinity" style="width: 100%;">
				<option value="I" {{i_selected}}>수입</option>
				<option value="O" {{o_selected}}>지출</option>
			</select>
		</td>
		<td>
			<select class="select2 form-control-sm" style="width: 100%;"
					data-parsley-required="true" name="pop_mock_code" title="계정">
				<option value="">[계정선택]</option>
			</select>
		</td>
		<td>
			<select class="select2 form-control-sm" style="width: 100%;"
					name="pop_smok_code" title="세목">
				<option value="">[세목선택]</option>
			</select>
		</td>
		<td>
			<input type="text" class="form-control form-control-sm" name="pop_tran_jukyo" value="{{tran_jukyo}}"
				   data-parsley-required="true" data-parsley-maxlength="100" title="적요">
		</td>
		<td>
			<select class="select2 form-control-sm" style="width: 100%;"
					name="pop_rel_gwan_code">
				<option value="">[상대계정선택]</option>
			</select>
		</td>
		<td>
			<select class="select2 form-control-sm" style="width: 100%;"
					name="pop_rel_mock_code">
				<option value="">[자금원천선택]</option>
			</select>
		</td>
		<td>
			<input type="text" class="form-control form-control-sm text-right" name="pop_tran_price" value="{{tran_price}}" title="금액"
				   data-parsley-required="true" data-parsley-min="-1000000000000" data-parsley-max="1000000000000">
		</td>
		<td rowspan="2">
			<button type="button" class="btn btn-xs btn-danger" onclick="popRowDelete('{{numb}}')"><i class="fas fa-minus-circle"></i> 삭제</button>
		</td>
	</tr>
	<tr class="row_{{numb}} sub">
		<td colspan="7">
			<input type="text" class="form-control form-control-sm" name="pop_tran_note" value="{{tran_note}}" title="비고"
				   placeholder="비고사항은 이곳에 입력하세요." data-parsley-maxlength="30">
		</td>
	</tr>
</script>

<%-- 직접등록/수정 팝업 --%>
<!-- Modal -->
<div class="modal fade" id="formModal2" role="dialog" aria-labelledby="formModal2Label" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="formModal2Label">거래내역</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<i class="fas fa-times"></i>
				</button>
			</div>
			<div class="modal-body">
				<form id="submitForm2">
					<input type="hidden" id="pop_tran_code">
					<table id="dataTable2" class="table-form table table-sm table-bordered mt-2 mb-0">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
						<tr>
							<th>출납일<span class="required">*</span></th>
							<td>
								<input type="text" class="datetimepicker form-control form-control-sm" id="pop_tran_datetime" title="출납일"
									   data-parsley-required="true" readonly>
							</td>
							<th>구분</th>
							<td>
								<div class="input-group d-flex justify-content-around">
							<c:forEach var="io_type" items="${io_type_list}" varStatus="status">
								<c:if test="${io_type.cddt_val ne 'M'}">
									<div class="icheck-info d-inline">
										<input type="radio" name="pop_tran_io_type" id="pop_tran_io_type_${io_type.cddt_val}" value="${io_type.cddt_val}" title="구분" required>
										<label for="pop_tran_io_type_${io_type.cddt_val}">${io_type.cddt_name}</label>
									</div>
								</c:if>
							</c:forEach>
								</div>
							</td>
						</tr>
						<tr>
							<th>계정<span class="required">*</span></th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;"
										data-parsley-required="true" id="pop_mock_code" title="계정">
									<option value="">[계정선택]</option>
								</select>
							</td>
							<th>세목</th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;"
										id="pop_smok_code" name="pop_smok_code" title="세목">
									<option value="">[세목선택]</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>적요<span class="required">*</span></th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" id="pop_tran_jukyo" name="pop_tran_jukyo" title="적요"
									   data-parsley-required="true" data-parsley-maxlength="100">
							</td>
						</tr>
						<tr>
							<th>상대계정</th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;"
										id="pop_rel_gwan_code" title="상대계정">
									<option value="">[상대계정선택]</option>
								</select>
							</td>
							<th>자금원천</th>
							<td>
								<select class="select2 form-control-sm" style="width: 100%;"
										id="pop_rel_mock_code" name="pop_rel_mock_code" title="자금원천">
									<option value="">[자금원천선택]</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>금액<span class="required">*</span></th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" id="pop_tran_price" title="금액"
									   data-parsley-required="true" data-parsley-min="-1000000000000" data-parsley-max="1000000000000">
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td colspan="3">
								<input type="text" class="form-control form-control-sm" id="pop_tran_note" title="비고"
									   data-parsley-maxlength="30">
							</td>
						</tr>
						</tbody>
					</table>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="btnPopRegist2">저장</button>
				<button type="button" class="btn btn-info" id="btnPopModify2">수정</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		getPage();
	});

	var mockData;
	var gwanData;
	function getPage() {
		mockData = getMockList();
		gwanData = getGwanList();
		getBankTranPage();
		reloadBankTranPage();
		getTranPage();
	}
	function reloadPage() {
		mockData = getMockList();
		gwanData = getGwanList();
		reloadBankTranPage();
		reloadTranPage();
	}

	$("#year, #month").on("change", function () {
		reloadPage();
	});

	$("#acnt_code").on("change", function () {
		reloadPage();
	});

	function getBankTranPage() {
		var args = {
			responsive: false
			, ordering: false
			, rowspan: [0,1,11,10]
			, ajax: {
				type: "POST"
				, url: "/accounting/bank/tran/page"
				, headers: {"Content-Type": "application/json"}
				, dataType: "json"
				, beforeSend: function () {
					$(".overlay").show();	// getTranPage 보다 속도가 느릴것으로 예상되어 overlay getBankTranPage에 추가
				}
				, data: function () {
					return JSON.stringify({
						acnt_code: $("#acnt_code").val()
						, bktr_year: $("#year").val()
						, bktr_month: $("#month").val()
					});
				}
				, dataSrc: function ( json ) {
					$.each(json.data, function (idx, item) {
						if (item.is_regist == 'N') {
							item.tran_date = item.bktr_date;
							item.tran_io_type_name =
								"<select class='select2 form-control-sm' name='frm_tran_io_type' data-minimum-results-for-search='Infinity' style='width: 100%;'>" +
									"<option value='I'" + (item.bktr_io_type == "I" ? " selected" : "") + ">수입</option>" +
									"<option value='O'" + (item.bktr_io_type == "O" ? " selected" : "") + ">지출</option>" +
								"</select>";
							item.mock_name =
								"<select class='select2 form-control-sm' name='frm_mock_code' style='width: 100%;'>" +
									"<option value=''>[계정선택]</option>" +
									getMockSelectOption(item.bktr_io_type) +
								"</select>";
							item.smok_name =
								"<select class='select2 form-control-sm' name='frm_smok_code' style='width: 100%;'>" +
									"<option value=''>[세목선택]</option>" +
								"</select>";
							item.tran_jukyo = "<input type='text' class='form-control form-control-sm' name='frm_tran_jukyo' " +
								"style='min-width: 200px;' maxlength='100' value='" + item.bktr_jukyo + "'>";
							if (item.bktr_io_type == 'O') {
								item.rel_gwan_name =
									"<select class='select2 form-control-sm' name='frm_rel_gwan_code' style='width: 100%;'>" +
									"<option value=''>[상대계정선택]</option>" +
									getRelGwanSelectOption(item.bktr_io_type) +
									"</select>";
								item.rel_mock_name =
									"<select class='select2 form-control-sm' name='frm_rel_mock_code' style='width: 100%;'>" +
									"<option value=''>[자금원천선택]</option>" +
									"</select>";
							} else {
								item.rel_gwan_name =
									"<select class='select2 form-control-sm' name='frm_rel_gwan_code' style='width: 100%;' disabled>" +
									"<option value=''>[상대계정선택]</option>" +
									getRelGwanSelectOption(item.bktr_io_type) +
									"</select>";
								item.rel_mock_name =
									"<select class='select2 form-control-sm' name='frm_rel_mock_code' style='width: 100%;' disabled>" +
									"<option value=''>[자금원천선택]</option>" +
									"</select>";
							}
							item.modify = '<button type="button" class="btn btn-xs btn-warning" onclick=\'divideBankTransaction("' + item.bktr_code + '")\'><i class="fas fa-share-alt"></i> 분할</button>';
						}
					});

					return json.data;
				}
				, complete: function () {
					$(".overlay").hide();	// getTranPage 보다 속도가 느릴것으로 예상되어 overlay getBankTranPage에 추가
				}
			}
			, columns: [
				{
					data: "bktr_code"
					, render: function (data, type, row) {
						if (row.is_regist == "N") return '<input type="checkbox" name="tb_check_list">';
						return null;
					}
				}
				, {data: "tran_date"}
				, {data: "tran_io_type_name"}
				, {data: "mock_name"}
				, {data: "smok_name"}
				, {data: "tran_jukyo"}
				, {data: "rel_gwan_name"}
				, {data: "rel_mock_name"}
				, {
					data: "tran_input_price"
					, className: 'text-right'
					, render: function (data, type, row) {
						if (row.is_regist == "N") return '<span name="frm_tran_input_price">' + row.bktr_input_price.comma() + '</span>';
						else return data.comma();
					}
				}
				, {
					data: "tran_output_price"
					, className: 'text-right'
					, render: function (data, type, row) {
						if (row.is_regist == "N") return '<span name="frm_tran_output_price">' + row.bktr_output_price.comma() + '</span>';
						else return data.comma();
					}
				}
				, {data: "bktr_balance", className: 'text-right', render: function (data, type, row) {return data.comma();}}
				, {data: "modify", defaultContent: ""}
			]
			, drawCallback: function () {
				setChangeTrigger();
			}
		}
		setAjaxDatatables("listTable", args);
		$("#listTable").DataTable().columns.adjust().draw();
	}

	function reloadBankTranPage() {
		$("#listTable").DataTable().ajax.reload(null, false);
	}

	function setChangeTrigger() {
		$("select[name=frm_tran_io_type]").on("change", function () {
			// 계정 변경
			var selectMock = $(this).closest("tr").find("select[name=frm_mock_code]");
			selectMock.find("option:not(:first)").remove();
			selectMock.append(getMockSelectOption($(this).val()));
			// 상대계정 변경
			var selectRelGwan = $(this).closest("tr").find("select[name=frm_rel_gwan_code]");
			selectRelGwan.find("option:not(:first)").remove();
			selectRelGwan.append(getRelGwanSelectOption($(this).val()));
			// 자금원천 목록초기화
			var selectRelMock = $(this).closest("tr").find("select[name=frm_rel_mock_code]");
			selectRelMock.find("option:not(:first)").remove();
			// 금액변경
			if ($(this).val() == "I") {
				var frm_tran_input_price = $(this).closest("tr").find("span[name=frm_tran_input_price]");
				var frm_tran_output_price = $(this).closest("tr").find("span[name=frm_tran_output_price]");
				frm_tran_input_price.html((frm_tran_output_price.html().removeComma()*-1).comma());
				frm_tran_output_price.html("");
				selectRelGwan.attr("disabled", true);
				selectRelMock.attr("disabled", true);
			}
			else if ($(this).val() == "O") {
				var frm_tran_output_price = $(this).closest("tr").find("span[name=frm_tran_output_price]");
				var frm_tran_input_price = $(this).closest("tr").find("span[name=frm_tran_input_price]");
				frm_tran_output_price.html((frm_tran_input_price.html().removeComma()*-1).comma());
				frm_tran_input_price.html("");
				selectRelGwan.removeAttr("disabled");
				selectRelMock.removeAttr("disabled");
			}
		});

		$("select[name=frm_mock_code]").on("change", function () {
			setSmokSelectOption($(this));
		});

		$("select[name=frm_rel_gwan_code]").on("change", function () {
			setRelMockSelectOption($(this));
		});

		$("input[name=tb_check_all]").prop("checked", false);
		$("input[name=tb_check_list]").on("change", function () {
			syncCheckbox("listTable");
		});
	}

	function getMockList() {
		var bktr_year = $("#month").val() < ${businessVO.bsns_sess_start_month} ? $("#year").val() - 1 : $("#year").val();

		$.ajax({
			type: "POST"
			, url: "/ghm/mock/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: bktr_year
				, ghm_active_yn: 'Y'
			})
			, async: false
			, success: function (data) {
				mockData = data;
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

		return mockData;
	}

	function getMockSelectOption(io_type) {
		var html = "";
		$.each(mockData, function (index, item) {
			if (item.gwan_io_type == io_type) {
				var optionText = "[" + item.gwan_numb + item.hang_numb + item.mock_numb + "] " + item.mock_name;
				html += "<option value='" + item.mock_code + "'>" + optionText + "</option>";
			}
		});
		return html;
	}

	function getGwanList() {
		var bktr_year = $("#month").val() < ${businessVO.bsns_sess_start_month} ? $("#year").val() - 1 : $("#year").val();

		$.ajax({
			type: "POST"
			, url: "/ghm/gwan/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				ghm_year: bktr_year
				, ghm_active_yn: 'Y'
			})
			, async: false
			, success: function (data) {
				gwanData = data;
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

		return gwanData;
	}

	function getRelGwanSelectOption(io_type) {
		var html = "";
		$.each(gwanData, function (index, item) {
			if (item.gwan_io_type != io_type) {
				var optionText = "[" + item.gwan_numb + "] " + item.gwan_name;
				html += "<option value='" + item.gwan_code + "'>" + optionText + "</option>";
			}
		});
		return html;
	}

	function setSmokSelectOption($this) {
		var selectSmok = $this.closest("tr").find("select[name$=_smok_code]");
		selectSmok.find("option:not(:first)").remove();

		if ($this.val() == "") return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/smok/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				mock_code: $this.val()
			})
			, async: false
			, success: function (data) {
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_io_type_name + " " + item.gwan_numb + item.hang_numb + item.mock_numb + item.smok_numb + "] " + item.smok_name;
					selectSmok.append("<option value='" + item.smok_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function setRelMockSelectOption($this) {
		var selectRelMock = $this.closest("tr").find("select[name$=_rel_mock_code]");
		selectRelMock.find("option:not(:first)").remove();

		if ($this.val() == "") return false;

		$.ajax({
			type: "POST"
			, url: "/ghm/mock/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				gwan_code: $this.val()
			})
			, async: false
			, success: function (data) {
				$.each(data, function(index, item) {
					var optionText = "[" + item.gwan_numb + item.hang_numb + item.mock_numb + "] " + item.mock_name;
					selectRelMock.append("<option value='" + item.mock_code +"'>" + optionText + "</option>").trigger("change");
				});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getTranPage() {
		var args = {
			responsive: false
			, ordering: false
			, rowspan: [0,1,11]
			, ajax: {
				type: "POST"
				, url: "/accounting/tran/page"
				, headers: {"Content-Type": "application/json"}
				, dataType: "json"
				, data: function () {
					return JSON.stringify({
						year: $("#year").val()
						, month: $("#month").val()
					});
				}
				, dataSrc: function ( json ) {
					// 전월이월금/수입계/지출계/잔액
					$("#span_prev_balance_amount").html(json.prev_balance_amount.comma());
					$("#span_input_amount").html(json.input_amount.comma());
					$("#span_output_amount").html(json.output_amount.comma());
					var balance_amount = Number(json.prev_balance_amount) + Number(json.input_amount) - Number(json.output_amount);
					$("#span_balance_amount").html(balance_amount.comma());

					$.each(json.data, function (idx, item) {
						item.code = isNull(item.bktr_code) ? item.tran_code : item.bktr_code;
					});

					return json.data;
				}
			}
			, columns: [
				{
					data: "code"
					, render: function (data, type, row) {
						return '<input type="checkbox" name="tb_check_list" value="' + row.bktr_code + '"' + ( isNotNull(row.bktr_code) ? "" : " data-tran_code='" + row.tran_code + "'" ) + '>';
					}
				}
				, {data: "tran_date"}
				, {data: "tran_io_type_name"}
				, {data: "mock_name"}
				, {data: "smok_name"}
				, {data: "tran_jukyo"}
				, {data: "rel_gwan_name"}
				, {data: "rel_mock_name"}
				, {data: "tran_input_price", className: 'text-right', render: function (data, type, row) {return data.comma();}}
				, {data: "tran_output_price", className: 'text-right', render: function (data, type, row) {return data.comma();}}
				, {data: "tran_balance", className: 'text-right', render: function (data, type, row) {return data.comma();}}
				, {
					data: "code"
					, render: function (data, type, row) {
						if (isNull(row.bktr_code)) return '<button type="button" class="btn btn-xs btn-info" onclick=\'modifyTransaction("' + row.tran_code + '")\'><i class="fas fa-edit"></i> 수정</button>';
						else return '<button type="button" class="btn btn-xs btn-info" onclick=\'modifyBankTransaction("' + row.bktr_code + '")\'><i class="fas fa-edit"></i> 수정</button>';
					}
				}
			]
		}
		setAjaxDatatables("listTable2", args);
	}

	function reloadTranPage() {
		$("#listTable2").DataTable().ajax.reload(null, false);
	}

	$("#btnRegist").on("click", function () {
		var checked_list = $("#listTable input:checkbox[name=tb_check_list]:checked");

		// 은행거래내역 선택체크
		if (checked_list.length == 0) {
			alert("선택된 은행거래내역이 없습니다.");
			return false;
		}

		// 은행거래내역 필수입력 체크
		var valid = true;
		$.each(checked_list, function () {
			var mock_code = $(this).closest("tr").find("select[name=frm_mock_code]");
			var tran_jukyo = $(this).closest("tr").find("input[name=frm_tran_jukyo]");
			if (mock_code.val() === '') {
				alert("계정항목은 필수입력사항입니다."); mock_code.focus();
				valid = false; return false;
			}
			if (tran_jukyo.val() === '') {
				alert("적요는 필수입력사항입니다."); tran_jukyo.focus();
				valid = false; return false;
			}
		});
		if (!valid) return false;


		if (!confirm("저장하시겠습니까?")) return false;

		var bktr_code_list = [];
		var tran_date_list = [];
		var tran_io_type_list = [];
		var tran_price_list = [];
		var tran_jukyo_list = [];
		var mock_code_list = [];
		var smok_code_list = [];
		var rel_gwan_code_list = [];
		var rel_mock_code_list = [];

		$.each(checked_list, function () {
			/* 최근은행거래내역이 마지막에 등록되도록 push가 아닌 unshift로 추가 */
			var data = $("#listTable").DataTable().row($(this).closest("tr")).data();
			bktr_code_list.unshift(data.bktr_code);
			tran_date_list.unshift(data.bktr_date);
			var io_type = $(this).closest("tr").find("select[name=frm_tran_io_type]").val();
			tran_io_type_list.unshift(io_type);
			mock_code_list.unshift($(this).closest("tr").find("select[name=frm_mock_code]").val());
			smok_code_list.unshift($(this).closest("tr").find("select[name=frm_smok_code]").val());
			tran_jukyo_list.unshift($(this).closest("tr").find("input[name=frm_tran_jukyo]").val());
			rel_gwan_code_list.unshift($(this).closest("tr").find("select[name=frm_rel_gwan_code]").val());
			rel_mock_code_list.unshift($(this).closest("tr").find("select[name=frm_rel_mock_code]").val());
			if (io_type == "I") tran_price_list.unshift($(this).closest("tr").find("span[name=frm_tran_input_price]").html().removeComma());
			else if (io_type == "O") tran_price_list.unshift($(this).closest("tr").find("span[name=frm_tran_output_price]").html().removeComma());
		})

		$.ajax({
			type: "POST"
			, url: "/accounting/tran/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bktr_code_list: bktr_code_list
				, tran_date_list: tran_date_list
				, tran_io_type_list: tran_io_type_list
				, tran_price_list: tran_price_list
				, tran_jukyo_list: tran_jukyo_list
				, mock_code_list: mock_code_list
				, smok_code_list: smok_code_list
				, rel_gwan_code_list: rel_gwan_code_list
				, rel_mock_code_list: rel_mock_code_list
			})
			, success: function (data) {
				if (data == 'success') {
					reloadPage();
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function divideBankTransaction(bktr_code) {
		initDataTable("dataTable");
		$("#btnPopRegist").show();
		$("#btnPopModify").hide();
		getItem(bktr_code);
		$("#formModal").modal("show");
	}

	function modifyBankTransaction(bktr_code) {
		$("#btnPopRegist").hide();
		$("#btnPopModify").show();
		getItem(bktr_code);
		$("#formModal").modal("show");
	}

	function getItem(bktr_code) {
		initDataTable("dataTable");
		$("#pop_price_sum").html(0);
		$("#pop_price_diff").html(0);
		$.ajax({
			type: "POST"
			, url: "/accounting/bank/tran/item/" + bktr_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setPopValue(data);

				$("#pop_bktr_datetime").datetimepicker({
					minDate: data.bktr_datetime
					, maxDate: data.bktr_datetime
				});

				getSubList(data, bktr_code);
				calc();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function getSubList(item, bktr_code) {
		$.ajax({
			type: "POST"
			, url: "/accounting/tran/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				bktr_code: bktr_code
			})
			, async: false
			, success: function (data) {
				$("#listTable3 tbody").empty();
				if (data.length > 0) {
					$.each(data, function (index, item) {
						addPopRow(item);
					});
				} else {
					addPopRow();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	var p_row_numb = 0;
	function addPopRow(data) {
		var popTemplate = $("#popTemplate").html();
		var popBindTemplate = Handlebars.compile(popTemplate);

		var io_type = isNull(data) ? $("#pop_bktr_io_type").val() : data.tran_io_type;

		var html = "";
		if (isNull(data)) {
			var item = {
				numb: ++p_row_numb
				, tran_code: ""
				, mock_code: ""
				, smok_code: ""
				, tran_jukyo: ""
				, rel_gwan_code: ""
				, rel_mock_code: ""
				, tran_price: ""
				, tran_note: ""
				, i_selected: io_type == "I" ? "selected" : ""
				, o_selected: io_type == "O" ? "selected" : ""
			}
			html += popBindTemplate(item);
		} else {
			var item = {
				numb: ++p_row_numb
				, tran_code: data.tran_code
				, mock_code: data.mock_code
				, smok_code: data.smok_code
				, tran_jukyo: data.tran_jukyo
				, rel_gwan_code: data.rel_gwan_code
				, rel_mock_code: data.rel_mock_code
				, tran_price: data.tran_price
				, tran_note: data.tran_note
				, i_selected: io_type == "I" ? "selected" : ""
				, o_selected: io_type == "O" ? "selected" : ""
			}
			html += popBindTemplate(item);
		}
		$("#listTable3 tbody").append(html);

		// 구분(수입/지출) 변경
		$("select[name=pop_tran_io_type]").on("change", function () {
			// 계정 변경
			var selectMock = $(this).closest("tr").find("select[name=pop_mock_code]");
			selectMock.find("option:not(:first)").remove();
			selectMock.append(getMockSelectOption($(this).val()));
			// 상대계정 변경
			var selectRelGwan = $(this).closest("tr").find("select[name=pop_rel_gwan_code]");
			selectRelGwan.find("option:not(:first)").remove();
			selectRelGwan.append(getRelGwanSelectOption($(this).val()));
			// 자금원천
			var selectRelMock = $(this).closest("tr").find("select[name=pop_rel_mock_code]");
			selectRelMock.find("option:not(:first)").remove();
			// 금액변경
			if ($(this).val() == "I") {
				selectRelGwan.attr("disabled", true);
				selectRelMock.attr("disabled", true);
			}
			else if ($(this).val() == "O") {
				selectRelGwan.removeAttr("disabled");
				selectRelMock.removeAttr("disabled");
			}
			calc();
		});
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_tran_io_type]").trigger("change");

		// 계정, 세목 세팅
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_mock_code]").append(getMockSelectOption(io_type));
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_mock_code]").on("change", function () {
			setSmokSelectOption($(this));
		});
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_mock_code]").val(item.mock_code).trigger("change");
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_smok_code]").val(item.smok_code).trigger("change");

		// 상대계정, 자금원천 세팅
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_rel_gwan_code]").append(getRelGwanSelectOption(io_type));
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_rel_gwan_code]").on("change", function () {
			setRelMockSelectOption($(this));
		});
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_rel_gwan_code]").val(item.rel_gwan_code).trigger("change");
		$("#listTable3 tbody tr.row_" + p_row_numb).find("select[name=pop_rel_mock_code]").val(item.rel_mock_code).trigger("change");

		// 분할합계 및 차액 계산
		$("#listTable3 tbody tr.row_" + p_row_numb).find("input[name=pop_tran_price]").on("keyup focusout", function () {
			$(this).val($(this).val().number());
			calc();
		});

		$("#listTable3 tbody tr.row_" + p_row_numb + " .select2").select2();
	}

	function calc() {
		var bktr_io_type = $("#pop_bktr_io_type").val();
		var bktr_price = Number($("#pop_bktr_price").html().removeComma());

		var price_sum = 0;
		$.each($("#listTable3 tbody tr.main"), function () {
			var tran_io_type = $(this).find("select[name=pop_tran_io_type]").val();
			var tran_price = Number($(this).find("input[name=pop_tran_price]").val());
			var tran_price = bktr_io_type == tran_io_type ? tran_price : tran_price * -1;
			price_sum += tran_price ? tran_price : 0;
		});

		$("#pop_price_sum").html(price_sum.comma());
		$("#pop_price_diff").html((bktr_price - price_sum).comma());
	}

	function popRowDelete(numb) {
		if ($("#listTable3 tbody tr.main").length == 1) {
			alert("첫행은 삭제 불가합니다.");
			return false;
		}

		var tran_code = $("#listTable3 tbody tr.row_" + numb).find("input[name=pop_tran_code]").val();
		if (isNotNull(tran_code)) {
			// 데이터 삭제 목록 추가
			$("#submitForm").append("<input type='hidden' name='pop_delete_tran_code' value='" + tran_code + "'>");
		}
		// 행 삭제 후 분할합계 및 차액 계산
		$("#listTable3 tbody tr.row_" + numb).remove();

		calc();
	}


	$("#btnPopRegist").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;

		if ($("#pop_price_diff").html() != "0") {
			alert("차액이 0이 아닙니다. 확인 후 다시 등록해주세요.");
			return false;
		}

		if (!confirm("저장하시겠습니까?")) return false;

		var bktr_code_list = [];
		var tran_date_list = [];
		var tran_io_type_list = [];
		var mock_code_list = [];
		var smok_code_list = [];
		var tran_jukyo_list = [];
		var rel_gwan_code_list = [];
		var rel_mock_code_list = [];
		var tran_price_list = [];
		var tran_note_list = [];

		$.each($("#listTable3 tbody tr.main"), function () {
			bktr_code_list.push($("#pop_bktr_code").val());
			tran_date_list.push($("#pop_bktr_datetime").val());
			tran_io_type_list.push($(this).find("select[name=pop_tran_io_type]").val());
			mock_code_list.push($(this).find("select[name=pop_mock_code]").val());
			smok_code_list.push($(this).find("select[name=pop_smok_code]").val());
			tran_jukyo_list.push($(this).find("input[name=pop_tran_jukyo]").val());
			rel_gwan_code_list.push($(this).find("select[name=pop_rel_gwan_code]").val());
			rel_mock_code_list.push($(this).find("select[name=pop_rel_mock_code]").val());
			tran_price_list.push($(this).find("input[name=pop_tran_price]").val());
			tran_note_list.push($(this).next().find("input[name=pop_tran_note]").val());
		});

		$.ajax({
			type: "POST"
			, url: "/accounting/tran/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bktr_code_list: bktr_code_list
				, tran_date_list: tran_date_list
				, tran_io_type_list: tran_io_type_list
				, tran_price_list: tran_price_list
				, tran_jukyo_list: tran_jukyo_list
				, mock_code_list: mock_code_list
				, smok_code_list: smok_code_list
				, rel_gwan_code_list: rel_gwan_code_list
				, rel_mock_code_list: rel_mock_code_list
				, rel_mock_code_list: rel_mock_code_list
				, tran_note_list: tran_note_list
			})
			, success: function (data) {
				if (data == 'success') {
					reloadPage();
					$("#formModal").modal("hide");
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnPopModify").on("click", function () {
		if (!parsleyFormValidate("submitForm")) return false;

		if ($("#pop_price_diff").html() != "0") {
			alert("차액이 0이 아닙니다. 확인 후 다시 등록해주세요.");
			return false;
		}
		if (!confirm("수정하시겠습니까?")) return false;

		var tran_code_list = [];
		var bktr_code_list = [];
		var tran_date_list = [];
		var tran_io_type_list = [];
		var mock_code_list = [];
		var smok_code_list = [];
		var tran_jukyo_list = [];
		var rel_gwan_code_list = [];
		var rel_mock_code_list = [];
		var tran_price_list = [];
		var tran_note_list = [];
		$.each($("#listTable3 tbody tr.main"), function () {
			tran_code_list.push($(this).find("input[name=pop_tran_code]").val());
			bktr_code_list.push($("#pop_bktr_code").val());
			tran_date_list.push($("#pop_bktr_datetime").val());
			tran_io_type_list.push($(this).find("select[name=pop_tran_io_type]").val());
			mock_code_list.push($(this).find("select[name=pop_mock_code]").val());
			smok_code_list.push($(this).find("select[name=pop_smok_code]").val());
			tran_jukyo_list.push($(this).find("input[name=pop_tran_jukyo]").val());
			rel_gwan_code_list.push($(this).find("select[name=pop_rel_gwan_code]").val());
			rel_mock_code_list.push($(this).find("select[name=pop_rel_mock_code]").val());
			tran_price_list.push($(this).find("input[name=pop_tran_price]").val());
			tran_note_list.push($(this).next().find("input[name=pop_tran_note]").val());
		})

		var delete_tran_code_list = [];
		$.each($("input[name=pop_delete_tran_code]"), function () {
			delete_tran_code_list.push($(this).val());
		});

		$.ajax({
			type: "PUT"
			, url: "/accounting/tran/modify"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				tran_code_list: tran_code_list
				, bktr_code_list: bktr_code_list
				, tran_date_list: tran_date_list
				, tran_io_type_list: tran_io_type_list
				, mock_code_list: mock_code_list
				, smok_code_list: smok_code_list
				, tran_jukyo_list: tran_jukyo_list
				, rel_gwan_code_list: rel_gwan_code_list
				, rel_mock_code_list: rel_mock_code_list
				, tran_price_list: tran_price_list
				, tran_note_list: tran_note_list
				, delete_tran_code_list: delete_tran_code_list
			})
			, success: function (data) {
				if (data == 'success') {
					reloadPage();
					$("#formModal").modal("hide");
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnDelete").on("click", function () {
		var checked_list = $("#listTable2 input:checkbox[name=tb_check_list]:checked");
		// 거래내역 선택체크
		if (checked_list.length == 0) {
			alert("선택된 거래내역이 없습니다.");
			return false;
		}
		if (!confirm("삭제하시겠습니까?")) return false;

		var bktr_code_list = [];
		var tran_code_list = [];
		$.each(checked_list, function () {
			var data = $("#listTable2").DataTable().row($(this).closest("tr")).data();
			bktr_code_list.push(data.bktr_code === "undefined" ? null : data.bktr_code);
			tran_code_list.push(data.tran_code);
		});

		$.ajax({
			type: "DELETE"
			, url: "/accounting/tran/delete"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				bktr_code_list: bktr_code_list
				, tran_code_list: tran_code_list
			})
			, success: function (data) {
				if (data == 'success') {
					reloadPage();
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	$("#btnDirectRegist").on("click", function () {
		initDataTable("dataTable2");
		$("#btnPopRegist2").show();
		$("#btnPopModify2").hide();
		$("#formModal2").modal("show");
		$("input:radio[name=pop_tran_io_type]:checked").trigger("change");
	});

	$("input:radio[name=pop_tran_io_type]").on("change", function () {
		console.log("ddd");
		// 계정 변경
		$("#pop_mock_code option:not(:first)").remove();
		$("#pop_mock_code").append(getMockSelectOption($(this).val()));
		// 상대계정 변경
		$("#pop_rel_gwan_code option:not(:first)").remove();
		$("#pop_rel_gwan_code").append(getRelGwanSelectOption($(this).val()));
		// 자금원천
		$("#pop_rel_mock_code option:not(:first)").remove();
		// 금액변경
		console.log("$(this).val(): " + $(this).val());
		if ($(this).val() == "I") {
			console.log("disabled");
			$("#pop_rel_gwan_code").attr("disabled", true);
			$("#pop_rel_mock_code").attr("disabled", true);
		}
		else if ($(this).val() == "O") {
			console.log("abled");
			$("#pop_rel_gwan_code").removeAttr("disabled");
			$("#pop_rel_mock_code").removeAttr("disabled");
		}
	});

	$("#pop_mock_code").on("change", function () {
		setSmokSelectOption($(this));
	});

	$("#pop_rel_gwan_code").on("change", function () {
		setRelMockSelectOption($(this));
	});

	$("#pop_tran_price").on("keyup focusout", function () {
		$(this).val($(this).val().number());
	});

	$("#btnPopRegist2").on("click", function () {
		if (!parsleyFormValidate("submitForm2")) return false;
		if (!confirm("저장하시겠습니까?")) return false;

		$.ajax({
			type: "POST"
			, url: "/accounting/tran/direct/regist"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				tran_date: $("#pop_tran_datetime").val()
				, tran_io_type: $("input:radio[name=pop_tran_io_type]:checked").val()
				, mock_code: $("#pop_mock_code").val()
				, smok_code: $("#pop_smok_code").val()
				, tran_jukyo: $("#pop_tran_jukyo").val()
				, rel_gwan_code: $("#pop_rel_gwan_code").val()
				, rel_mock_code: $("#pop_rel_mock_code").val()
				, tran_price: $("#pop_tran_price").val()
				, tran_note: $("#pop_tran_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					reloadPage();
					$("#formModal2").modal("hide");
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});

	function modifyTransaction(tran_code) {
		$("#btnPopRegist2").hide();
		$("#btnPopModify2").show();
		getItem2(tran_code);
		$("#formModal2").modal("show");
	}

	function getItem2(tran_code) {
		initDataTable("dataTable2");
		$.ajax({
			type: "POST"
			, url: "/accounting/tran/item/" + tran_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, success: function (data) {
				setPopValue(data);
				$("#pop_mock_code").val(data.mock_code).trigger("change");
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	$("#btnPopModify2").on("click", function () {
		if (!parsleyFormValidate("submitForm2")) return false;
		if (!confirm("수정하시겠습니까?")) return false;

		$.ajax({
			type: "PUT"
			, url: "/accounting/tran/direct/modify/" + $("#pop_tran_code").val()
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				tran_code: $("#pop_tran_code").val()
				, tran_date: $("#pop_tran_datetime").val()
				, tran_io_type: $("input:radio[name=pop_tran_io_type]:checked").val()
				, mock_code: $("#pop_mock_code").val()
				, smok_code: $("#pop_smok_code").val()
				, tran_jukyo: $("#pop_tran_jukyo").val()
				, rel_gwan_code: $("#pop_rel_gwan_code").val()
				, rel_mock_code: $("#pop_rel_mock_code").val()
				, tran_price: $("#pop_tran_price").val()
				, tran_note: $("#pop_tran_note").val()
			})
			, success: function (data) {
				if (data == 'success') {
					reloadPage();
					$("#formModal2").modal("hide");
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
