<%Option Explicit%>
<!--#include file="AllPages.inc"-->
<!--#include file="ADODataConnections.asp"-->
<!--#include file="CountyDocs.vbs"-->


<%'*********************************************************************************************************************************%>
<%
'if form submitted successfully
If Request.QueryString("mode")= "submitted"	Then	
	SendJmail
	BuildConfirmationPage
else
	BuildPage
end if
%>

<%Sub BuildPage
	BuildHeader
	BuildTopNav
	BuildLeftNav
	BuildContent
	BuildFooter 
End Sub%>

<%Sub BuildConfirmationPage
	BuildHeader
	BuildTopNav
	BuildLeftNav
	BuildConfirmationContent
	BuildFooter 
End Sub%>

<%Function SendJMail()
	'Declare variables
	Dim JMail
	Dim strBody
	Dim strName
	Dim strPhone
	Dim strEmail
	Dim StrComments	
	
	'Set variable
	strName=Request.Form("name")
	strPhone=Request.Form("phone")
	strEmail=Request.Form("email")
	strComments=Request.Form("comments")
	
	'put variable value in Body of Email
	strBody = "Name: " & strName      & vbCrLf
	strBody = strBody  & "Phone: "    & strPhone  & vbCrLf
	strBody = strBody  & "Email: "    & strEmail  & vbCrlf    & vbCrlf
	strBody = strBody  & "Comments: " & vbCrLf    & strComments
	
	'Creating Mail Object and setting properties
	Set JMail = Server.CreateObject("JMail.Message") 
	JMail.From = "NoReply"
	JMail.ContentType = "text/plain"
	JMail.AddHeader "Originating-IP", Request.ServerVariables("REMOTE_ADDR")
		
	JMail.Subject = "Contact Us"
	JMail.AddRecipient "tmstaff@treasurer.org"	
	JMail.Body = strBody
	JMail.Send "pony.treasurer.org"	
	JMail.ClearRecipients

	JMail.Close()
	set JMail = nothing
End Function%>


<%
Dim errorMsg
errorMsg=""%>


<%Sub BuildContent%>
<div class="mainContent">
        <h1>Contact Us</h1>
        <hr />
        
        <p align="left">You may contact Treasury Management staff at anytime via email by submitting the form below.
        If you need to speak directly to a member of the Treasuy Management Staff, please call (402) 471-2455 
        and ask for Treasury Management.<br />
        </p>
        
        <p>THANK YOU</p>
       
        <form id="contactUsForm" name="contactUsForm" method="post" action="contactUs.asp?mode=submitted" onSubmit="return validateForm();" >          
          <table class="left">
            <tr>
              <td width="15%">Name:</td>
              <td><input name="name" type="text" id="name" autocomplet="off" size=40></td>
            </tr>
            <tr>
              <td width="15%">Phone:</td>
              <td><input name="phone" type="text" id="phone" autocomplet="off" size=40></td>
            </tr>
            <tr>
              <td width="15%">Email:</td>
               <td><input name="email" type="text" id="email" autocomplet="off" size=40></td>
            </tr> 
            <tr><td>&nbsp;</td></tr>
            <tr>
              <td>Comments:</td>               
            </tr>
            <tr>
              <td colspan="2"><textarea name="comments"  id="comments" cols="70" rows="10" autocomplet="off"></textarea></td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>             
              <td><input autocomplete="off" name="submit2" type="submit" value="Submit"></td>
            </tr>           
          </table>           
        </form>
        
        <%
		if errorMsg <> "" then
			response.write("<span class=""error"">" & errorMsg & "</span>")
		end if%>
</div> <!-- end mainContent -->
     <!-- This clearing element should immediately follow the #mainContent div in order to force the #container div to contain all child floats --><br class="clearfloat" />
<%End Sub%>



<%Sub BuildConfirmationContent%>
<div class="mainContent">
    <h1>Contact Us</h1>
    <hr />
    <p>Your information has been successfully submitted to Treasury Management.<br />
    </p>
    
    <p>THANK YOU</p>
    
    <form>
    <table>
      <tr><td class = "center" colspan="2"> 
        <input id="backBtn" name="backBtn" type="button" value = "Done" 
        onclick="javascript:history.go(-2)">&nbsp;</td></tr>
    </table>
   </form>
<%End Sub%>


<%Sub BuildFooter%>
    <div class="footer">
        <p>Copyright 1997-<% response.Write (year(date)) %>, Nebraska State Treasurer</p>
    </div><!-- end footer --><!-- end container -->
    </body>
    </html>
<%End Sub%>


<script type="text/javascript">
<!--
function  putFocus()
{
		/*if (typeof document.forms[0] != 'undefined')
		document.forms[0].elements(0).focus();*/
		alert("set focus");
		window.document.contactUsForm.name.focus();
}

function validateForm ( )
{
    valid = true;

    if ( document.contactUsForm.name.value == "" ){
        alert ( "Please fill in 'Your Name'." );
        valid = false;  	
	}	
	else if(document.contactUsForm.phone.value == ""){
		alert ( "Please fill in 'Your Phone Number'." );
		valid = false;
	} 		   
	else if(isValidPhone()==false){
		alert ("Phone is invalid. Please enter phone numbers in (999) 999-9999 format");
		valid = false;
	}
	else if ( document.contactUsForm.email.value != ""  && isValidEmail(document.contactUsForm.email.value)== false){
		alert ( "If you have an email address enter a valid email address" );
		valid = false;		
	}
	else if ( document.contactUsForm.comments.value == "" ){
		alert ( "Please enter a request or comment." );
		valid = false;     	
	}					

   	return valid;	
}


function isValidPhone(){
var validPhone = /^\(\d{3}\) \d{3}-\d{4}$/; 
	var phone = document.contactUsForm.phone.value;
	
	if (phone != "") {
		if (!validPhone.test(phone)) {			
			document.getElementById("phone").focus();
			return false;
		}
	}
	else
		return true;
}
function isValidEmail(str) {
   return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);
   
 
}

//-->
</script>
