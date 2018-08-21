'This class definition provides functions used by all pages in the site
'The individual pages must inherit from this class rather than System.Web.UI.Page
Partial Public Class NCSPCBasePage
	Inherits System.Web.UI.Page

	'This function will check to see if text is present in the textbox and display an 
	'error if it is not present.  It also removes leading and trailing whitespace.
	'It will return true if text is present
	'The first parameter is the text box to check, the second is the error to display.
	Friend Function validateTextInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		txtInput.Text = Trim(txtInput.Text)
		If txtInput.Text.Length = 0 Then
			ShowError(strErr)
			Return False
		End If
		Return True
	End Function

	'This function will check to see if a SSN is present in the textbox and remove all characters
	'except the numbers 0-9.  If the result is not 9 characters long the error message will be displayed
	'It will return true if a valid SSN is present
	'The first parameter is the text box to check, the second is the error to display.
	Friend Function validateSSNInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		Dim strTmp As String = StripCharsNotInBag(txtInput.Text, "0123456789")
		If strTmp.Length <> 9 Then
			ShowError(strErr)
			Return False
		End If
		txtInput.Text = FormatSSN(strTmp)
		Return True
	End Function

	'This function will check to see if a FEIN is present in the textbox and remove all characters
	'except the numbers 0-9.  If the result is not 9 characters long the error message will be displayed
	'It will return true if a valid SSN is present
	'The first parameter is the text box to check, the second is the error to display.
	Friend Function validateFEINInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		Dim strTmp As String = StripCharsNotInBag(txtInput.Text, "0123456789")
		If strTmp.Length <> 9 Then
			ShowError(strErr)
			Return False
		End If
		txtInput.Text = FormatFEIN(strTmp)
		Return True
	End Function

	'This function will validate and then format a phone number in a text box
	'It takes a textbox and error message as parameters and returns true if a valid phone number
	'is present in the text box.  If the phone number is valid, it will format it in the text box.
	Friend Function validatePhoneInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		Dim strTemp As String = StripCharsNotInBag(txtInput.Text, "0123450123456789")
		If strTemp.Length <> 10 Then
			ShowError(strErr)
			Return False
		Else
			txtInput.Text = FormatPhoneNumber(strTemp)
			Return True
		End If
 End Function
 'This function will validate and then format a fax number in a text box
 'It takes a textbox and error message as parameters and returns true if a valid fax number
 'is present in the text box.  If the fax number is valid, it will format it in the text box.
 Friend Function validateFaxInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
  Dim strTemp As String = StripCharsNotInBag(txtInput.Text, "0123450123456789")
  If strTemp.Length <> 10 Then
   ShowError(strErr)
   Return False
  Else
   txtInput.Text = FormatPhoneNumber(strTemp)
   Return True
  End If
 End Function

	Friend Function validateEmailInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		'The regular expression below was taken from http://msdn.microsoft.com/en-us/library/ms998267.aspx#paght000001_commonregularexpressions 
		'I added a + sign to the list to allow sub-addressing
		'I think that there may be some exotic addresses which may be valid but do not pass this test.  I am unable
		'to find a regex that is more complete.
		Dim regexEmail As Regex = New Regex("^([0-9a-zA-Z]([\+-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$")	'check for at least a @ with a .
		If Not regexEmail.IsMatch(txtInput.Text) Then
			ShowError(strErr)
			Return False
		Else
			Return True
		End If
	End Function

	'validates a textbox to make sure that it contains only integers.
	'Will return valid if the input is empty so you may need to validate that separately.
	Friend Function validateIntegerInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		Dim regexNumeric As Regex = New Regex("^[0-9]*$")
		If Not regexNumeric.IsMatch(txtInput.Text) Then
			ShowError(strErr)
			Return False
		Else
			Return True
		End If
	End Function

	'validates a textbox to make sure that it contains only currency amounts, that is floating point with 
	'two decimal places. Does not acccept the $
	'Will return valid if the input is empty so you may need to validate that separately.
	Friend Function validateCurrencyInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		Dim regexNumeric As Regex = New Regex("^[0-9]*\.{0,1}[0-9]{0,2}$")
		If Not regexNumeric.IsMatch(txtInput.Text) Then
			ShowError(strErr)
			Return False
		Else
			Return True
		End If
	End Function

	'verifies the selectedValue property to see if any item is selected.
	Friend Function validateDropDown(ByRef cboInput As DropDownList, ByVal strErr As String) As Boolean
		If cboInput.SelectedValue.Length > 0 Then
			Return True
		Else
			ShowError(strErr)
			Return False
		End If
	End Function

	'This function will check to see if the textbox contents exceeds a given number of characters and 
	'display an error if it does
	'It will return true if the length does not exceed the given length
	'The first parameter is the text box to check, the second is the maximum length, the third is the error to display.
	Friend Function validateInputLength(ByRef txtInput As TextBox, ByVal intLength As Integer, ByVal strErr As String) As Boolean
		If txtInput.Text.Length > intLength Then
			ShowError(strErr)
			Return False
		End If
		Return True
	End Function

	'This function will validate the SelectedDate value of the NCSPCCalendar and return true if it is a valid
	'date, false if it is not valid.
	'It will also reformat the date if it is in the wrong format.
	Friend Function validateNCSPCDateInput(ByRef calInput As NCSPCCalendar, ByVal strErr As String) As Boolean
		Dim d As New Date
		If Date.TryParse(calInput.SelectedDate, d) Then
			calInput.SelectedDate = d.ToShortDateString()
			Return True
		Else
			ShowError(strErr)
			Return False
		End If
	End Function

	'This funciton will validate a Zipcode.  It takes the format 99999 or 99999-9999
	Friend Function validateZipInput(ByRef txtInput As TextBox, ByVal strErr As String) As Boolean
		Dim strTemp As String = StripCharsNotInBag(txtInput.Text, "0123450123456789")
		If strTemp.Length = 5 Then
			txtInput.Text = strTemp
			Return True
		ElseIf strTemp.Length = 9 Then
			txtInput.Text = Left(strTemp, 5) & "-" & Right(strTemp, 4)
			Return True
		Else
			ShowError(strErr)
			Return False
		End If
	End Function


	'This function takes a phone number as just a series of digits and formats it
	'If the number of digits is 10 it returns the formatted number, else it returns
	'exactly what was passed in.
	Friend Function FormatPhoneNumber(ByVal ph As String)
		If Len(ph) = 10 Then
			ph = Left(ph, 3) & "-" & Mid(ph, 4, 3) & "-" & Right(ph, 4)
		End If
		Return ph
	End Function

	'This function takes a social security number as just a series of digits and formats it
	'If the number of digits is 9 it returns the formatted number, else it returns
	'exactly what was passed in.
	Friend Function FormatSSN(ByVal ssn As String)
		If Len(ssn) = 9 Then
			ssn = Left(ssn, 3) & "-" & Mid(ssn, 4, 2) & "-" & Right(ssn, 4)
		End If
		Return ssn
	End Function

	'This function takes a FEIN as just a series of digits and formats it
	'If the number of digits is 9 it returns the formatted number, else it returns
	'exactly what was passed in.
	Friend Function FormatFEIN(ByVal fein As String)
		If Len(fein) = 9 Then
			fein = Left(fein, 2) & "-" & Right(fein, 7)
		End If
		Return fein
	End Function

	'This function takes the parts of a person's name and assembles them
	'to be displayed.  It formats them in the format LastName, FirstName Suffix
	Public Function FormatName(ByRef FirstName As String, ByRef LastName As String, ByRef Suffix As String) As String
		Dim strName As String = String.Empty
		strName = LastName & ", " & FirstName
		If Suffix.Length > 0 Then
			strName = strName & " " & Suffix
		End If
		Return strName
	End Function

	'This function removes all characters that are not in strBag from strCheck and returns the
	'resulting string
	Friend Function StripCharsNotInBag(ByRef strCheck As String, ByRef strBag As String) As String
		Dim strReturn As String = ""
		Dim i As Integer
		For i = 1 To strCheck.Length
			If InStr(strBag, Mid(strCheck, i, 1)) > 0 Then
				strReturn &= Mid(strCheck, i, 1)
			End If
		Next
		Return strReturn
	End Function

	'This function calls the ShowError function on the Master Page in order
	'to add an error to the list of errors at the top of the page.
	Friend Sub ShowError(ByRef strErr As String)
		DirectCast(Page.Master, Main).ShowError(strErr)
	End Sub

	'This function is used to prevent XSS type attacks.  It takes a string
	'and returns a sanitized string which can be displayed on the web.
	'This function should be used when outputting values directly to the html
	'It should not be used with the HTML controls in code as they already encode the output.
	Public Function XSSSafe(ByVal strSource As String)
		Return HttpUtility.HtmlEncode(strSource)
	End Function


	'Enumeration of payment method types
	Enum PaymentMethods
		Unset = -1
		ACHCreditRemit = 0
		ACHCreditWeb = 1
		ACHDebitWeb = 2
		CheckRemit = 3
		CheckWeb = 4
	End Enum

	'Enumeration of contact types
	Enum ContactTypes
		Primary = 1
		Secondary = 2
		PayrollProcessor = 3
	End Enum

	'Enumeration of login request statuses
	Enum LoginRequestStatus
		Requested = 0
		Approved = 1
		Denied = 2
	End Enum

End Class

