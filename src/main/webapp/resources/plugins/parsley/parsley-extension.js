// alert 메세지로 표시
window.Parsley.on('form:error', function(formInstance){

	var message = "";

	// You have access to each field instance with `formInstance.fields`
	for (var idx in formInstance.fields)
	{
		if ( formInstance.fields[idx].validate() !== true )
		{
			var title = formInstance.fields[idx].$element[0].title ? formInstance.fields[idx].$element[0].title : "";
			var errorMessage = formInstance.fields[idx].getErrorsMessages();

			message = title + "은(는) " + errorMessage;

			break;
		}
	}

	if ( message !== "" )
		alert(message);
});

// parsley custom validator
window.Parsley.addValidator('passwordconfirm', {
	validateString: function(value, passwordId) {
		var password = $('#' + passwordId).val();

		return value === password;
	},
	messages: {
		ko: '비밀번호와 값이 다릅니다.'
	}
});

window.Parsley.addValidator('dupcheck', {
	validateString: function (value, dupFieldId) {
		var dupFiledValue = $('#'+dupFieldId).val();

		return dupFiledValue === 'true';
	},
	messages: {
		ko: '중복확인이 필요합니다.'
	}
});
