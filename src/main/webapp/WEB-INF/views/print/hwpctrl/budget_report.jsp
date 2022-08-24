<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/budget_report.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[년도]", "${budg_year}");
		PutFieldText("[사업명]", "${businessVO.bsns_name}");

		if (pHwpCtrl.MoveToField("stamp", true, true, true)) {
			var path = BasePath + "/preview?fileName=${businessVO.bsns_seal}";
			pHwpCtrl.InsertPicture(path);
		}
		else {
			if (_DEBUG) alert("필드(" + "stamp" + ")가 존재하지 않습니다.");
		}

		$(".overlay").show();
		setTimeout(function () {
			var input_gwan = {};
			var output_gwan = {};

			$.ajax({
				type: "POST"
				, url: "/accounting/print/budget"
				, headers: {"Content-Type": "application/json"}
				, dataType: "json"
				, data: JSON.stringify({
					budg_year: "${budg_year}"
					, budg_type: "${last_budg_type}"
					, compare_budg_year: "${prev_budg_year}"
					, compare_budg_type: "${prev_last_budg_type}"
					, io_type: "I"
				})
				, async: false
				, success: function (data) {
					input_gwan = data;

					var budg_total = 0;
					var prev_budg_total = 0;
					var borrow_amount = 0;

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
								if (mock.mock_name.indexOf("차입금") != -1) borrow_amount += Number(mock.budg_amount);

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
					InsertTableData("tbl_cell3", dataList);

					PutFieldText("[세입예산액]", budg_total.comma());
					PutFieldText("[전년도세입예산액]", prev_budg_total.comma());
					PutFieldText("[세입증감액]", (budg_total - prev_budg_total).comma());
					PutFieldText("[세입예산액/1000]", (budg_total / 1000).comma());
					PutFieldText("[전년도세입예산액/1000]", (prev_budg_total / 1000).comma());
					PutFieldText("[세입증감액/1000]", ((budg_total - prev_budg_total) / 1000).comma());

					PutFieldText("[차입금]", borrow_amount.comma());
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			$.ajax({
				type: "POST"
				, url: "/accounting/print/budget"
				, headers: {"Content-Type": "application/json"}
				, dataType: "json"
				, data: JSON.stringify({
					budg_year: "${budg_year}"
					, budg_type: "${last_budg_type}"
					, compare_budg_year: "${prev_budg_year}"
					, compare_budg_type: "${prev_last_budg_type}"
					, io_type: "O"
				})
				, async: false
				, success: function (data) {
					output_gwan = data;

					var budg_total = 0;
					var prev_budg_total = 0;
					var reserve_amount = 0;

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
								if (mock.mock_name.indexOf("예비비") != -1) reserve_amount += Number(mock.budg_amount);

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
					InsertTableData("tbl_cell4", dataList);

					PutFieldText("[세출예산액]", budg_total.comma());
					PutFieldText("[전년도세출예산액]", prev_budg_total.comma());
					PutFieldText("[세출증감액]", (budg_total - prev_budg_total).comma());
					PutFieldText("[세출예산액/1000]", (budg_total / 1000).comma());
					PutFieldText("[전년도세출예산액/1000]", (prev_budg_total / 1000).comma());
					PutFieldText("[세출증감액/1000]", ((budg_total - prev_budg_total) / 1000).comma());

					PutFieldText("[예비비]", reserve_amount.comma());
				}
				, error: function (request, status, error) {
					alertAjaxError(request, status, error);
				}
			});

			/* 예산총괄표 : 세입/세출 표 길이가 같도록 더 많은 쪽을 기준으로 줄을 맞춰줌 */
			var maxGwanLen = input_gwan.length > output_gwan.length ? input_gwan.length : output_gwan.length;
			var inputGwanSummaryList = [];
			var outputGwanSummaryList = [];
			for (var i = 0; i < maxGwanLen; i++) {
				inputGwanSummaryList.push(
					input_gwan[i] == null ? new Array("", "", "", "")
						: new Array(
							input_gwan[i].gwan_name
							, input_gwan[i].budg_amount.comma()
							, input_gwan[i].prev_budg_amount.comma()
							, (input_gwan[i].budg_amount - input_gwan[i].prev_budg_amount).comma()));

				outputGwanSummaryList.push(
					output_gwan[i] == null ? new Array("", "", "", "")
						: new Array(
						output_gwan[i].gwan_name
						, output_gwan[i].budg_amount.comma()
						, output_gwan[i].prev_budg_amount.comma()
						, (output_gwan[i].budg_amount - output_gwan[i].prev_budg_amount).comma()));
			}
			InsertTableData("tbl_cell1", inputGwanSummaryList);
			InsertTableData("tbl_cell2", outputGwanSummaryList);

			pHwpCtrl.MovePos(2);
			$(".overlay").hide();
			$("#HwpCtrl").show();
		}, 0);
	});
</script>
