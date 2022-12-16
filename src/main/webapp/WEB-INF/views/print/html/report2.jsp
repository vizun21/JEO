<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	.cover {
		font-size: 11pt;
		text-align: center;
	}
</style>

<c:if test='${param.print_report_cover}'>
<div class="page">
	<div class="subpage">
		<table class="cover table table-sm table-bordered" style="height: 100%;">
			<colgroup>
				<col style="width: 50%;">
				<col style="width: 50%;">
			</colgroup>
			<thead>
			<tr style="height: 100px!important;border-bottom: white 1px solid;">
				<th style="border-right: white 1px solid;">전주환경사업소</th>
				<c:set var="today"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /></c:set>
				<th>출력일자 : ${today}</th>
			</tr>
			<tr style="height: 150px!important;border-bottom: white 1px solid;">
				<th colspan="2">
					<h3>시 설 물 관 리 현 황 보 고 서</h3>
				</th>
			</tr>
			</thead>
			<tbody>
			<tr style="border-bottom: white 1px solid;">
				<td colspan="2">
					<div style="width: 40%;margin: auto;text-align: left;">
						<div style="width: 20%;float: left;">
							문서번호 :
							<br><br>
							보고일자 :
							<br><br>
							담 당 자 :
						</div>
						<div style="width: 80%;float: right;text-align: center!important;">
							${report_no}
							<br><br>
							${today}
							<br><br>
							${loginVO.user_name}
						</div>
					</div>
				</td>
			</tr>
			</tbody>
			<tfoot>
			<tr style="height: 200px!important;">
				<th colspan="2">
					<h4>전 주 환 경 사 업 소</h4>
				</th>
			</tr>
			</tfoot>
		</table>
	</div>
</div>
</c:if>

<c:if test='${param.print_facility_spec}'>
	<c:forEach var="facility" items="${facilities}" varStatus="status">
		<c:if test="${status.index % 19 eq 0}">
			<div class="page">
				<div class="subpage">
					<table class="table table-sm table-bordered">
					<thead>
					<tr>
						<th class="title" colspan="5">설비이력목록</th>
						<c:set var="today"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd" /></c:set>
						<th class="print-date" colspan="2">출력일자 : ${today}</th>
					</tr>
					<tr>
						<th>NO</th>
						<th>설비명</th>
						<th>공종</th>
						<th>구분</th>
						<th>TAG NO.</th>
						<th>설치장소</th>
						<th>수량</th>
					</tr>
					</thead>
					<tbody>
		</c:if>
					<tr>
						<td>${fn:length(facilities) - status.index}</td>
						<td>${facility.facility_name}</td>
						<td class="text-nowrap">${facility.construction_name}</td>
						<td class="text-nowrap">${facility.category_name}</td>
						<td class="text-nowrap">${facility.facility_tag_no}</td>
						<td>${facility.emplacement}</td>
						<td>${facility.facility_quantity}</td>
					</tr>
		<c:if test="${(status.index % 19 ne 18 and status.index + 1 == fn:length(facilities)) or status.index % 19 eq 18}">
					</tbody>
					</table>
				</div>
			</div>
		</c:if>
	</c:forEach>
</c:if>

<c:if test='${param.print_repair_list2}'>
<c:forEach var="facilityRepair" items="${facilityRepairHistory}">
<c:forEach var="repair" items="${facilityRepair.repairs}" varStatus="repairStatus">
<c:if test="${repairStatus.index % 18 eq 0}">
<div class="page">
	<div class="subpage">
		<table class="table table-sm table-bordered">
			<thead>
			<tr>
				<th class="title" colspan="9">설비명 : ${facilityRepair.facility_name} / TAG NO. : ${facilityRepair.facility_tag_no}</th>
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
				<td class="text-nowrap">${repair.repair_date}</td>
				<td>${repair.repair_content}</td>
				<td>${repair.repair_cause}</td>
				<td>${repair.repair_company}</td>
				<td>${repair.repair_company_tel}</td>
				<td>${repair.repair_price}</td>
				<td>${repair.repair_manager}</td>
				<td>${repair.repair_note}</td>
			</tr>
<c:if test="${(repairStatus.index % 18 ne 17 and repairStatus.index + 1 == fn:length(facilityRepair.repairs)) or repairStatus.index % 18 eq 17}">
			</tbody>
		</table>
	</div>
</div>
</c:if>
</c:forEach>
</c:forEach>
</c:if>
