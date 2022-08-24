<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/trial_balance.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[시작년도]", "${start_year}");
		PutFieldText("[시작월]", "${start_month}");
		PutFieldText("[종료년도]", "${end_year}");
		PutFieldText("[종료월]", "${end_month}");

		$.ajax({
			type: "POST"
			, url: "/accounting/trial/balance/total"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				start_year: "${start_year}"
				, start_month: "${start_month}"
				, end_year: "${end_year}"
				, end_month: "${end_month}"
			})
			, beforeSend: function () {
				$(".overlay").show();
			}
			, success: function (data) {
				var input_tran_balance = 0;
				var input_tran_total_balance = 0;
				var output_tran_total_balance = 0;
				var output_tran_balance = 0;

				var dataList = [];
				$.each(data, function (index, item) {
					input_tran_balance += Number(item.input_tran_total);
					input_tran_total_balance += Number(item.input_tran_amount);
					output_tran_total_balance += Number(item.output_tran_amount);
					output_tran_balance += Number(item.output_tran_total);

					dataList.push(new Array(
						item.input_tran_total.comma()
						, item.input_tran_amount.comma()
						, item.ghm_name
						, item.output_tran_amount.comma()
						, item.output_tran_total.comma()
					));

				});
				InsertTableData("tbl_cell", dataList);

				PutFieldText("[수입누계합]", input_tran_balance.comma());
				PutFieldText("[수입금액합]", input_tran_total_balance.comma());
				PutFieldText("[지출금액합]", output_tran_total_balance.comma());
				PutFieldText("[지출누계합]", output_tran_balance.comma());
				PutFieldText("[누계차액]", (input_tran_balance - output_tran_balance).comma());
				PutFieldText("[금액차액]", (input_tran_total_balance - output_tran_total_balance).comma());
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
