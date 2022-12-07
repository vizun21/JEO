<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

<script>
	$(function () {
	});
</script>
