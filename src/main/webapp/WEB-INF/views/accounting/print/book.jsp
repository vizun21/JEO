<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<select class="select2" id="year" data-minimum-results-for-search="Infinity" style="width: 180px;">
						<c:set var="year"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /></c:set>
						<c:forEach var="y" begin="2000" end="${year + 1}">
							<option value="${y}" ${y eq year ? 'selected' : ''}>${y}년</option>
						</c:forEach>
					</select>
					<select class="select2" id="month" data-minimum-results-for-search="Infinity" style="width: 180px;">
						<c:set var="month"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="MM" /></c:set>
						<c:forEach var="m" begin="1" end="12">
							<option value="${m}" ${m eq month ? 'selected' : ''}>${m}월</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<button class="btn bg-gradient-info mb-2" onclick="windowOpen('/print/hwpctrl/book');">전체출력</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/settlement/revenue');">세입결산서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/settlement/expenditure');">세출결산서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/transaction');">현금출납장</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/general_ledger');">총계정원장</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/voucher/revenue');">수입결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/voucher/expenditure');">지출결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/return/voucher/revenue');">수입반납결의서</button>
						<button class="btn btn-default mb-2" onclick="windowOpen('/print/hwpctrl/return/voucher/expenditure');">지출반납결의서</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	function windowOpen(url) {
		window.open("about:blank").location.href = url + "?start_year=" + $("#year").val() + "&start_month=" + $("#month").val()
	}
</script>