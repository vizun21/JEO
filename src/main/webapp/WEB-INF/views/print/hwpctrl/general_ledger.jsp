<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/general_ledger.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		var generalLedger;
		$.ajax({
			type: "POST"
			, url: "/accounting/budget-settlement/general-ledger/${start_year}/${start_month}/${end_year}/${end_month}"
			, headers: {"Content-Type": "application/json"}
			, beforeSend: function () {
				$(".overlay").show();
			}
			, success: function (data) {
				if (data.length == 0) {
					alert("등록된 거래내역이 없습니다.");
					window.close();
				}

				generalLedger = data;

				CopyTableByCellAndPastePageEnd("tbl_cell", generalLedger);
				sleep(sleepTime * generalLedger.length)
					.then(function () {
						fillGeneralLedger(generalLedger);

						pHwpCtrl.Run("MoveDocEnd");
						pHwpCtrl.Run("DeleteBack");
						pHwpCtrl.MovePos(2);
						$(".overlay").hide();
						$("#HwpCtrl").show();
					});
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});

	});

	function CopyTableByCellAndPastePageEnd(cellName, data) {
		if (data.length == 0) {
			DeleteTableByCell(cellName);
			return;
		}

		CopyTableByCell(cellName);
		for (var i = 0; i < data.length - 1; i++) {
			sleep(sleepTime).then(function () {
				PastePageEnd();
			});
		}
	}

	function fillGeneralLedger(generalLedger) {
		$.each(generalLedger, function (index, item) {
			PutClickFieldText("[목명]{{" + index + "}}", item.mock_name);
			PutClickFieldText("[목별예산현액]{{" + index + "}}", item.current_budg_amount.comma());

			// 데이터 채우기
			var dataList = [];
			$.each(item.generalLedgerDetails, function (trIndex, details) {
				dataList.push(new Array(
					details.tran_date
					, details.tran_proof_numb
					, details.tran_jukyo
					, ""
					, details.tran_input_price.comma()
					, details.tran_output_price.comma()
					, ""
				));
			});
			InsertTableData("tbl_cell{{" + index + "}}", dataList);

			PutClickFieldText("[수입금액월계]{{" + index + "}}", item.input_tran_amount.comma());
			PutClickFieldText("[지출금액월계]{{" + index + "}}", item.output_tran_amount.comma());
			PutClickFieldText("[수입금액누계]{{" + index + "}}", item.input_accumulated_amount.comma());
			PutClickFieldText("[지출금액누계]{{" + index + "}}", item.output_accumulated_amount.comma());
			PutClickFieldText("[목별잔액]{{" + index + "}}", item.balance.comma());
		});
	}
</script>
