<%Option Explicit%>
<!--#include file="AllPages.inc"-->
<!--#include file="ADODataConnections.asp"-->
<!--#include file="CountyDocs.vbs"-->
<!--<html>
<head><title>ACH County Debit Report</title></head>
<body>-->
<%
	Dim SQLString
	Dim AdoObject
	Set AdoObject = New AdoDataConnections
	Dim RSCounty
	Dim errMsg
		
	
  Dim amount
  Dim countyName


  
'if Request.QueryString("postback") = "y" Then
    'if date has been validated on client side then search for debit for that date
    


  Dim paidDate
  paidDate = Request.Form("paidDate")

  'open record set

	On Error Resume Next
	SQLString = "EXEC GetDebitByCounty"
'	response.write (SQLString & "<br />")
	Set RSCounty = AdoObject.RunSQLReturnRS(SQLString,"", "CountyDocs")
	if Err.number <> 0 then
		errMsg = "Unable to retrieve Motor Vehicle Registration for ID " & Err.number
		Response.Write("there is an error on line 29")
  Else
    response.Write("Im else")
      TestProcedure

	End if

  
  'close record set after values have been display
  
   Set AdoObject = Nothing    
'end if
 
%>

<%Sub TestProcedure %>

<html>
<head><title>ACH Debit Totals By County</title></head>
<body>
  <form action="ACHdebitTotalByCounty.asp" method="post">
  <table>
    <tr>
      <td>County</td>
      <td>Amount</td>
    </tr>
  <%response.write("test functions works")
  Do while not RSCounty.EOF
    countyName = RSCounty("CountyName")
    amount = RSCounty("Amount")
  %>  
  <tr>
    <td><%=countyName %></td>
    <td><%=amount %></td>
  </tr>    
  <% 
    'Response.Write("countyName: " &  countyName & " amount: " & amount ) %> </br><%
    RSCounty.MoveNext
  Loop
  %>
  </table></form>
</body>
</html>
   
<%End Sub %>