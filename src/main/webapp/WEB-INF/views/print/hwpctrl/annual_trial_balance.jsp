<script>
	$(function () {
		var filePath = BasePath + "/resources/files/docs/annual_trial_balance.hwp";
		if (!pHwpCtrl.Open(filePath)) {
			alert("파일경로가 잘못 지정된 것 같습니다. 파일경로를 확인하여 주세요");
			window.close();
		}

		PutFieldText("[년도]", "${session_year}");

		var year = ${session_year};
		var bsns_sess_start_month = ${businessVO.bsns_sess_start_month};
		var date = new Date(year, bsns_sess_start_month-1, 1);
		for (var i = 1; i <= 12; i++) {
			PutFieldText("[title" + i + "]", date.getFullYear() + '년 ' + (date.getMonth()+1) + '월');
			date.setMonth(date.getMonth()+1);
		}

		$.ajax({
			type: "POST"
			, url: "/accounting/trial/balance/annual"
			, headers: {"Content-Type": "application/json"}
			, dataType: "json"
			, data: JSON.stringify({
				session_year: ${session_year}
				, session_start_month: ${businessVO.bsns_sess_start_month}
			})
			, beforeSend: function () {
				$(".overlay").show();
			}
			, success: function (data) {
				var input_budg_total = 0;
				var output_budg_total = 0;
				var input_tran_total = 0;
				var output_tran_total = 0;
				var input_tran_sub_amount = [0,0,0,0,0,0,0,0,0,0,0,0];
				var output_tran_sub_amount = [0,0,0,0,0,0,0,0,0,0,0,0];

				var dataList = [];
				$.each(data, function (index, item) {
					dataList.push(new Array(
						item.gwan_io_type_name
						, item.ghm_numb
						, item.mock_name
						, item.bgdt_amount.comma()
						, item.tran_amount.comma()
						, (item.bgdt_amount != 0 ? item.tran_amount/item.bgdt_amount*100 : 0).comma(1) + "%"
						, item.tran_sub_amount_1.comma()
						, item.tran_sub_amount_2.comma()
						, item.tran_sub_amount_3.comma()
						, item.tran_sub_amount_4.comma()
						, item.tran_sub_amount_5.comma()
						, item.tran_sub_amount_6.comma()
						, item.tran_sub_amount_7.comma()
						, item.tran_sub_amount_8.comma()
						, item.tran_sub_amount_9.comma()
						, item.tran_sub_amount_10.comma()
						, item.tran_sub_amount_11.comma()
						, item.tran_sub_amount_12.comma()
						, item.tran_amount.comma()
					));

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

				});
				InsertTableData("tbl_cell", dataList);

				PutFieldText("[세입예산합]", input_budg_total.comma());
				PutFieldText("[세출예산합]", output_budg_total.comma());
				PutFieldText("[예산차액]", (input_budg_total - output_budg_total).comma());
				PutFieldText("[세입결산합]", input_tran_total.comma());
				PutFieldText("[세출결산합]", output_tran_total.comma());
				PutFieldText("[결산차액]", (input_tran_total - output_tran_total).comma());

				for (var i = 1; i <= 12; i++) {
					console.log(input_tran_sub_amount[i]);
					PutFieldText("[세입합계" + i + "]", input_tran_sub_amount[i-1].comma());
					PutFieldText("[세출합계" + i + "]", output_tran_sub_amount[i-1].comma());
					PutFieldText("[차액" + i + "]", (input_tran_sub_amount[i-1] - output_tran_sub_amount[i-1]).comma());
				}

				PutFieldText("[세입총합계]", input_tran_total.comma());
				PutFieldText("[세출총합계]", output_tran_total.comma());
				PutFieldText("[총차액]", (input_tran_total - output_tran_total).comma());
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
