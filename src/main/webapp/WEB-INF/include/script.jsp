<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Bootstrap 4 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>

<!-- Parsley -->
<script src="/resources/plugins/parsley/parsley.min.js"></script>
<script src="/resources/plugins/parsley/parsley-extension.js"></script>
<script src="/resources/plugins/parsley/i18n/ko.js"></script>

<!-- DateTimePicker -->
<script src="/resources/plugins/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>

<!-- DataTables  & Plugins -->
<script src="/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/plugins/datatables/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/resources/plugins/datatables/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="/resources/plugins/datatables/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="/resources/plugins/datatables/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="/resources/plugins/datatables/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="/resources/plugins/jszip/jszip.min.js"></script>
<script src="/resources/plugins/datatables/datatables-buttons/js/buttons.html5.min.js"></script>
<script src="/resources/plugins/datatables/datatables-buttons/js/buttons.print.min.js"></script>
<script src="/resources/plugins/datatables/datatables-buttons/js/buttons.colVis.min.js"></script>
<script src="/resources/plugins/datatables/datatables-rowsGroup/datatables.rowsGroup.min.js"></script>

<!-- Select2 -->
<script src="/resources/plugins/select2/js/select2.full.min.js"></script>

<!-- AdminLTE App -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.1.0/js/adminlte.min.js"></script>

<!-- Summernote -->
<script src="/resources/plugins/summernote/summernote-bs4.min.js"></script>

<script>
	$(function () {
		// 메뉴활성화
		menuActivation();

		// selectbox 디자인 select2 적용
		$(".select2").select2();

		$('.modal-dialog').draggable({ handle: ".modal-header" });
	});

	$("#btnSearch").on("click", function () {
		getPage();
	});

	$("#keyword").on("keypress", function (e) {
		if (e.keyCode == 13) getPage();
	});

	$("input[name=tb_check_all]").on("change", function (){
		var tableID = $(this).closest('table')[0].id;
		$("#" + tableID + " input[name=tb_check_list]").prop("checked", $(this).is(":checked"));
	});

	$("#btnTransform").on("click", function () {
		if ($(".business-select-box").is(":visible")) {
			$(".business-select-box").slideUp();
		} else {
			$(".business-select-box").slideDown();
		}
	});

	function transformBusiness(bsns_code) {
		$.ajax({
			type: "POST"
			, url: "/mybusiness/transform/" + bsns_code
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, success: function (data) {
				if (data == 'success') {
					window.location.reload();
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	}

	function syncCheckbox(tableID) {
		var check_list_cnt = $("#" + tableID + " input[name=tb_check_list]").length;
		var checked_cnt = $("#" + tableID + " input[name=tb_check_list]:checked").length;
		if (check_list_cnt == 0)
			$("#" + tableID + " input[name=tb_check_all]").prop("checked", false);
		else if (checked_cnt == check_list_cnt)
			$("#" + tableID + " input[name=tb_check_all]").prop("checked", true);
		else
			$("#" + tableID + " input[name=tb_check_all]").prop("checked", false);
	}

	function menuActivation() {
		var uri = window.location.pathname;
		// console.log(uri);
		$("ul.nav li a").each(function (index, item){
			var href = $(item).attr("href");
			// console.log($(item).attr("href"));
			if (uri == href) {
				$(item).addClass("active");
				$(item).parent().parent().prev().addClass("active");
				$(item).parent().parent().parent().addClass("menu-open");
				$(item).parent().parent().prev().parent().parent().prev().addClass("active");
				$(item).parent().parent().prev().parent().parent().parent().addClass("menu-open");
			}
		});
	}

	function datatablesButtonTrigger(args) {
		if($.fn.DataTable.isDataTable("#" + args['tableID'])) {
			$("#" + args['tableID']).DataTable().button(".buttons-" + args['extend']).trigger();
		}
	}

	function setFrmValue(data) {
		setValue("frm", data);
	}

	function setPopValue(data) {
		setValue("pop", data);
	}

	function setValue(prefix, data) {
		$.each(data, function(key, value) {
			var target = $("#" + prefix + "_" + key);
			if (target.length > 0) {	// tag id 체크
				if (target.is("span")) {	// span 체크
					if (key.indexOf("_price") != -1) {
						target.html(value.comma());
					} else {
						target.html(value);
					}
				} else if (target.is("input")) {	// input 체크
					if (target.attr("type") === "file") {
						var imgID = target.attr("id") + "_image";
						$("#" + imgID).attr("src", "/preview?fileName=" + value);
					} else {
						target.val(value);
					}
				} else if (target.is("select")) {	// select 체크
					target.val(value).trigger("change");
				}
			} else {
				var radio = $("input:radio[name=" + prefix + "_" + key + "]");
				if (radio.length > 0) {	// radio 체크
					$("input:radio[name ='" + prefix + "_" + key + "']:input[value='" + value + "']").prop("checked", true).trigger("change");
				}

			}
		});
	}

	function setFormValue(formID, data) {
		$.each(data, function(key, value) {
			var target = $("#" + formID + " input[name=" + key + "]");
			if (target.length > 0) {	// tag id 체크
				if (target.is("span")) {	// span 체크
					if (key.indexOf("_price") != -1) {
						target.html(value.comma());
					} else {
						target.html(value);
					}
				} else if (target.is("input")) {	// input 체크
					if (target.attr("type") === "file") {
						var imgID = target.attr("id") + "_image";
						$("#" + imgID).attr("src", "/preview?fileName=" + value);
					} else {
						target.val(value);
					}
				} else if (target.is("select")) {	// select 체크
					target.val(value).trigger("change");
				}
			} else {
				var radio = $("#" + formID + " input:radio[name=" + key + "]");
				if (radio.length > 0) {	// radio 체크
					$("#" + formID + " input:radio[name ='" + key + "']:input[value='" + value + "']").prop("checked", true).trigger("change");
				}

			}
		});
	}

	function setSelectValue(data) {
		$.each(data, function(key, value) {
			var target = $("#select_" + key);
			if (target.length > 0) {	// tag id 체크
				if (target.is("span")) {	// span 체크
					target.html(value);
				} else if (target.is("input")) {	// input 체크
					target.val(value);
				}
			}
		});
	}

	function initDataTable(formName) {
		$("#" + formName + " input[type=text]").each(function() {
			$(this).val("");
			$(this).attr("disabled", false);
		});
		$("#" + formName + " input[type=hidden], #" + formName + " input[type=file]").each(function() {
			$(this).val("");
		});
		$("#" + formName + " img").each(function() {
			$(this).attr("src", "/img/none.png");
		});
		$("#" + formName + " input[type=radio]").each(function() {
			var radioName = $(this)[0].name;
			$("input[name=" + radioName + "]:eq(0)").prop("checked", true).trigger("change");
			$("input[name=" + radioName + "]").removeAttr("disabled");
		});
		$("#" + formName + " select").each(function() {
			var selectId = $(this).attr("id");
			$(this).val($("#" + selectId + " option:eq(0)").val()).trigger("change");
			$(this).attr("disabled", false);
		});

		$("#" + formName + " .checkResult").each(function() {
			$(this).html("");
		});
	}

	<c:if test="${adminVO ne null}">
	$("#btnUserTransform").on("click", function () {
		$.ajax({
			type: "POST"
			, url: "/admin/user/retransform"
			, headers: {"Content-Type": "application/json"}
			, dataType: "text"
			, data: JSON.stringify({})
			, success: function (data) {
				if (data == "success") {
					self.location = "/";
				} else {
					alert(data);
				}
			}
			, error: function (request, status, error) {
				alertAjaxError(request, status, error);
			}
		});
	});
	</c:if>
</script>
