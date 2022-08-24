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
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<div class="form-inline">
							<button class="btn btn-default mb-2 mr-sm-2" onclick="windowOpen('/print/hwpctrl/budget_report');">예산보고서</button>

							<button class="btn btn-default mb-2 mr-sm-2" onclick="windowOpen('/print/hwpctrl/budget_revenue');">세입예산서</button>
							<button class="btn btn-default mb-2 mr-sm-2" onclick="windowOpen('/print/hwpctrl/budget_expenditure');">세출예산서</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<div class="form-inline">
							<div class="input-group mb-2 mr-sm-2">
								<select class="select2" id="revenue_budg_type" data-minimum-results-for-search="Infinity" style="width: 120px;">
									<option value="0">본예산</option>
									<c:forEach var="budg_type" begin="1" end="9">
										<option value="${budg_type}">${budg_type}차추경</option>
									</c:forEach>
								</select>
								<div class="input-group-append">
									<button class="btn btn-default" onclick="javascript:window.open('about:blank').location.href='/print/hwpctrl/supplementary_budget_revenue?year=' + $('#year').val() + '&budg_type=' + $('#revenue_budg_type').val()">세입예산서</button>
								</div>
							</div>

							<div class="input-group mb-2 mr-sm-2">
								<select class="select2" id="expenditure_budg_type" data-minimum-results-for-search="Infinity" style="width: 120px;">
									<option value="0">본예산</option>
									<c:forEach var="budg_type" begin="1" end="9">
										<option value="${budg_type}">${budg_type}차추경</option>
									</c:forEach>
								</select>
								<div class="input-group-append">
									<button class="btn btn-default" onclick="javascript:window.open('about:blank').location.href='/print/hwpctrl/supplementary_budget_expenditure?year=' + $('#year').val() + '&budg_type=' + $('#expenditure_budg_type').val()">세출예산서</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	function windowOpen(url) {
		window.open("about:blank").location.href = url + "?year=" + $("#year").val()
	}
</script>
