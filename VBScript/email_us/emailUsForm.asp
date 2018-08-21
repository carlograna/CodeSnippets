<%Option Explicit%>

<%
Dim ThisPage
Dim PageType
ThisPage = "emailUsForm.asp"
PageType = "GEN"
%>

<html>
<head>
<title><!--#include file ="../pagefiles/title.asp"--> - Treasurer Website</title>




    <script language="javascript" type="text/javascript">
    // <!CDATA[



    // ]]>
    </script>
</head>


<body topmargin=0 leftmargin=0  onLoad="runSlideShow();">

       <link href="../pagefiles/css/treasurer.css" rel="stylesheet" type="text/css"> 



<!--#include file ="../pagefiles/treasurer/treasurerheader.asp"-->
<!--#include file ="../pagefiles/treasurer/treasurerleftnav.asp"-->

<!--<table bgcolor="white" cellpadding = 0 border =1 cellspacing = 0 width = 640 align = "center">

  <tr>
    <td>
      <center><img systran="yes" src="TreasurerBarLogo.gif"></center> 
      <p>&nbsp</p>
 -->
 
      <%If Request.QueryString("mode") = "delivered" Then %>
         <center><b>Your question has been submitted!<br />
             </b></br>
         <font size="-2" color="blue">You will be contacted by one of our representatives as soon as possible.</font></center>
         <p>&nbsp</p>
    <%Else %>
      	 <form method="post" action="emailUs_script.asp" id=frmQuestions name=frmQuestions> 
			<table border="0" cellspacing="1" cellpadding="0" height="180" align="center" style="width: 435px">			
			  <tr>
			    <td colspan="2"><b><!--<font size=4>-->Submit a Question<!--</font>--></b></td>
			    </tr>			    
              <tr>
                <td colspan="2"><font size="-1">Please provide as much information as possible. This will allow us to answer your questions faster.</font></td>
                </tr>
                
			  <tr height="20" valign="top">
			    <td>&nbsp</td>
				</tr>		

			
			  <tr height="20" valign="top">
			    <td>&nbsp</td>
			  </tr>
			  
			  
			  <tr valign="top" align=left> 
			    <td><font size="-1" face="Arial, Helvetica, sans-serif" color="#000000">Your Name:&nbsp;</font></td>     
			    <td valign="middle"><input autocomplete="off" id=txtName name=txtName style="HEIGHT: 22px; LEFT: 166px; TOP: 16px; WIDTH: 150px" value="<%=Server.HTMLEncode(Request.Querystring("txtName"))%>">
				   <%if Request.QueryString("txtName") = "" and Request.QueryString("postback") = "true" Then%>
			          <font color="red" size=1><b>* invalid name</b></font></td>
			       <%else%>
			          <font color="red" size=1><b>*</b></font></td>
			       <%end if %>
			    </tr>
			  <tr valign="top" align=left> 
			    <td><font size="-1" face="Arial, Helvetica, sans-serif" color="#000000">E-mail:&nbsp;</td>
			    <td><input autocomplete="off" id=txtemail name=txtemail style="HEIGHT: 22px; LEFT: 166px; TOP: 16px; WIDTH: 150px" value="<%=Server.HTMLEncode(Request.Querystring("txtemail"))%>">
			       <%if Request.QueryString("validEmail") = "False" Then%>
			          <font color="red" size=1><b>* invalid email</b></font></td>
			       <%else%>
			          <font color="red" size=1><b>*</b></font></td>
			       <%end if %>
			      </td>
		        </tr>
		      <tr valign="top" align=left> 
			    <td><font size="-1" face="Arial, Helvetica, sans-serif" color="#000000">Phone Number:&nbsp;</font></td>
			    <td><input autocomplete="off" id=txtPhone name=txtPhone style="HEIGHT: 22px; LEFT: 166px; TOP: 16px; WIDTH: 150px" value="<%=Server.HTMLEncode(Request.Querystring("txtPhone"))%>" ></td>
			    </tr>						
		      <tr valign="top" align=left> 
			    <td colspan="2"><font size="-1" face="Arial, Helvetica, sans-serif" color="#000000"><br />
                       Comments:&nbsp;<br><TEXTAREA rows=6 cols=50 id=txtComments name=txtComments wrap="physical" ><%=Server.HTMLEncode(Request.Querystring("txtComments"))%></TEXTAREA></font>
                    <%if Request.QueryString("comments") = "" and Request.QueryString("postback") = "true" Then %>
       			      <font color="red" size=1><b>* comments required</b></font>
       			    <%else %>
       			        <font color="red" size=1><b>*</b></font>
       			    <%end if%>
                       
                       </td>
			    </tr>					
			  <tr height="10" valign="top">
				<td></td>
			    </tr>
			  <tr valign=top align=center>		
				<td colspan="2">							
					<input id="Submit1" type="submit" value="submit" /><br>
			    </td>						
		        </tr>
		        <tr><td></td><td>				  <p>&nbsp</p>
				  <p align=right><font color="red" size=1><b>* = Required field</b></font></p></td></tr>
				  </table>

				</form>				
<%end if%>
	<!--		</td>
        </tr>
      </table>-->
      
                      <!--        Main Text Table End        -->


  <!--#include file ="../pagefiles/treasurer/treasurerfooter.asp"-->

</body>
</html>