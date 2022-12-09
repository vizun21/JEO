<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	.emptyTr {
		border-left: 1px solid white;
		border-right: 1px solid white;
		height: 15px;
	}

	.sub-table {
		border-left: white solid 0px !important;
		border-top: white solid 0px !important;
	}

	.sub-table .end-col {
		border-right: white solid 0px !important;
	}
</style>

<c:if test='${param.print_equipment_card}'>
<div class="page">
	<div class="subpage">
		<table class="table table-sm table-bordered">
			<thead>
			<tr>
				<th colspan="7">설비이력카드</th>
				<th>사업소명</th>
				<th>전주환경사업소</th>
			</tr>
			</thead>
			<tbody>
			<tr>
				<th colspan="2">설비명</th>
				<td colspan="3">${facility.facility_name}</td>
				<th>공종</th>
				<td>${facility.construction_name}</td>
				<th>구분</th>
				<td>${facility.category_name}</td>
			</tr>
			<tr>
				<th colspan="2">TAG NO.</th>
				<td>${facility.facility_tag_no}</td>
				<th>설치장소</th>
				<td>${facility.emplacement}</td>
				<th>수량</th>
				<td>${facility.facility_quantity}</td>
				<th>구입가격</th>
				<td>${facility.purchase_price}</td>
			</tr>
			<tr>
				<th colspan="2">제작회사</th>
				<td>${facility.production_company}</td>
				<th>형식</th>
				<td>${facility.form}</td>
				<th>제작일자</th>
				<td>${facility.manufacture_date}</td>
				<th>준공일자</th>
				<td>${facility.completion_date}</td>
			</tr>
			<tr>
				<th colspan="2">설치업체</th>
				<td>${facility.installer}</td>
				<th>제원</th>
				<td>${facility.specification}</td>
				<th>내구연한</th>
				<td>${facility.durable}</td>
				<th>대수선 준공일자</th>
				<td>${facility.major_repaircompletion_date}</td>
			</tr>
			<tr>
				<th colspan="2">설치용도</th>
				<td colspan="3">${facility.installation_purpose}</td>
				<th>대수선 내용</th>
				<td>${facility.major_repair_content}</td>
				<th>대수선 설치업체</th>
				<td>${facility.major_repair_installer}</td>
			</tr>
			<tr>
				<th rowspan="3">전동기</th>
				<th>형식</th>
				<td>${facility.electric_motor_form}</td>
				<th>회전수</th>
				<td>${facility.electric_motor_rpm}</td>
				<th>제작회사</th>
				<td colspan="3">${facility.electric_motor_production_company}</td>
			</tr>
			<tr>
				<th>용량</th>
				<td>${facility.electric_motor_volume}</td>
				<th>기동방법</th>
				<td>${facility.electric_motor_starting_method}</td>
				<th rowspan="2">모터 베어링 No.</th>
				<td>${facility.motor_bearing_no_1}</td>
				<th rowspan="2">펌프/감속기 베어링 No.</th>
				<td>${facility.pump_reducer_bearing_no_1}</td>
			</tr>
			<tr>
				<th>전원</th>
				<td>${facility.electric_motor_power}</td>
				<th>제작일자</th>
				<td>${facility.electric_motor_production_date}</td>
				<td>${facility.motor_bearing_no_2}</td>
				<td>${facility.pump_reducer_bearing_no_2}</td>
			</tr>
			<tr class="emptyTr">
				<td colspan="9" style="height: 15px;"></td>
			</tr>
			<tr>
				<td colspan="9" style="padding: 0px;">
					<table class="sub-table table table-sm table-bordered">
						<colgroup>
							<col style="width: 40%"/>
						</colgroup>
						<thead>
						<tr>
							<th>사진</th>
							<th colspan="6" class="end-col">기타설비 및 부속설비</th>
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
										<img id="facility_image_preview"
											 src="/preview?fileName=${facility.facility_image_path}" width="100%"
											 class="mb-2">
									</c:otherwise>
								</c:choose>
							</td>
							<th>순번</th>
							<th>품명</th>
							<th>제원</th>
							<th>수량</th>
							<th>제작회사</th>
							<th class="end-col">비고</th>
						</tr>
						<c:forEach var="subFacility" items="${subFacilities}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${subFacility.sub_facility_name}</td>
								<td>${subFacility.sub_facility_spec}</td>
								<td>${subFacility.sub_facility_quantity}</td>
								<td>${subFacility.sub_facility_production_company}</td>
								<td class="end-col">${subFacility.sub_facility_note}</td>
							</tr>
						</c:forEach>
						<c:forEach var="i" begin="${fn:length(subFacilities)}" end="7">
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td class="end-col"></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</td>
			</tr>
			</tbody>
		</table>
		<c:set var="today"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /></c:set>
		<div>출력일자 : ${today}</div>
	</div>
</div>
</c:if>

<c:if test='${param.print_repair_list}'>
<c:forEach var="repair" items="${repairs}" varStatus="status">
<c:if test="${status.index % 18 eq 0}">
<div class="page">
	<div class="subpage">
		<table class="table table-sm table-bordered">
			<thead>
			<tr>
				<th class="title" colspan="9">설비명 : ${facility.facility_name} / TAG NO. : ${facility.facility_tag_no}</th>
			</tr>
			<tr>
				<th class="title" colspan="5">수리내역목록</th>
				<c:set var="today"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /></c:set>
				<th class="print-date" colspan="4">출력일자 : ${today}</th>
			</tr>
			<tr>
				<th>NO</th>
				<th>수리일자</th>
				<th>수리내역</th>
				<th>고장원인</th>
				<th>수리업체</th>
				<th>수리업체TEL</th>
				<th>수리금액</th>
				<th>담당자</th>
				<th>비고</th>
			</tr>
			</thead>
			<tbody>
</c:if>
			<tr>
				<td>${repair.repair_no}</td>
				<td>${repair.repair_date}</td>
				<td>${repair.repair_content}</td>
				<td>${repair.repair_cause}</td>
				<td>${repair.repair_company}</td>
				<td>${repair.repair_company_tel}</td>
				<td>${repair.repair_price}</td>
				<td>${repair.repair_manager}</td>
				<td>${repair.repair_note}</td>
			</tr>
<c:if test="${status.index % 18 eq 17}">
			</tbody>
		</table>
	</div>
</div>
</c:if>
</c:forEach>
</c:if>
