<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/budget_expenditure.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[년도]", "${session_year}");

		$.ajax({
			type: "POST"
			, url: "/accounting/print/budget"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				budg_year: "${session_year}"
				, budg_type: "${last_budg_type}"
				, compare_budg_year: "${prev_budg_year}"
				, compare_budg_type: "${prev_last_budg_type}"
				, io_type: "${io_type}"
			})
			, beforeSend: function () {
				$(".overlay").show();
			}
			, success: function (data) {
				console.log(data);
				var budg_total = 0;
				var prev_budg_total = 0;

				var dataList = [];
				$.each(data, function (index, gwan) {
					budg_total += Number(gwan.budg_amount);
					prev_budg_total += Number(gwan.prev_budg_amount);

					dataList.push(new Array(
						gwan.gwan_numb
						, "MERGE"
						, "MERGE"
						, gwan.gwan_name
						, gwan.budg_amount.comma()
						, gwan.prev_budg_amount.comma()
						, (gwan.budg_amount - gwan.prev_budg_amount).comma()
					));
					$.each(gwan.hang, function (index, hang) {
						dataList.push(new Array(
							"MERGE"
							, gwan.gwan_numb + hang.hang_numb
							, "MERGE"
							, hang.hang_name
							, hang.budg_amount.comma()
							, hang.prev_budg_amount.comma()
							, (hang.budg_amount - hang.prev_budg_amount).comma()
						));
						$.each(hang.mock, function (mindex, mock) {
							dataList.push(new Array(
								"MERGE"
								, "MERGE"
								, gwan.gwan_numb + hang.hang_numb + mock.mock_numb
								, mock.mock_name
								, mock.budg_amount.comma()
								, mock.prev_budg_amount.comma()
								, (mock.budg_amount - mock.prev_budg_amount).comma()
								, mock.content
							));
						});
					});
				});
				InsertTableData("tbl_cell", dataList);

				PutFieldText("[예산합계]", budg_total.comma());
				PutFieldText("[이전예산합계]", prev_budg_total.comma());
				PutFieldText("[차액]", (budg_total - prev_budg_total).comma());
			}
			, complete: function () {
				pHwpCtrl.MovePos(2);
				$(".overlay").hide();
				$("#HwpCtrl").show();
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

	});
</script>
