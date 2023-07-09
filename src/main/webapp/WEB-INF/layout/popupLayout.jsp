<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
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

	<!-- DataTables -->
	<link rel="stylesheet" href="/resources/plugins/datatables/datatables-bs4/css/dataTables.bootstrap4.min.css" />
	<link rel="stylesheet" href="/resources/plugins/datatables/datatables-responsive/css/responsive.bootstrap4.min.css" />
	<link rel="stylesheet" href="/resources/plugins/datatables/datatables-buttons/css/buttons.bootstrap4.min.css" />

	<!-- Select2 -->
	<link rel="stylesheet" href="/resources/plugins/select2/css/select2.min.css" />

	<!-- Theme style -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.1.0/css/adminlte.min.css" />

	<!-- Common -->
	<link rel="stylesheet" href="/resources/common/common.css" />
	<script src="/resources/common/common.js"></script>

	<style>
		.content-wrapper {
             margin-left: 0!important;
        }
	</style>

</head>

<body class="hold-transition sidebar-mini">
<div class="wrapper">

	<div class="content-wrapper">
		<div class="overlay">
			<i class="overlay-icon fas fa-sync-alt fa-spin fa-5x"></i>
		</div>

		<decorator:body></decorator:body>

	</div>

</div>

<!-- Bootstrap 4 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>

<!-- Parsley -->
<script src="/resources/plugins/parsley/parsley.min.js"></script>
<script src="/resources/plugins/parsley/parsley-extension.js"></script>
<script src="/resources/plugins/parsley/i18n/ko.js"></script>

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

<script>
	function datatablesButtonTrigger(args) {
		if($.fn.DataTable.isDataTable("#" + args['tableID'])) {
			$("#" + args['tableID']).DataTable().button(".buttons-" + args['extend']).trigger();
		}
	}
</script>

</body>

</html>
