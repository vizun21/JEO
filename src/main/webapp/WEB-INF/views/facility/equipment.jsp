<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
	<c:when test="${empty facility.facility_tag_no}">
		<c:set var="action"><c:url value="/facility/equipment"/></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="action"><c:url value="/facility/equipment/modify"/></c:set>
	</c:otherwise>
</c:choose>

<style>
	table th {
		word-break: keep-all;
	}

    .imgLayout4-3 {
		width: 457.2px;
		height: 342.9px;
	}
</style>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<form id="facilityForm" action="${action}" method="post"
							  onsubmit="return validate();" enctype="multipart/form-data">
							<table id="listTable" class="table-list table table-sm table-bordered mb-3">
								<colgroup>
									<col width="5%"/>
									<col width="5%"/>
									<col width="15%"/>
									<col width="10%"/>
									<col width="15%"/>
									<col width="10%"/>
									<col width="15%"/>
									<col width="10%"/>
									<col width="15%"/>
								</colgroup>
								<thead>
								<tr>
									<th colspan="7">설비이력카드</th>
									<th>사업소명</th>
									<th>전주환경사업소</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<th colspan="2"><span class="required">*</span> 설비명</th>
									<td colspan="3">
										<input type="text" class="form-control form-control-sm" name="facility_name"
											   maxlength="20" data-parsley-required="true" title="설비명"
											   value="${facility.facility_name}">
									</td>
									<th><span class="required">*</span> 공종</th>
									<td>
										<select name="construction_code" class="form-control form-control-sm"
												data-parsley-required="true" title="공종">
											<c:forEach var="constructionType" items="${constructionTypes}"
													   varStatus="status">
												<option value="${constructionType.construction_code}" <c:if test="${facility.construction_code == constructionType.construction_code}">selected</c:if>>${constructionType.construction_name}</option>
											</c:forEach>
										</select>
									</td>
									<th><span class="required">*</span> 구분</th>
									<td>
										<select name="category_code" class="form-control form-control-sm"
												data-parsley-required="true" title="구분">
											<c:forEach var="category" items="${categories}"
													   varStatus="status">
												<option value="${category.category_code}" <c:if test="${facility.category_code == category.category_code}">selected</c:if>>${category.category_name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th colspan="2"><span class="required">*</span> TAG NO.</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="facility_tag_no" id="facility_tag_no" title="TAG NO."
											   maxlength="20" data-parsley-required="true"
											   value="${facility.facility_tag_no}"
											   <c:if test="${not empty facility.facility_tag_no}">readonly="readonly"</c:if>>
										<small class="checkResult font-italic"></small>
									</td>
									<th>설치장소</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="emplacement"
											   maxlength="50" value="${facility.emplacement}">
									</td>
									<th>수량</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="facility_quantity"
											   value="${facility.facility_quantity}">
									</td>
									<th>구입가격</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="purchase_price"
											   value="${facility.purchase_price}">
									</td>
								</tr>
								<tr>
									<th colspan="2">제작회사</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="production_company"
											   maxlength="50" value="${facility.production_company}">
									</td>
									<th>형식</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="form" maxlength="50"
											   value="${facility.form}">
									</td>
									<th>제작일자</th>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="manufacture_date" readonly value="${facility.manufacture_date}">
									</td>
									<th>준공일자</th>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="completion_date" readonly value="${facility.completion_date}">
									</td>
								</tr>
								<tr>
									<th colspan="2">설치업체</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="installer"
											   maxlength="50" value="${facility.installer}">
									</td>
									<th>제원</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="specification"
											   maxlength="50"
											   value="${facility.specification}">
									</td>
									<th>내구연한</th>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="durable" readonly value="${facility.durable}">
									</td>
									<th>대수선 준공일자</th>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="major_repaircompletion_date" readonly value="${facility.major_repaircompletion_date}">
									</td>
								</tr>
								<tr>
									<th colspan="2">설치용도</th>
									<td colspan="3">
										<input type="text" class="form-control form-control-sm" name="installation_purpose"
											   maxlength="50"
											   value="${facility.installation_purpose}">
									</td>
									<th>대수선 내용</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="major_repair_content"
											   maxlength="50"
											   value="${facility.major_repair_content}">
									</td>
									<th>대수선 설치업체</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="major_repair_installer" maxlength="50"
											   value="${facility.major_repair_installer}">
									</td>
								</tr>
								<tr>
									<th rowspan="3">전동기</th>
									<th>형식</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="electric_motor_form" maxlength="50"
											   value="${facility.electric_motor_form}">
									</td>
									<th>회전수</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="electric_motor_rpm" maxlength="50"
											   value="${facility.electric_motor_rpm}">
									</td>
									<th>제작회사</th>
									<td colspan="3">
										<input type="text" class="form-control form-control-sm"
											   name="electric_motor_production_company" maxlength="50"
											   value="${facility.electric_motor_production_company}">
									</td>
								</tr>
								<tr>
									<th>용량</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="electric_motor_volume" maxlength="50"
											   value="${facility.electric_motor_volume}">
									</td>
									<th>기동방법</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="electric_motor_starting_method" maxlength="50"
											   value="${facility.electric_motor_starting_method}">
									</td>
									<th rowspan="2">모터 베어링 No.</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="motor_bearing_no_1" maxlength="50"
											   value="${facility.motor_bearing_no_1}">
									</td>
									<th rowspan="2">펌프/감속기 베어링 No.</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="pump_reducer_bearing_no_1" maxlength="50"
											   value="${facility.pump_reducer_bearing_no_1}">
									</td>
								</tr>
								<tr>
									<th>전원</th>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="electric_motor_power" maxlength="50"
											   value="${facility.electric_motor_power}">
									</td>
									<th>제작일자</th>
									<td>
										<input type="text" class="datepicker form-control form-control-sm"
											   name="electric_motor_production_date" readonly
											   value="${facility.electric_motor_production_date}">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="motor_bearing_no_2" maxlength="50"
											   value="${facility.motor_bearing_no_2}">
									</td>
									<td>
										<input type="text" class="form-control form-control-sm"
											   name="pump_reducer_bearing_no_2" maxlength="50"
											   value="${facility.pump_reducer_bearing_no_2}">
									</td>
								</tr>
								</tbody>
							</table>

							<table id="subTable" class="table-list table table-sm table-bordered">
								<colgroup>
									<col width="30%"/>
									<col width="5%"/>
									<col width="15%"/>
									<col width="15%"/>
									<col width="5%"/>
									<col width="15%"/>
									<col width="15%"/>
								</colgroup>
								<thead>
								<tr>
									<th>사진</th>
									<th colspan="5">기타설비 및 부속설비</th>
									<th>
										<button id="addRow" type="button" class="btn btn-sm btn-primary btn-block">추가</button>
									</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td rowspan="9">
										<c:choose>
											<c:when test="${facility.facility_image_path eq null}">
												<img id="facility_image_preview" src="" width="100%" class="mb-2">
											</c:when>
											<c:otherwise>
												<img id="facility_image_preview" src="/preview?fileName=${facility.facility_image_path}" width="100%" class="mb-2 imgLayout4-3">
											</c:otherwise>
										</c:choose>
										<input type="file" id="facility_image" name="facility_image" accept="image/jpeg, image/png">
									</td>
									<th>순번</th>
									<th>품명</th>
									<th>제원</th>
									<th>수량</th>
									<th>제작회사</th>
									<th>비고</th>
								</tr>
								<c:forEach var="subFacility" items="${subFacilities}" varStatus="status">
									<tr id="sub_row_${status.index}">
										<input type='hidden' name='subFacilities[${status.index}].sub_facility_no'
											   value="${subFacility.sub_facility_no}">
										<td>${status.index + 1}</td>
										<td><input type='text' class='form-control form-control-sm'
												   name='subFacilities[${status.index}].sub_facility_name'
												   maxlength='50' title='품명' data-parsley-required='true'
												   value="${subFacility.sub_facility_name}"></td>
										<td><input type='text' class='form-control form-control-sm'
												   name='subFacilities[${status.index}].sub_facility_spec'
												   maxlength='50' value="${subFacility.sub_facility_spec}"></td>
										<td><input type='text' class='form-control form-control-sm'
												   name='subFacilities[${status.index}].sub_facility_quantity'
												   maxlength='50' value="${subFacility.sub_facility_quantity}"></td>
										<td><input type='text' class='form-control form-control-sm'
												   name='subFacilities[${status.index}].sub_facility_production_company'
												   maxlength='50'
												   value="${subFacility.sub_facility_production_company}"></td>
										<td><input type='text' class='form-control form-control-sm'
												   name='subFacilities[${status.index}].sub_facility_note'
												   maxlength='50' value="${subFacility.sub_facility_note}"></td>
									</tr>
								</c:forEach>
								<c:forEach var="i" begin="${fn:length(subFacilities)}" end="7">
								<tr id="sub_row_${i}">
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
							<div class="row mt-2">
						<c:choose>
							<c:when test="${empty facility.facility_tag_no}">
								<div class="offset-8"></div>
								<div class="col-2">
									<button type="button" class="btn btn-primary btn-block" onclick="history.back();">이전</button>
								</div>
								<div class="col-2">
									<button type="submit" class="btn btn-primary btn-block">저장</button>
								</div>
							</c:when>
							<c:otherwise>
								<div class="offset-4"></div>
								<div class="col-2">
									<button type="button" class="btn btn-primary btn-block" onclick="history.back();">이전</button>
								</div>
								<div class="col-2">
									<button type="submit" class="btn btn-primary btn-block">저장</button>
								</div>
								<div class="col-2">
									<button type="button" class="btn btn-primary btn-block" id="btnRepair">수리내역관리</button>
								</div>
								<div class="col-2">
									<button type="button" class="btn btn-primary btn-block" id="btnPrint">
										<i class="fas fa-print"></i> 인쇄
									</button>
								</div>
							</c:otherwise>
						</c:choose>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	<c:if test="${empty facility.facility_tag_no}">
	$("#facility_tag_no").on("keyup focusout", function () {
		overlapCheck($(this));
	});
	</c:if>

	$("input[name=facility_quantity], input[name=purchase_price]").on("keyup focusout", function () {
		$(this).val($(this).val().number());
	});

	$("#subTable").on("keyup focusout", "input[name$=sub_facility_quantity]", function() {
		$(this).val($(this).val().number());
	});

	$("#facility_image").change(function(){
		if(this.files && this.files[0]) {
			var id = $(this).attr("id");
			var reader = new FileReader;
			reader.onload = function(data) {
				$("#" + id + "_preview").attr("src", data.target.result);
			}
			reader.readAsDataURL(this.files[0]);
		}
	});

	$("#btnPrint").on("click", function () {
		let url = "<c:url value='/print/html/equipment-card/${facility.facility_tag_no}/'/>";
		window.open(url, '_blank');
	});

	$("#btnRepair").on("click", function () {
		let url = "<c:url value='/facility/repair'/>?facility_tag_no=${facility.facility_tag_no}";
		window.location.href = url;
	});

	var sub_row_num = ${fn:length(subFacilities)};
	$("#addRow").on("click", function () {
		if (sub_row_num >= 8) {
			alert("기타설비 및 부속설비는 최대 8개까지 추가가능합니다.");
			return false;
		}

		$("#sub_row_" + sub_row_num).html(
			"<input type='hidden' name='subFacilities[" + sub_row_num + "].sub_facility_no'>" +
			"<td>" + (sub_row_num + 1) + "</td>" +
			"<td><input type='text' class='form-control form-control-sm' name='subFacilities[" + sub_row_num + "].sub_facility_name' maxlength='50' title='품명' data-parsley-required='true'></td>" +
			"<td><input type='text' class='form-control form-control-sm' name='subFacilities[" + sub_row_num + "].sub_facility_spec' maxlength='50'></td>" +
			"<td><input type='text' class='form-control form-control-sm' name='subFacilities[" + sub_row_num + "].sub_facility_quantity' maxlength='50'></td>" +
			"<td><input type='text' class='form-control form-control-sm' name='subFacilities[" + sub_row_num + "].sub_facility_production_company' maxlength='50'></td>" +
			"<td><input type='text' class='form-control form-control-sm' name='subFacilities[" + sub_row_num + "].sub_facility_note' maxlength='50'></td>"
		);

		sub_row_num++;
	});

	function validate() {
		if (!parsleyFormValidate("facilityForm")) return false;
		if (!checkResultValidate("facilityForm", "checkResult")) return false;
	}

	function overlapCheck(obj) {
		var minLength = obj.data("parsley-length") ? 1 : 0;
		if (obj.val().length < minLength) return false;

		$.ajax({
			type: "POST"
			, url: "/facility/equipment/overlapCheck"
			, dataType: "json"
			, contentType: "application/json; charset=utf-8"
			, data: JSON.stringify({
				facility_tag_no: obj.val()
			})
			, success: function (data) {
				if (data) {
					obj.next(".checkResult")
						.html("중복된 " + obj.prop("title") + "입니다.")
				} else {
					obj.next(".checkResult").html("");
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}
</script>
