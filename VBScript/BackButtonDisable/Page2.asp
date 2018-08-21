<%@LANGUAGE="vbscript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PAGE 2</title>


<%Session("submittedPage1") = "yes"%>
<%Response.Write("submittedPage1 = ")%><%=Session("submittedPage1")%><p>

<!--<form method=post action="SomePage.asp">
  <input type=submit>
</form>-->
		


</head>
  
<body>
</body>
</html>
