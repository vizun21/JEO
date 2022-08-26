<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<div class="row">
							<div class="col-md-5">
								<div class="float-left">
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"excel"});'><i class="far fa-file-excel"></i> 엑셀</button>
									<button type="button" class="btn btn-sm btn-default" onclick='datatablesButtonTrigger({tableID:"listTable", extend:"print"});'><i class="fas fa-print"></i> 인쇄</button>
								</div>
							</div>
							<div class="col-md-2" id="listTable_colvis"></div>
							<div class="col-md-5"></div>
						</div>
						<div class="row">
							<div class="col-12">
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;">
									<thead>
									<tr>
										<th class="no_toggle"></th>	<%-- dtr-control 위치 --%>
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
									<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td></td>
											<td>${status.count}</td>
											<td>${result.facility_name}</td>
											<td>${result.construction_code}</td>
											<td>${result.category_code}</td>
											<td>${result.facility_tag_no}</td>
											<td>${result.emplacement}</td>
											<td>${result.facility_quantity}</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var args = {
			orderColumns: [[2, "asc"]]
		}
		setDatatables("listTable", args);

		$("#listTable").DataTable().columns.adjust().draw();
	});
</script>
