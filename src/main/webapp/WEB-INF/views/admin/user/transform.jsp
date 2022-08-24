<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-xl-2 col-md-3 col-sm-4">
						<div class="form-group">
							<select class="select2" id="comp_type" data-minimum-results-for-search="Infinity" style="width: 100%;">
								<option value="">사업구분선택</option>
								<option value="P">개인</option>
								<option value="C">법인</option>
							</select>
						</div>
					</div>
					<div class="col-xl-10 col-md-9 col-sm-8">
						<div class="form-group">
							<div class="input-group input-group-md">
								<select class="select2" id="keyword_column" data-minimum-results-for-search="Infinity" style="width: 180px;">
									<option value="comp_name">사업자명</option>
								</select>
								<input type="search" class="form-control" id="keyword" placeholder="검색어 입력">
								<div class="input-group-append">
									<button type="button" class="btn btn-md btn-default" id="btnSearch">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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
										<th>코드</th>
										<th>사업구분</th>
										<th>사업자번호</th>
										<th>사업자명</th>
										<th>만료일자</th>
										<th>대표ID</th>
										<th>대표자</th>
										<th>대표이메일</th>
										<th>대표핸드폰</th>
										<th>전환</th>
										<th>등록일</th>
										<th>수정일</th>
										<th>최종수정자</th>
									</tr>
									</thead>
									<tbody></tbody>
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
		var maxIndex = $("#listTable th").length - 1
		var args = {
			hideColumns: [maxIndex-2, maxIndex-1, maxIndex]
			, orderColumns: [[4, "asc"]]
			, useColvis: true
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#comp_type, #comp_appr_yn").on("change", function () {
		getPage();
	});

	function getPage() {
		$(".overlay").show();

		$.ajax({
			type: "POST"
			, url: "/comp/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				comp_type: $("#comp_type").val()
				, comp_appr_yn: 'Y'
				, keyword_column: $("#keyword_column").val()
				, keyword: $("#keyword").val()
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				$.each(data, function(index, item) {
					var html = [];
					html.push("");	// dtr-control 위치
					html.push(item.comp_code);
					html.push(item.comp_type_name);
					html.push(item.comp_reg_numb);
					html.push(item.comp_name);
					html.push(item.comp_exp_date);
					html.push(item.ceo_id);
					html.push(item.ceo_name);
					html.push(item.ceo_email);
					html.push(item.ceo_mobile);
					html.push("<button type='button' class='btn btn-xs btn-warning' onclick=\"userTransform('" + item.ceo_id + "')\"><i class='fas fa-sync'></i> 전환</button>");
					html.push(item.comp_reg_date);
					html.push(item.comp_mod_date);
					html.push(item.comp_mod_user_name);

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();

				$("input[name=tb_check_all]").prop("checked", false);
				$("input[name=tb_check_list]").on("change", function () {
					syncCheckbox("listTable");
				});

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function userTransform(user_id) {
		$.ajax({
			type: "POST"
			, url: "/admin/user/transform"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({
				user_id: user_id
			})
			, success: function (data) {
				if (data == "success") {
					self.location = "/";
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>