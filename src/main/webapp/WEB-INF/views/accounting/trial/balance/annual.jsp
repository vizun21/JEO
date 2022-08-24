<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	#listTable tfoot th {text-align: right;}
</style>

<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-12">
				<div class="form-group">
					<select class="select2" id="year" data-minimum-results-for-search="Infinity" style="width: 150px;">
						<c:forEach var="ghm_year" items="${ghm_year_list}">
							<option value="${ghm_year.ghm_year}">${ghm_year.ghm_year}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						<h3 id="frm_title"></h3>
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
								<table id="listTable" class="table-list table table-sm table-bordered table-hover" style="display: none;font-size: small">
									<thead>
									<tr>
										<th>구분</th>
										<th>코드</th>
										<th>계정명</th>
										<th>예산액</th>
										<th>결산액</th>
										<th>비율</th>
										<th><span id="title_1"></span></th>
										<th><span id="title_2"></span></th>
										<th><span id="title_3"></span></th>
										<th><span id="title_4"></span></th>
										<th><span id="title_5"></span></th>
										<th><span id="title_6"></span></th>
										<th><span id="title_7"></span></th>
										<th><span id="title_8"></span></th>
										<th><span id="title_9"></span></th>
										<th><span id="title_10"></span></th>
										<th><span id="title_11"></span></th>
										<th><span id="title_12"></span></th>
										<th>합계</th>
									</tr>
									</thead>
									<tbody></tbody>
									<tfoot>
									<tr>
										<th colspan="3">세입합계</th>
										<th><span id="input_budg_total"></span></th>
										<th><span id="input_tran_total"></span></th>
										<th></th>
										<th><span id="input_tran_sub_amount0"></span></th>
										<th><span id="input_tran_sub_amount1"></span></th>
										<th><span id="input_tran_sub_amount2"></span></th>
										<th><span id="input_tran_sub_amount3"></span></th>
										<th><span id="input_tran_sub_amount4"></span></th>
										<th><span id="input_tran_sub_amount5"></span></th>
										<th><span id="input_tran_sub_amount6"></span></th>
										<th><span id="input_tran_sub_amount7"></span></th>
										<th><span id="input_tran_sub_amount8"></span></th>
										<th><span id="input_tran_sub_amount9"></span></th>
										<th><span id="input_tran_sub_amount10"></span></th>
										<th><span id="input_tran_sub_amount11"></span></th>
										<th><span id="input_total"></span></th>
									</tr>
									<tr>
										<th colspan="3">세출합계</th>
										<th><span id="output_budg_total"></span></th>
										<th><span id="output_tran_total"></span></th>
										<th></th>
										<th><span id="output_tran_sub_amount0"></span></th>
										<th><span id="output_tran_sub_amount1"></span></th>
										<th><span id="output_tran_sub_amount2"></span></th>
										<th><span id="output_tran_sub_amount3"></span></th>
										<th><span id="output_tran_sub_amount4"></span></th>
										<th><span id="output_tran_sub_amount5"></span></th>
										<th><span id="output_tran_sub_amount6"></span></th>
										<th><span id="output_tran_sub_amount7"></span></th>
										<th><span id="output_tran_sub_amount8"></span></th>
										<th><span id="output_tran_sub_amount9"></span></th>
										<th><span id="output_tran_sub_amount10"></span></th>
										<th><span id="output_tran_sub_amount11"></span></th>
										<th><span id="output_total"></span></th>
									</tr>
									<tr>
										<th colspan="3">잔액(세입합계-세출합계)</th>
										<th><span id="budg_total"></span></th>
										<th><span id="tran_total"></span></th>
										<th></th>
										<th><span id="tran_sub_amount0"></span></th>
										<th><span id="tran_sub_amount1"></span></th>
										<th><span id="tran_sub_amount2"></span></th>
										<th><span id="tran_sub_amount3"></span></th>
										<th><span id="tran_sub_amount4"></span></th>
										<th><span id="tran_sub_amount5"></span></th>
										<th><span id="tran_sub_amount6"></span></th>
										<th><span id="tran_sub_amount7"></span></th>
										<th><span id="tran_sub_amount8"></span></th>
										<th><span id="tran_sub_amount9"></span></th>
										<th><span id="tran_sub_amount10"></span></th>
										<th><span id="tran_sub_amount11"></span></th>
										<th><span id="total"></span></th>
									</tr>
									</tfoot>
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
			responsive: false
			, useColvis: false
			, paging: false
			, rowspan: [0]
			, excludeOrderColumns: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]
		}
		setDatatables("listTable", args);

		getPage();
	});

	$("#year").on("change", function () {
		getPage();
	})

	function getPage() {
		$(".overlay").show();

		var year = $("#year").val();
		var bsns_sess_start_month = ${businessVO.bsns_sess_start_month};

		var date = new Date(year, bsns_sess_start_month-1, 1);
		for (var i = 1; i <= 12; i++) {
			$("#title_"+i).html(date.getFullYear() + '년 ' + (date.getMonth()+1) + '월');
			date.setMonth(date.getMonth()+1);
		}

		$.ajax({
			type: "POST"
			, url: "/accounting/trial/balance/annual"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				session_year: $("#year").val()
				, session_start_month: ${businessVO.bsns_sess_start_month}
			})
			, success: function (data) {
				if($.fn.DataTable.isDataTable("#listTable")) {
					$("#listTable").DataTable().clear();
				}

				var input_budg_total = 0;
				var output_budg_total = 0;
				var input_tran_total = 0;
				var output_tran_total = 0;
				var input_tran_sub_amount = [0,0,0,0,0,0,0,0,0,0,0,0];
				var output_tran_sub_amount = [0,0,0,0,0,0,0,0,0,0,0,0];
				$.each(data, function(index, item) {
					var html = [];
					html.push(item.gwan_io_type_name);
					html.push(item.ghm_numb);
					html.push(item.mock_name);
					html.push("<div class='text-right'>" + item.bgdt_amount.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_amount.comma() + "</div>");
					html.push((item.bgdt_amount != 0 ? item.tran_amount/item.bgdt_amount*100 : 0).comma(1) + "%");
					html.push("<div class='text-right'>" + item.tran_sub_amount_1.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_2.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_3.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_4.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_5.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_6.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_7.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_8.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_9.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_10.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_11.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_sub_amount_12.comma() + "</div>");
					html.push("<div class='text-right'>" + item.tran_amount.comma() + "</div>");

					if (item.gwan_io_type == "I") {
						input_budg_total += Number(item.bgdt_amount);
						input_tran_total += Number(item.tran_amount);
						input_tran_sub_amount[0] += Number(item.tran_sub_amount_1);
						input_tran_sub_amount[1] += Number(item.tran_sub_amount_2);
						input_tran_sub_amount[2] += Number(item.tran_sub_amount_3);
						input_tran_sub_amount[3] += Number(item.tran_sub_amount_4);
						input_tran_sub_amount[4] += Number(item.tran_sub_amount_5);
						input_tran_sub_amount[5] += Number(item.tran_sub_amount_6);
						input_tran_sub_amount[6] += Number(item.tran_sub_amount_7);
						input_tran_sub_amount[7] += Number(item.tran_sub_amount_8);
						input_tran_sub_amount[8] += Number(item.tran_sub_amount_9);
						input_tran_sub_amount[9] += Number(item.tran_sub_amount_10);
						input_tran_sub_amount[10] += Number(item.tran_sub_amount_11);
						input_tran_sub_amount[11] += Number(item.tran_sub_amount_12);
					} else if (item.gwan_io_type == "O") {
						output_budg_total += Number(item.bgdt_amount);
						output_tran_total += Number(item.tran_amount);
						output_tran_sub_amount[0] += Number(item.tran_sub_amount_1);
						output_tran_sub_amount[1] += Number(item.tran_sub_amount_2);
						output_tran_sub_amount[2] += Number(item.tran_sub_amount_3);
						output_tran_sub_amount[3] += Number(item.tran_sub_amount_4);
						output_tran_sub_amount[4] += Number(item.tran_sub_amount_5);
						output_tran_sub_amount[5] += Number(item.tran_sub_amount_6);
						output_tran_sub_amount[6] += Number(item.tran_sub_amount_7);
						output_tran_sub_amount[7] += Number(item.tran_sub_amount_8);
						output_tran_sub_amount[8] += Number(item.tran_sub_amount_9);
						output_tran_sub_amount[9] += Number(item.tran_sub_amount_10);
						output_tran_sub_amount[10] += Number(item.tran_sub_amount_11);
						output_tran_sub_amount[11] += Number(item.tran_sub_amount_12);
					}

					$("#listTable").DataTable().row.add(html).node();
				});

				$("#listTable").DataTable().draw(false);
				$("#listTable").DataTable().columns.adjust().draw();	// 테이블 컬럼 사이즈 조절

				$("#input_budg_total").html(input_budg_total.comma());
				$("#output_budg_total").html(output_budg_total.comma());
				$("#budg_total").html((input_budg_total - output_budg_total).comma());
				$("#input_tran_total").html(input_tran_total.comma());
				$("#output_tran_total").html(output_tran_total.comma());
				$("#tran_total").html((input_tran_total - output_tran_total).comma());
				for (var i = 0; i < 12; i++) {
					console.log(input_tran_sub_amount[i]);
					$("#input_tran_sub_amount"+i).html(input_tran_sub_amount[i].comma());
					$("#output_tran_sub_amount"+i).html(output_tran_sub_amount[i].comma());
					$("#tran_sub_amount"+i).html((input_tran_sub_amount[i] - output_tran_sub_amount[i]).comma());
				}
				$("#input_total").html(input_tran_total.comma());
				$("#output_total").html(output_tran_total.comma());
				$("#total").html((input_tran_total - output_tran_total).comma());

				$(".overlay").hide();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

</script>
