<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.table td {
		background-color: white;
	}
</style>
<div class="content p-3">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<h3>뱅크다 전체계좌</h3>
			</div>
		</div>
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
						<th>사업자코드</th>
						<th>사업자명</th>
						<th>계좌번호</th>
						<th>은행</th>
						<th>구분</th>
						<th>계좌상태</th>
						<th>등록일시</th>
						<th>최근조회일시</th>
						<th>계좌조회결과</th>
					</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script>
	$(function () {
		var args = {
			useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/admin/bankda/account/list"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.mid);
					html.push(item.mname);
					html.push(item.actaccountnum);
					html.push(item.bkname);
					html.push(item.accounttype);
					html.push(item.acttag);
					html.push(item.regdate);
					html.push(item.last_scraping_dtm);
					html.push(item.act_status);

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>