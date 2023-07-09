<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>전주환경사업소 설비관리시스템</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
<!-- icheck bootstrap -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/icheck-bootstrap/3.0.1/icheck-bootstrap.min.css" />

<!-- jQuery -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<!-- DateTimePicker -->
<link rel="stylesheet" href="/resources/plugins/datetimepicker-master/jquery.datetimepicker.css" />

<!-- DataTables -->
<link rel="stylesheet" href="/resources/plugins/datatables/datatables-bs4/css/dataTables.bootstrap4.min.css" />
<link rel="stylesheet" href="/resources/plugins/datatables/datatables-responsive/css/responsive.bootstrap4.min.css" />
<link rel="stylesheet" href="/resources/plugins/datatables/datatables-buttons/css/buttons.bootstrap4.min.css" />

<!-- Select2 -->
<link rel="stylesheet" href="/resources/plugins/select2/css/select2.min.css" />

<!-- Theme style -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.1.0/css/adminlte.min.css" />

<!-- summernote -->
<link rel="stylesheet" href="/resources/plugins/summernote/summernote-bs4.min.css">

<!-- SweetAlert2 -->
<link rel="stylesheet" href="/resources/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css" />
<script src="/resources/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Toastr -->
<link rel="stylesheet" href="/resources/plugins/toastr/toastr.min.css" />
<script src="/resources/plugins/toastr/toastr.min.js"></script>

<!-- Common -->
<link rel="stylesheet" href="/resources/common/common.css" />
<script src="/resources/common/common.js"></script>

<script>
	var Toast = Swal.mixin({
		toast: true,
		position: 'top-end',
		showConfirmButton: false,
		timer: 3000
	});

	$(function () {
		// datepicker 설정
		$(".datepicker").datepicker({
			dateFormat: 'yy-mm-dd'
			, prevText: '이전 달'
			, nextText: '다음 달'
			, monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			, monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
			, dayNames: ['일', '월', '화', '수', '목', '금', '토']
			, dayNamesShort: ['일', '월', '화', '수', '목', '금', '토']
			, dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
			, showMonthAfterYear: true
			, changeYear: true
			, changeMonth: true
		});

		$(".datepicker-removable").datepicker({
			dateFormat: 'yy-mm-dd'
			, prevText: '이전 달'
			, nextText: '다음 달'
			, monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			, monthNamesShort: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12']
			, dayNames: ['일', '월', '화', '수', '목', '금', '토']
			, dayNamesShort: ['일', '월', '화', '수', '목', '금', '토']
			, dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
			, showMonthAfterYear: true
			, changeYear: true
			, changeMonth: true
			, showButtonPanel: true
			, closeText: '지우기'
			, onClose: function (dateText, inst) {
				if ($(window.event.srcElement).hasClass('ui-datepicker-close')) $(this).val("");
			}
		});

		$(".datetimepicker").datetimepicker({
			format: 'Y-m-d H:i'
			, i18n: {
				kr: {
					months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
					, days: ['일', '월', '화', '수', '목', '금', '토']
				}
			}
			, lang: 'kr'
			, step: 1
		});

		$(".datetimepicker-timechangeonly").datetimepicker({
			format: 'Y-m-d H:i'
			, i18n: {
				kr: {
					months: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
					, days: ['일', '월', '화', '수', '목', '금', '토']
				}
			}
			, lang: 'kr'
			, step: 1
		});

		$.datetimepicker.setLocale('kr');
	});
</script>
