<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>

<div class="overlay">
	<i class="overlay-icon fas fa-sync-alt fa-spin fa-5x"></i>
</div>
<object id=HwpCtrl style="left: 0px;top: 0px;display: none;" height="100%" width="100%" align=center
		classid=CLSID:BD9C32DE-3155-4691-8972-097D53B10052>
	<PARAM NAME="TOOLBAR_MENU" VALUE="TRUE">
<%--	<PARAM NAME="TOOLBAR_STANDARD" VALUE="TRUE">--%>
	<PARAM NAME="TOOLBAR_FORMAT" VALUE="TRUE">
<%--	<PARAM NAME="TOOLBAR_DRAW" VALUE="TRUE">--%>
<%--	<PARAM NAME="TOOLBAR_TABLE" VALUE="TRUE">--%>
<%--	<PARAM NAME="TOOLBAR_IMAGE" VALUE="TRUE">--%>
<%--	<PARAM NAME="TOOLBAR_HEADERFOOTER" VALUE="TRUE">--%>
	<PARAM NAME="SHOW_TOOLBAR" VALUE="TRUE">
</object>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

<!-- jQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- Common -->
<link rel="stylesheet" href="/resources/common/common.css" />
<script src="/resources/common/common.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-core/5.8.34/browser.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.min.js"></script>

<script>
	$(function () {
		onStart();
	})

	var BasePath;
	var MinVersion = 0x0505011B;
	var _DEBUG = false;
	var pHwpCtrl;

	function onStart() {
		BasePath = _GetBasePath();
		pHwpCtrl = document.getElementById("HwpCtrl");

		if (!_VerifyVersion())
			return;
		if (_DEBUG)
			pHwpCtrl.SetClientName("DEBUG"); // RELEASE 할 때는 이부분을 제거한다.

		_InitToolBarJS();

		// 쪽맞춤
		var vp = pHwpCtrl.CreateSet("ViewProperties")
		vp.SetItem("ZoomType", 0);
		vp.SetItem("ZoomRatio", 100);
		pHwpCtrl.ViewProperties = vp;
	}

	function _GetBasePath() {
		//BasePath를 구한다.
		var loc = unescape(document.location.origin);
		var lowercase = loc.toLowerCase(loc);
		if (lowercase.indexOf("http://") == 0) // Internet
		{
			return loc;	//BasePath 생성	(접근할 한글파일 경로에 맞게 지정)
		} else // local
		{
			var path = loc.replace(/.{2,}:\/{2,}/, ""); // file:/// 를 지워버린다.
			return path.substr(0, path.lastIndexOf("/") + 1);	//BasePath 생성
		}
	}

	function _VerifyVersion() {
		var version = pHwpCtrl.Version;

		//설치 확인
		if (version == null) {
			alert("한글 2002 컨트롤이 설치되지 않았습니다.");
			return false;
		}

		//버전 확인
		if (version < MinVersion) {
			alert("HwpCtrl의 버젼이 낮아서 정상적으로 동작하지 않을 수 있습니다.\n" +
				"최신 버젼으로 업데이트하기를 권장합니다.\n\n" +
				"현재 버젼:" + version + "\n" +
				"권장 버젼:" + MinVersion + " 이상"
			);
		}
		return true;
	}

	function _InitToolBarJS(){
		pHwpCtrl.ReplaceAction("FileSaveAs", "HwpCtrlFileSaveAs");
		pHwpCtrl.SetToolBar(0, "FileSaveAs, FilePreview, Print, Separator, Undo, Redo, Separator, Cut, Copy, Paste, ShapeCopyPaste," +
			"Separator, CharShape, ParagraphShape, Style, MultiColumn, Separator, MasterPage, PageSetup, HeaderFooter, " +
			"Separator, PictureInsertDialog, TableCreate");

		pHwpCtrl.ShowToolBar(true);
	}


	function PutFieldText(fieldlist, textlist) {
		if (pHwpCtrl.FieldExist(fieldlist))
			pHwpCtrl.PutFieldText(fieldlist, textlist);
		else {
			if (_DEBUG) alert("필드(" + fieldlist + ")가 존재하지 않습니다.");
		}
	}

	function PutClickFieldText(field, text) {
		var dact = pHwpCtrl.CreateAction("InsertText");
		var dset = dact.CreateSet();
		if (pHwpCtrl.MoveToField(field, true, true, true)) {
			dset.SetItem("Text", text);
			dact.Execute(dset);
		}
		else {
			if (_DEBUG) alert("필드(" + field + ")가 존재하지 않습니다.");
		}
	}

	function MoveToField(field, text, start, select) {
		text = (typeof text === 'undefined') ? true : text;
		start = (typeof start === 'undefined') ? true : start;
		select = (typeof select === 'undefined') ? false : select;

		if (pHwpCtrl.MoveToField(field, text, start, select)) {

		} else {
			if (_DEBUG) alert("필드(" + field + ")가 존재하지 않습니다.");
		}
	}

	function InsertTableData(FirstCellName, dataArray) {
		// 지정한 셀로 이동
		MoveToField(FirstCellName);

		// 캐럿이 표 내부에 있는지 체크
		if (!(pHwpCtrl.ParentCtrl != null && pHwpCtrl.ParentCtrl.CtrlID == "tbl")) {
			if (_DEBUG) alert("현재 커서의 위치가 표 내부가 아님");
		}

		// 표에 데이터 삽입
		var rowEnd = dataArray.length - 1;
		$.each(dataArray, function (rowIndex, rowData) {
			var colEnd = rowData.length - 1;
			var dact = pHwpCtrl.CreateAction("InsertText");
			var dset = dact.CreateSet();

			// 행추가 (원본행을 복사. MERGE 등 작업처리를 위해 한 줄 복사 후 데이터 삽입)
			pHwpCtrl.Run("TableInsertLowerRow");	// 아래쪽 줄 삽입
			pHwpCtrl.Run("TableColBegin");			// 셀 이동: 열 시작

			$.each(rowData, function (colIndex, column) {
				if (column == "MERGE") {
					pHwpCtrl.Run("TableCellBlockExtendAbs");
					pHwpCtrl.Run("TableRightCell");
					pHwpCtrl.Run("TableMergeCell");
				} else {
					dset.SetItem("Text", column);
					dact.Execute(dset);
					// 다음(오른쪽) 셀로 이동 (마지막 열 제외)
					if (colEnd != colIndex) pHwpCtrl.Run("TableRightCell");
				}
			});
			pHwpCtrl.Run("TableLowerCell");			// 셀 이동: 셀 아래

			// 다음 행추가 (마지막 행 제외)
			if (rowEnd == rowIndex) {
				pHwpCtrl.Run("TableDeleteRow");
			}
		});
	}

	/**
	 * 필드이름이 cellName인 셀이 포함된 표를 복사
	 * @param cellName
	 */
	function CopyTableByCell(cellName) {
		// 지정한 셀로 이동
		MoveToField(cellName);

		// 캐럿이 표 내부에 있는지 체크
		if (!(pHwpCtrl.ParentCtrl != null && pHwpCtrl.ParentCtrl.CtrlID == "tbl")) {
			if (_DEBUG) alert("현재 커서의 위치가 표 내부가 아님");
		}

		// 표 전체선택 및 복사
		pHwpCtrl.Run("TableCellBlockCol");		// 셀 블록 (칸)
		pHwpCtrl.Run("TableCellBlockExtend");	// 셀 블록 연장(F5 + F5)
		pHwpCtrl.Run("Copy");
		pHwpCtrl.Run("Cancel");
	}

	/**
	 * 필드이름이 cellName인 셀이 포함된 표를 삭제
	 * @param cellName
	 */
	function DeleteTableByCell(cellName) {
		// 지정한 셀로 이동
		MoveToField(cellName);

		// 캐럿이 표 내부에 있는지 체크
		if (!(pHwpCtrl.ParentCtrl != null && pHwpCtrl.ParentCtrl.CtrlID == "tbl")) {
			if (_DEBUG) alert("현재 커서의 위치가 표 내부가 아님");
		}

		// 표 전체선택 및 삭제
		pHwpCtrl.DeleteCtrl(pHwpCtrl.ParentCtrl);
		pHwpCtrl.Run("DeleteBack");
	}

	function PastePageEnd() {
		pHwpCtrl.Run("MovePageEnd");	// 현재 페이지의 끝점으로 이동
		pHwpCtrl.Run("BreakLine");	// 줄 바꾸기
		pHwpCtrl.Run("BreakLine");	// 줄 바꾸기
		pHwpCtrl.Run("MoveSelUp");	// 셀렉션: 캐럿을 (논리적 방향) 위로 이동
		pHwpCtrl.Run("Paste");		// 붙여넣기
	}

	var sleepTime = 300;
	function sleep(ms) {
		return new Promise(function (r) {
			setTimeout(r, ms)
		});
	}

</script>

<decorator:body></decorator:body>

