var lang_kor = {
	decimal : ""
	, emptyTable : "조회된 데이터가 없습니다."
	, info : "_START_ - _END_ (총 _TOTAL_ 개)"
	, infoEmpty : "0 개"
	, infoFiltered : "(전체 _MAX_ 개 중 검색결과)"
	// , infoPostFix : ""
	, thousands : ","
	, lengthMenu : "_MENU_ 개씩 보기"
	, loadingRecords : "로딩중..."
	, processing : "처리중..."
	, search : "결과 내 재검색 : "
	, zeroRecords : "검색된 데이터가 없습니다."
	, paginate : {
		first : "처음"
		,last : "끝"
		,next : "다음"
		,previous : "이전"
	}
};

function setDatatables(tableID, args) {
	/* args
	* hideColumns	: 초기숨김컬럼 리스트	ex) [0, 1, 2]
	* orderColumns	: 정렬컬럼 리스트		ex) [[2, "asc"]]
	* excludeOrderColumns	: 정렬제외컬럼	ex) [1]
	* rowspan		: rowspan 컬럼지정		ex) [1, 2]		: 컬럼 순서대로 우선순위 적용 (ordering: true일 때만 적용됨)
	* useColvis		: colvis 사용여부		ex) true/false
	* */

	$("#" + tableID).DataTable({
		destroy: true
		, responsive: typeof args['responsive'] === 'undefined' ? true : args['responsive']
		, paging: typeof args['paging'] === 'undefined' ? true : args['paging']
		, lengthChange: false
		, pageLength: typeof args['pageLength'] === 'undefined' ? 25 : args['pageLength']
		, autoWidth: false
		, searching: false
		, info: typeof args['info'] === 'undefined' ? true : args['info']
		, language: lang_kor
		, ordering: typeof args['ordering'] === 'undefined' ? true : args['ordering']
		, order: args['orderColumns']
		, rowsGroup: args['rowspan']
		, footerCallback: args['footerCallback']
		, columnDefs : [
			{targets: 0, orderable: false, className: typeof args['responsive'] === 'undefined' ? 'dtr-control' : ''}	/* responsive 가 true일 때만 적용됨*/
			, {targets: args['excludeOrderColumns'], orderable: false}
			, {targets: args['hideColumns'], visible: false}
			, {targets: args['intColumns'], className: 'text-right', render: $.fn.dataTable.render.number( ',', '', 0, '' )}
		]
		, buttons: [
			, {
				extend: "excel"
				, footer: true
				, exportOptions: {
					columns: ':visible:not(.no_toggle)'
				}
			}
			, {
				extend: "print"
				, footer: true
				, exportOptions: {
					columns: ':visible:not(.no_toggle)'
				}
			}
			, {
				extend: "colvis"
				, className: "btn btn-sm btn-default"
				, text: '<i class="fas fa-list-ul"></i> 표시항목변경'
				, columns: function (idx, data, node) {
					return !$(node).hasClass('no_toggle');	// no_toggle 항목 제외
				}
			}
		] /*copy, csv도 가능*/
	});

	if (typeof args['useColvis'] !== 'undefined' && args['useColvis']) {
		// colvis 위치설정
		$("#" + tableID).DataTable().buttons().container().children("div.btn-group").appendTo('#' + tableID + '_colvis');
		$('#' + tableID + '_colvis div.btn-group').addClass("btn-block");

		// colvis dropdown 너비 표시항목변경 버튼과 동일하도록 설정
		/*
			colvis 한번 작동하도록 한 후 너비 설정해주고 background랑 collection 안보이도록 해줘야 너비설정이 제대로 적용됨
			remove로 안보이도록 하면 표시항목 선택이 안 됨..
			datatablesButtonTrigger({tableID:tableID, extend:"colvis"});
			$('#' + tableID + '_colvis div.btn-group div.dt-button-collection div.dropdown-menu')
				.css("width", $('#' + tableID + '_colvis div.btn-group').css("width"));
			$('#' + tableID + '_colvis div.btn-group div.dt-button-background').remove();
			$('#' + tableID + '_colvis div.btn-group div.dt-button-collection').remove();
		*/
	}

	// 설정전/설정후 테이블 틀이 달라져서 보기 안좋음. 안보이도록 처리해놓고 테이블 설정 후 표시되도록 함
	$("#" + tableID).show();
}

function setAjaxDatatables(tableID, args) {
	$("#" + tableID).DataTable({
		language: lang_kor
		, responsive: typeof args['responsive'] === 'undefined' ? true : args['responsive']
		, searching: typeof args['searching'] === 'undefined' ? false : args['searching']
		, ordering: typeof args['ordering'] === 'undefined' ? true : args['ordering']
		, order: typeof args['order'] === 'undefined' ? [] : args['order']
		, rowsGroup: args['rowspan']
		, lengthChange: typeof args['lengthChange'] === 'undefined' ? false : args['lengthChange']
		// , preDrawCallback: function () {}
		, ajax: args['ajax']
		, columns: args['columns']
		, createdRow: args['createdRow']
		, drawCallback: function () {
			if (typeof args['drawCallback'] === "function") args['drawCallback']();
		}
		, buttons: [
			{
				extend: "excel"
				, footer: true
				, exportOptions: {columns: ':visible:not(.no_toggle)'}
			}
			, {
				extend: "print"
				, footer: true
				, exportOptions: {columns: ':visible:not(.no_toggle)'}
			}
			, {
				extend: "colvis"
				, className: "btn btn-sm btn-default"
				, text: '<i class="fas fa-list-ul"></i> 표시항목변경'
				, columns: function (idx, data, node) {
					return !$(node).hasClass('no_toggle');	// no_toggle 항목 제외
				}
			}
		] /*copy, csv도 가능*/
	});

	$("#" + tableID).css("width", "100%");	/* 페이지 resize 될 때 table로 크기가 자동으로 변경되도록 추가해줌 */
	$("#" + tableID).on( 'draw.dt', function () {
		$("#" + tableID + " .select2").select2();	/* 각 페이지별 select2 적용 */

		syncCheckbox(tableID);	/* 페이지 변경 시 체크박스 동기화 */
		$("#" + tableID + " input[name=tb_check_list]").on("change", function () {	/* 데이터행 체크박스 변경 시 체크박스 동기화되도록 추가 */
			syncCheckbox(tableID);
		});
	});

	// 설정전/설정후 테이블 틀이 달라져서 보기 안좋음. 안보이도록 처리해놓고 테이블 설정 후 표시되도록 함
	$("#" + tableID).show();
}

// $("input").prop("autocomplete", "off")
function alertAjaxError(request, status, error) {
	alert("[code] "+request.status+"\n"+"[message]\n"+request.responseText+"\n"+"[error] "+error);
}

function parsleyFormValidate(formId) {
	var parsleyConfig = {
		errorsWrapper: '',
		errorTemplate: ''
	};

	return $("form#" + formId).parsley(parsleyConfig).validate();
}

function checkResultValidate(className) {
	var result = $("." + className);
	var check = true;
	$.each(result, function(index, item) {
		if(item.innerHTML != "") {
			alert(item.innerHTML + "\n입력값을 다시 확인해 주시기 바랍니다.");
			check = false;
			return false;
		}
	});
	return check;
}

function checkResultValidate(formId, className) {
	var result = $("#" + formId + " ." + className);
	var check = true;
	$.each(result, function(index, item) {
		if(item.innerHTML != "") {
			alert(item.innerHTML + "\n입력값을 다시 확인해 주시기 바랍니다.");
			check = false;
			return false;
		}
	});
	return check;
}

function overlapCheck(obj, url, dataJSON) {
	var oldObj = $("#" + obj.attr("id") + "_old");	// 이전 값 네이밍 규칙 #frm_###_old
	if (isNotNull(oldObj)) {	// 이전 값이 있으면 이전 값과 수정 값을 비교. 같으면 중복체크 안함
		if (oldObj.val().trim() == obj.val().trim()) return false;
	}

	var minLength = obj.data("parsley-length") ? obj.data("parsley-length")[0] : 1;
	if (obj.val().length < minLength) {
		obj.next(".checkResult").html("");
		return false;
	}

	$.ajax({
		type: "POST"
		, url: url
		, dataType: "json"
		, contentType: "application/json; charset=utf-8"
		, data: JSON.stringify(dataJSON)
		, success: function (data) {
			if (data) {
				obj.next(".checkResult")
					.html("중복된 " + obj.prop("title") + "입니다.")
			} else {
				obj.next(".checkResult").html("");
			}
		}
		, error: function (request, status, error) {
			alertAjaxError(request, status, error);
		}
	});
}

/* foramt */
function formatID(str) {
	str = str.replace(/[^a-zA-Z0-9_-]/g, '');
	return str;
}

function formatEmail(str) {
	str = str.replace(/[^a-zA-Z0-9@._-]/g, '');
	return str;
}

function formatPhone(str) {
	str = str.replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-");
	return str;
}

function formatNumber(str) {
	str = str.replace(/[^0-9]/g, '');
	return str;
}

function formatCode(str) {	// 영문대문자,숫자
	str = str.toUpperCase().replace(/[^0-9A-Z]/g, '');
	return str;
}

function dateFormat(timestamp) {
	if(isNull(timestamp)) return '';
	var date = new Date(timestamp);
	var month = date.getMonth() + 1;
	var day = date.getDate();

	month = month >= 10 ? month : '0' + month;
	day = day >= 10 ? day : '0' + day;

	return date.getFullYear() + '-' + month + '-' + day;
}

function datetimeFormat(timestamp) {
	if(isNull(timestamp)) return '';
	var date = new Date(timestamp);
	var month = date.getMonth() + 1;
	var day = date.getDate();
	var hour = date.getHours();
	var minute = date.getMinutes();
	var second = date.getSeconds();

	month = month >= 10 ? month : '0' + month;
	day = day >= 10 ? day : '0' + day;
	hour = hour >= 10 ? hour : '0' + hour;
	minute = minute >= 10 ? minute : '0' + minute;
	second = second >= 10 ? second : '0' + second;

	return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
}
/* foramt */

/* check */
function checkIsNumber(str) {
	var reg = /^(\s|\d)+$/;
	return reg.test(str);
}

function isNull(obj) {
	if (obj == null) return true;

	if (typeof obj === "string") {
		if (obj == "") return true;
	} else if (typeof obj === "object") {
		if (Object.keys(obj).length === 0) return true;
	} else if (typeof obj === "undefined") {
		return true;
	}
	return false;
}

function isNotNull(str) {
	return !isNull(str);
}
/* check */

$.fn.rowspan = function(columns) {
	return this.each(function(){
		var table = this;
		var thisTr; var prevTr; var prevTd;

		// 기존 적용된 rowspan 제거
		$('td', this).each(function() {
			$(this).removeAttr("rowspan");
			$(this).show();
		});

		$(columns).each(function (index, colIdx) {
			$('tr', table).each(function() {
				thisTr = this;
				// rowspan 적용
				$('td:eq(' + colIdx + ')', this).filter(':visible').each(function() {
					// rowspan 적용할 컬럼의 내용이 일치하고 이전 컬럼들의 내용이 전부 같으면 rowspan 적용
					if ($(this).html() == $(prevTd).html()) {
						// rowspan 적용할 컬럼 기준으로 이전 컬럼들의 내용이 전부 일치하는지 체크
						var prevSame = true;
						for (var i = index-1; i >= 0; i--) {
							var thisTdHtml = $(thisTr).find('td:eq(' + columns[i] + ')').html();
							var prevTdHtml = $(prevTr).find('td:eq(' + columns[i] + ')').html();
							if (thisTdHtml != prevTdHtml) {
								prevSame = false;
								break;
							}
						}
						if (prevSame) {
							var rowspan = $(prevTd).attr("rowspan") || 1;
							rowspan = Number(rowspan)+1;
							$(prevTd).attr("rowspan",rowspan);
							$(this).hide();	//$(this).remove();
						} else {
							prevTd = this;
						}
					} else {
						prevTd = this;
					}
					prevTd = (prevTd == null) ? this : prevTd;
				});
				prevTr = this;
			});
		});
	});
};

Number.prototype.number = function (digit, separator) {
	var sign = this.toString().charAt(0) == "-" ? "-" : "";
	var num = this.toString().split(".");
	if (num[0]) num[0] = num[0].replace(/[^0-9]/g, "");
	if (num[1]) num[1] = num[1].replace(/[^0-9]/g, "");

	if (separator) num[0] = num[0].replace(/\B(?=(\d{3})+(?!\d))/g, separator);

	if (digit) {
		digit = digit.toString().replace(/[^0-9]/g, "");

		if (typeof num[1] != "undefined") {
			if (!num[0]) num[0] = 0;
			num[0] += "." + num[1].substring(0, (num[1].length < digit ? num[1].length : digit));
		}
	}
	return sign + num[0];
}
String.prototype.number = Number.prototype.number;

Number.prototype.comma = function (digit) {
	return this.number(digit, ",");
}
String.prototype.comma = Number.prototype.comma;

Number.prototype.removeComma = function () {
	return this.toString().replace(/,/g, "");
}
String.prototype.removeComma = Number.prototype.removeComma;

// Convert Integer to Korean
Number.prototype.ko = function () {
	var sign = this.toString().charAt(0) == "-" ? "-" : "";
	var num = this.toString().replace(/[^0-9.]/g, "");

	if (num % 1 !== 0) return NaN;
	if (num == 0) return "영";

	var number = ['', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구'];
	var smallUnit = ['', '십', '백', '천'];
	var unit = ['', '만', '억', '조'];

	var result = "";
	var unitCount = 0;
	for (var i = 0; i < num.length; i++) {
		var strNumber = number[num.charAt(i)];

		if (strNumber != '') {
			strNumber += smallUnit[(num.length - (i+1)) % 4];
			unitCount++;
		}

		if (unitCount != 0 && (num.length - (i+1)) % 4 == 0) {
			unitCount = 0;
			strNumber += unit[(num.length - (i+1)) / 4];
		}

		result += strNumber;
	}

	return "일금 " + sign + result + "원정";
}
String.prototype.ko = Number.prototype.ko;
