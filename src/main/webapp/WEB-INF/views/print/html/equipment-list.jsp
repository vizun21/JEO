<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

<script>
	$(function () {
	});
</script>
