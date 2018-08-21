<%Option Explicit
'Questions Update Page%>

<!--#include file = "../functions/ADODataConnections.asp"-->

<%'Checks User Input
DIM name
DIM email
DIM comments

name  = Trim(Request.Form("txtName"))
email = Trim(Request.Form("txtemail"))
comments = Trim(Request.Form("txtComments"))

Function isValidEmail(email)
  dim isValidE
  dim regEx
  
  isValidE = True
  set regEx = New RegExp
  
  regEx.IgnoreCase = False
  
  regEx.Pattern = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
  isValidE = regEx.Test(email)
  
  isValidEmail = isValidE
End Function






If (name = "")  or (isValidEmail(email) = false) or (comments = "") Then	
	'Response.Redirect("emailUSform.asp?txtComments=" & Trim(Server.HTMLEncode(Request.Form("txtComments"))) & "&txtPhone=" & Trim(Server.HTMLEncode(Request.Form("txtPhone"))) & "&txtemail=" & Trim(Server.HTMLEncode(Request.Form("txtemail"))) & "&txtUserID=" & Trim(Server.HTMLEncode(Request.Form("txtUserID"))) & "&txtCName=" & Trim(Server.HTMLEncode(Request.Form("txtCName"))) & "&txtName=" & Trim(Server.HTMLEncode(Request.Form("txtName")))& "&outcome=failure")
	Response.Redirect("emailUSform.asp?txtComments=" & Trim(Server.HTMLEncode(Request.Form("txtComments"))) & "&txtPhone=" & Trim(Server.HTMLEncode(Request.Form("txtPhone"))) & "&txtemail=" & Trim(Server.HTMLEncode(Request.Form("txtemail"))) & "&txtUserID=" & Trim(Server.HTMLEncode(Request.Form("txtUserID"))) & "&txtCName=" & Trim(Server.HTMLEncode(Request.Form("txtCName"))) & "&txtName=" & Trim(Server.HTMLEncode(Request.Form("txtName")))& "&validEmail=" & isValidEmail(email) & "&postback=true")
Else%>

<%
Dim strCName
Dim strName
Dim strFTIN
Dim strUserID
Dim strPhone
Dim stremail
Dim strComment
Dim JMail

Function SetUpJMail()
	Set JMail = Server.CreateObject("JMail.Message") 
	JMail.From = stremail
	JMail.ContentType = "text/plain"
	JMail.AddHeader "Originating-IP", Request.ServerVariables("REMOTE_ADDR")
End Function

Function KillJMail()
	JMail.Close()
	set JMail = nothing
End Function

	strCName = Trim(Server.HTMLEncode(Request.Form("txtCName")))
	strName = Trim(Server.HTMLEncode(Request.Form("txtName")))
	strFTIN = Trim(Server.HTMLEncode(Request.Form("txtFTIN")))
	strUserID = Trim(Server.HTMLEncode(Request.Form("txtUserID")))
	strPhone = Trim(Server.HTMLEncode(Request.Form("txtPhone")))
	stremail = Trim(Server.HTMLEncode(Request.Form("txtemail")))
	strComment = Trim(Server.HTMLEncode(Request.Form("txtComments")))


	Dim strTo, strSubject, strBody
	
	'strTo = "cspader@treasurer.org"
	strTo = "questionsnew@treasurer.org"
	
	strSubject = "Nebraska Child Support Employer Question"
	
	strBody = strBody & "Nebraska Child Support Employer Question"
	strBody = strBody & vbCrLf
	strBody = strBody & "A Nebraska Child Support Question has been submitted."
	strBody = strBody & vbCrLf & vbCrLf
	strBody = strBody & "The information they have submitted is listed below."
	strBody = strBody & vbCrLf & vbCrLf
	strBody = strBody & "Contact Name: " & strName
	strBody = strBody & vbCrLf
	strBody = strBody & "FTIN: " & strFTIN	
	strBody = strBody & vbCrLf
	strBody = strBody & "Phone: " & strPhone
	strBody = strBody & vbCrLf
	strBody = strBody & "E-mail: " & stremail
	strBody = strBody & vbCrLf
	strBody = strBody & "Comments: " & strComment
	strBody = strBody & vbCrLf
	
	SetUpJMail
		
	JMail.Subject = strSubject
	JMail.AddRecipient strTo	
	JMail.Body = strBody
	JMail.Send "nstmail.treasurer.org"
	JMail.ClearRecipients

	KillJMail

	response.redirect("emailUsForm.asp?mode=delivered")
%>
<%End If%>