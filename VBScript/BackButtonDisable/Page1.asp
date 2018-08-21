<%@LANGUAGE="vbscript" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PAGE 1</title>

<%
Dim thisPage
thisPage = "page1"
%>
<script language="javascript">
alert("I'm in page 1");
</script>

<%
  Response.Buffer = True
  Response.ExpiresAbsolute = Now() - 1
  Response.Expires = 0
  Response.CacheControl = "no-cache"

  If Session("submittedPage1") = "yes" then	   
	Response.Redirect ("login.asp")
      Response.End
  End If
   
 Response.Write("submittedPage1 = ")%>	<%=Session("submittedPage1")%>	

<p>
<p>

<form method=post action="page2.asp">
  <input type=submit>
</form>	


</head>  
<body>
<script language="javascript">
</script>
</body>
</html>
