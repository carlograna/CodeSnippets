
<%'************************************************************************************************************************************
'AVOIDING CACHE
'************************************************************************************************************************************
  Response.Buffer = True
  Response.ExpiresAbsolute = Now() - 1
  Response.Expires = 0
  Response.CacheControl = "no-cache"   
    
'************************************************************************************************************************************
 %>


 
 

<HTML>
<HEAD>
<title><!--#include file ="pagefiles/title.asp"--></title>
<link href="pagefiles/css/treasurer.css" rel="stylesheet" type="text/css">
</HEAD>
<body topmargin=0 leftmargin=0  onLoad="return popup('popup.asp', 'swsm');">

</body>
</html>

<SCRIPT TYPE="text/jscript">

function popup(mylink,windowname)
{
  //Testing if the user's browser has popup enabled
  var swsmPopUp = window.open(mylink, windowname, 'width=310,height=200,scrollbars=no');
   if(swsmPopUp){
        //popUpsBlocked = false
       window.location= "/indexPopup.asp";
   }      
  else{ 
       //var popUpsBlocked = true 
       window.location= "/indexNOpopup.asp";
  }  
}

</SCRIPT>



