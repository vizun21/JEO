<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	table th {
		word-break: keep-all;
	}
</style>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<form id="facilityForm" action="<c:url value="/facility/equipment"/>" method="post"
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
												<option value="${constructionType.construction_code}">${constructionType.construction_name}</option>
											</c:forEach>
										</select>
									</td>
									<th><span class="required">*</span> 구분</th>
									<td>
										<select name="category_code" class="form-control form-control-sm"
												data-parsley-required="true" title="구분">
											<c:forEach var="category" items="${categories}"
													   varStatus="status">
												<option value="${category.category_code}">${category.category_name}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th colspan="2"><span class="required">*</span> TAG NO.</th>
									<td>
										<input type="text" class="form-control form-control-sm" name="facility_tag_no"
											   maxlength="20" data-parsley-required="true" title="TAG NO."
											   value="${facility.facility_tag_no}">
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

							<table class="table-list table table-sm table-bordered">
								<colgroup>
									<col width="40%"/>
									<col width="5%"/>
									<col width="15%"/>
									<col width="15%"/>
									<col width="5%"/>
									<col width="15%"/>
									<col width="5%"/>
								</colgroup>
								<thead>
								<tr>
									<th>사진</th>
									<th colspan="5">기타 설비 및 부속설비</th>
									<th>
										<button class="btn btn-sm btn-primary">추가</button>
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
												<img id="facility_image_preview" src="/preview?fileName=${facility.facility_image_path}" width="100%" class="mb-2">
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
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								</tbody>
							</table>
							<div class="row mt-2">
								<div class="offset-6"></div>
								<div class="col-2">
									<button type="button" class="btn btn-primary btn-block" onclick="window.location.href = '<c:url value="/facility/equipment/list"/>'">목록</button>
								</div>
								<div class="col-2">
									<button type="submit" class="btn btn-primary btn-block">저장</button>
								</div>
								<div class="col-2">
									<button type="button" class="btn btn-primary btn-block">수리등록</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
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

	function validate() {
		if (!parsleyFormValidate("facilityForm")) return false;
	}

	$(function () {

	});
</script>
