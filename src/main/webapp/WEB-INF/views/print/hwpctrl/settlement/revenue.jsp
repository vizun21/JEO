<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/settlement_revenue.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[년도]", "${session_year}");
		PutFieldText("[시작년도]", "${start_year}");
		PutFieldText("[시작월]", "${start_month}");
		PutFieldText("[종료년도]", "${end_year}");
		PutFieldText("[종료월]", "${end_month}");

		$.ajax({
			type: "POST"
			, url: "/accounting/settlement/page"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				start_year: "${start_year}"
				, start_month: "${start_month}"
				, end_year: "${end_year}"
				, end_month: "${end_month}"
				, io_type: "I"
			})
			, beforeSend: function () {
				$(".overlay").show();
			}
			, success: function (data) {
				var budg_total = 0;
				var current_budg_total = 0;
				var tran_total = 0;
				var balance_total = 0;

				var dataList = [];
				$.each(data, function (index, item) {
					var budg_amount = Number(item.budg_amount);
					var prev_tran_amount = Number(item.prev_tran_amount);
					var tran_amount = Number(item.tran_amount);
					var current_budg_amount = budg_amount - prev_tran_amount;
					var balance = current_budg_amount - tran_amount;

					dataList.push(new Array(
						item.gwan_numb
						, item.gwan_name
						, item.gwan_numb + item.hang_numb
						, item.hang_name
						, item.gwan_numb + item.hang_numb + item.mock_numb
						, item.mock_name
						, budg_amount.comma()
						, current_budg_amount.comma()
						, tran_amount.comma()
						, balance.comma()
					));

					budg_total += budg_amount;
					current_budg_total += current_budg_amount;
					tran_total += tran_amount;
					balance_total += balance;
				});
				InsertTableData("tbl_cell", dataList);

				PutFieldText("[예산액]", budg_total.comma());
				PutFieldText("[예산현액]", current_budg_total.comma());
				PutFieldText("[수납액]", tran_total.comma());
				PutFieldText("[미납액]", balance_total.comma());
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