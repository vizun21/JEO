<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/voucher.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[년도]", "${session_year}");
		PutFieldText("[구분1]", "${voucher_type}");
		PutFieldText("[구분2]", "${voucher_type}");
		PutFieldText("[구분3]", "${voucher_type}");

		var voucher;
		$.ajax({
			type: "POST"
			, url: "/accounting/print/voucher"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				start_year: "${start_year}"
				, start_month: "${start_month}"
				, end_year: "${end_year}"
				, end_month: "${end_month}"
				, tran_io_type: "${io_type}"
				, return_voucher: "${return_voucher}"
			})
			, beforeSend: function () {
				$(".overlay").show();
			}
			, success: function (data) {
				if (data.length == 0) {
					alert("조회된 거래내역이 없습니다.");
					window.close();
				}

				voucher = data;

				CopyTableByCellAndPastePageEnd("tbl_cell5", voucher);
				sleep(sleepTime * voucher.length)
					.then(function () {
						fillVoucher(voucher);

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

	var voucherIndex = 0;
	function fillVoucher(voucher) {
		$.each(voucher, function (index, item) {
			PutClickFieldText("[증빙서번호]{{" + voucherIndex + "}}", item.transactions[0].tran_proof_numb);
			PutClickFieldText("[관명칭]{{" + voucherIndex + "}}", item.gwan_name);
			PutClickFieldText("[항명칭]{{" + voucherIndex + "}}", item.hang_name);
			PutClickFieldText("[목명칭]{{" + voucherIndex + "}}", item.mock_name);
			PutClickFieldText("[발의일]{{" + voucherIndex + "}}", item.tran_date);
			PutClickFieldText("[현금출납부등재]{{" + voucherIndex + "}}", item.tran_date);
			PutClickFieldText("[총계정원장등재]{{" + voucherIndex + "}}", item.tran_date);
			var tran_price = 0;
			var tran_jukyo = "";
			var tran_note = "";
			$.each(item.transactions, function (trIndex, transaction) {
				tran_price += transaction.tran_price;
				tran_jukyo += "[" + transaction.tran_proof_numb + "] " + transaction.tran_jukyo + " : " + transaction.tran_price.comma() + (item.transactions.length - 1 != trIndex ? "\r\n" : "");
				tran_note += isNotNull(transaction.tran_note) ? "[" + transaction.tran_proof_numb + "] " + transaction.tran_note + (item.transactions.length - 1 != trIndex ? "\r\n" : "") : "";
			});
			PutClickFieldText("[한글금액]{{" + voucherIndex + "}}", tran_price.ko());
			PutClickFieldText("[금액]{{" + voucherIndex + "}}", tran_price.comma());
			PutClickFieldText("[적요]{{" + voucherIndex + "}}", tran_jukyo);
			PutClickFieldText("[비고]{{" + voucherIndex + "}}", tran_note);

			voucherIndex++;
		});
	}
</script>
