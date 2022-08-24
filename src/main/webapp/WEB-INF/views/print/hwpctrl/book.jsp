<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/book.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[년도]", "${session_year}");
		PutFieldText("[시작년도]", "${start_year}");
		PutFieldText("[시작월]", "${start_month}");
		PutFieldText("[종료년도]", "${end_year}");
		PutFieldText("[종료월]", "${end_month}");

		$(".overlay").show();
		setTimeout(function () {
			/* 세입결산서 */
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
				, async: false
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
					InsertTableData("tbl_cell1", dataList);

					PutFieldText("[세입예산액]", budg_total.comma());
					PutFieldText("[세입예산현액]", current_budg_total.comma());
					PutFieldText("[수납액]", tran_total.comma());
					PutFieldText("[미납액]", balance_total.comma());
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 세출결산서 */
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
					, io_type: "O"
				})
				, async: false
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
					InsertTableData("tbl_cell2", dataList);

					PutFieldText("[세출예산액]", budg_total.comma());
					PutFieldText("[세출예산현액]", current_budg_total.comma());
					PutFieldText("[지출액]", tran_total.comma());
					PutFieldText("[잔액]", balance_total.comma());
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 현금출납장 */
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
				, async: false
				, success: function (data) {
					// 표선택 및 기본틀 복사
					CopyTableByCell("tbl_cell3");

					$.each(data, function (index, item) {
						PutFieldText("[년]{{" + index + "}}", item.year);
						PutFieldText("[월]{{" + index + "}}", item.month);

						var input_total = 0;
						var output_total = 0;

						var dataList = [];
						$.each(item.transactions, function (trIndex, transaction) {
							input_total += Number(transaction.tran_input_price);
							output_total += Number(transaction.tran_output_price);
							dataList.push(new Array(
								transaction.tran_date
								, transaction.tran_proof_numb
								, transaction.mock_name
								, transaction.tran_jukyo
								, transaction.tran_input_price.comma()
								, transaction.tran_output_price.comma()
							));
						});
						InsertTableData("tbl_cell3{{" + index + "}}", dataList);

						PutFieldText("[수입금액 합계]{{" + index + "}}", input_total.comma());
						PutFieldText("[지출금액 합계]{{" + index + "}}", output_total.comma());

						// 기본틀 붙여넣기 (마지막 제외)
						if (index != data.length - 1) {
							PastePageEnd();
						}
					});
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			var generalLedger;
			/* 총계정원장 */
			$.ajax({
				type: "POST"
				, url: "/accounting/budget-settlement/general-ledger/${start_year}/${start_month}"
				, headers: {"Content-Type": "application/json"}
				, async: false
				, success: function (data) {
					generalLedger = data;
					console.log(generalLedger);
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 수입결의서 */
			var revenueVoucher;
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
					, tran_io_type: "I"
					, return_voucher: "N"
				})
				, async: false
				, success: function (data) {
					revenueVoucher = data;
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 지출결의서 */
			var expenditureVoucher;
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
					, tran_io_type: "O"
					, return_voucher: "N"
				})
				, async: false
				, success: function (data) {
					expenditureVoucher = data;
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 수입반납결의서 */
			var returnedRevenueVoucher;
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
					, tran_io_type: "I"
					, return_voucher: "Y"
				})
				, async: false
				, success: function (data) {
					returnedRevenueVoucher = data;
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 지출반납결의서 */
			var returnedExpenditureVoucher;
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
					, tran_io_type: "O"
					, return_voucher: "Y"
				})
				, async: false
				, success: function (data) {
					returnedExpenditureVoucher = data;
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			CopyTableByCellAndPastePageEnd("tbl_cell4", generalLedger);
			sleep(sleepTime * generalLedger.length)
				.then(function () {
					fillGeneralLedger(generalLedger);

					CopyTableByCellAndPastePageEnd("tbl_cell5", revenueVoucher);
					sleep(sleepTime * revenueVoucher.length)
						.then(function () {
							fillVoucher(revenueVoucher);

							CopyTableByCellAndPastePageEnd("tbl_cell6", expenditureVoucher);
							sleep(sleepTime * expenditureVoucher.length)
								.then(function () {
									fillVoucher(expenditureVoucher);

									CopyTableByCellAndPastePageEnd("tbl_cell7", returnedRevenueVoucher);
									sleep(sleepTime * returnedRevenueVoucher.length)
										.then(function () {
											fillVoucher(returnedRevenueVoucher);

											CopyTableByCellAndPastePageEnd("tbl_cell8", returnedExpenditureVoucher);
											sleep(sleepTime * returnedExpenditureVoucher.length)
												.then(function () {
													fillVoucher(returnedExpenditureVoucher);

													pHwpCtrl.Run("MovePageEnd");
													pHwpCtrl.Run("MoveSelDown");
													pHwpCtrl.Run("DeleteBack");
													pHwpCtrl.MovePos(2);
													$(".overlay").hide();
													$("#HwpCtrl").show();
												});
										});
								});
						});
				});
		}, 0);
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
			InsertTableData("tbl_cell4{{" + index + "}}", dataList);

			PutClickFieldText("[수입금액월계]{{" + index + "}}", item.input_tran_amount.comma());
			PutClickFieldText("[지출금액월계]{{" + index + "}}", item.output_tran_amount.comma());
			PutClickFieldText("[수입금액누계]{{" + index + "}}", item.input_accumulated_amount.comma());
			PutClickFieldText("[지출금액누계]{{" + index + "}}", item.output_accumulated_amount.comma());
			PutClickFieldText("[목별잔액]{{" + index + "}}", item.balance.comma());
		});
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
