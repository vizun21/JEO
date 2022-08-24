<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/transaction.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		$.ajax({
			type: "POST"
			, url: "/accounting/print/transaction"
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
				if (data.length == 0) {
					alert("등록된 거래내역이 없습니다.");
					window.close();
				}

				// 기본틀 복사
				pHwpCtrl.Run("SelectAll");
				pHwpCtrl.Run("Copy");

				$.each(data, function (index, item) {
					PutFieldText("[년]{{" + index + "}}", item.year);
					PutFieldText("[월]{{" + index + "}}", item.month);

					var input_total = 0;
					var output_total = 0;

					var dataList = [];
					$.each(item.transactions, function (trIndex, transaction) {
						input_total += Number(transaction.tran_input_price);
						output_total += Number(transaction.tran_output_price);
						console.log(transaction);
						dataList.push(new Array(
							transaction.tran_date
							, transaction.tran_proof_numb
							, transaction.mock_name
							, transaction.tran_jukyo
							, transaction.tran_input_price.comma()
							, transaction.tran_output_price.comma()
						));
					});
					InsertTableData("tbl_cell{{" + index + "}}", dataList);

					PutFieldText("[수입금액 합계]{{" + index + "}}", input_total.comma());
					PutFieldText("[지출금액 합계]{{" + index + "}}", output_total.comma());

					// 기본틀 붙여넣기 (마지막 제외)
					if (index != data.length - 1) {
						pHwpCtrl.Run("MoveDocEnd");
						pHwpCtrl.Run("BreakPage");
						pHwpCtrl.Run("Paste");

					}
				});
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