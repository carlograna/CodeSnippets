<script runat=server language=vbscript> 

REM -- These are the handy ADO constants defined in VBScript ------------- 
REM -- These are *partial* most commonly used constants, for complete  
REM -- list see the MSDN Library, Platform SDK, Database & Messaging, ADO Docset. 


REM -- ADO command types 
const adCmdText       = 1  
const adCmdTable      = 2  
const adCmdStoredProc = 4 
const adCmdUnknown    = 8 

REM -- ADO cursor types 
const adOpenForwardOnly = 0 '# (Default) 
const adOpenKeyset      = 1 
const adOpenDynamic     = 2 
const adOpenStatic      = 3 

REM -- ADO cursor locations 
const adUseServer         = 2 '# (Default) 
const adUseClient         = 3 

REM -- ADO lock types 
const adLockReadOnly        = 1 
const adLockPessimistic     = 2 
const adLockOptimistic      = 3 
const adLockBatchOptimistic = 4 

REM -- DataTypeEnum Values 
const adVarChar = 200 
const adChar = 129 
const adInteger = 3 
const adDBDate = 133 
const adBinary = 128 
const adCurrency = 6 
const adBoolean = 11 
const adNumeric = 131 
const adSingle = 4 
const adDouble = 5 

REM -- ParameterDirectionEnum Values 
const adParamUnknown = &H0000 
const adParamInput = &H0001 
const adParamOutput = &H0002 
const adParamInputOutput = &H0003 
const adParamReturnValue = &H0004 

REM -- ExecuteOptionEnum Values 
Const adAsyncExecute = 16 
Const adAsyncFetch = 32 
Const adAsyncFetchNonBlocking = 64 
Const adExecuteNoRecords = 128 
Const adBookmarkCurrent = 0 


REM ---- You can now create Classes (objects) using VBScript 5.0.  ADOHelper is defined as a class here. 
REM ---- This requires that new 5.0 ASP script egine be installed on your server.  You can upgrade 
REM ---- Windows NT 4 to the 5.0 ASP script engine by installing IE 5.1 on your computer. 
REM ---- Ideally, you should be using Windows 2000 with IIS 5.0 & IE 5.1 -then everything, including the 
REM ---- New ADO 2.5 and new Oracle OLE/DB and Oracle ODBC drivers are installed, ready to go. 

REM ---- The ADOHelper Class defines common functions you can call to run parameterized, 
REM ---- pre-prepared SQL statements.  This ensures Oracle and SQL cache the query plans 
REM ---- and just bind parameters as needed, instead of recompiling query plans each time. 
REM ---- Also, these functions use optimal cursor types, locking levels, etc. for fastest perf. 
REM ---- Performance would be increased, and manageability of code would be increased, by moving 
REM ---- to use of COM components with Visual Basic, J++ or C++...however, I know this is 
REM ---- not part of your tests.  To componetize these functions with COM, they only need to be 
REM ---- cut and pasted into a VB class file, and compiled as COM/COM+ DLL. 
REM --- HOW TO USE THIS FILE
	'Dim ADODataConnections
	'set ADODataConnections = New ADODataConnections
	'set ors = ADODataConnections.RunSQLReturnRS ("Select * From dbo.Employee","","Northwind")
REM 
Class ADODataConnections

'Function Name: GetConnectionString() 
'Purpose:  Return a valid connection string for ADO. 

Function GetConnectionString(ByVal strDBName)
	select case lcase(strDBName)		
		case "upweb"				
			GetConnectionString =  "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=mailingList;Password=m@!l!ngL!st;Initial Catalog=upweb;Data Source=upserver1;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=workstation;User Id=mailingList;" 
	end select
End Function


'*****Sample Code for RunSP*****
'Place this code in the page that calls RunSP
'Dim TestArray(5)
'TestArray(0)= array(,3,adParamInput,,Value1)
'TestArray(1)= array(,200,adParamInput,50,Value2)
'TestArray(2)= array(,200,adParamInput,50,Value3)
'TestArray(3)= array(,200,adParamInput,50,Value4)
'TestArray(4)= array(,129,adParamInput,2,Value5)
'TestArray(5)= array(,129,adParamInput,4,Value6)
'Note: Where TestArray(5) is used in this sample you should use the
	'number of parameters your predefined stored procedure requires. 
	'In each line where TestArray(?) is set you use the array function with the following parameters:
	'array(Name(leave blank),Data type (see "Using Visual InterDev 1.0 to Pass Parameters to and from Microsoft SQL Server 
	'Stored Procedures"), Direction (use adParamInput),Size (leave blank for numeric values), Value)
'Dim AdoObject
'Set AdoObject = New AdoDataConnections
'AdoObject.RunSP "SPName",TestArray,"", "DBName"
'Set AdoObject = Nothing
'***************************

Function RunSP(ByVal strSP, params, byRef OutArray, ByVal strDBName) 
        'On Error resume next 
         
        ' Create the ADO objects 
        Dim cmd, OutPutParms 
        Set cmd = Server.CreateObject("adodb.Command") 
         
        ' Init the ADO objects & the stored proc parameters 
        cmd.ActiveConnection = GetConnectionString(strDBName) 
        cmd.CommandText = strSP 
        cmd.CommandType = adCmdStoredProc 
        collectParams cmd, params, OutPutParms 
         
        ' Execute the query without returning a recordset 
        cmd.Execute , , adExecuteNoRecords 
        if OutPutParms then OutArray = collectOutputParms(cmd, params) 
        ' Disconnect the recordset and clean up 
        Set cmd.ActiveConnection = Nothing 
        set cmd = Nothing 
        RunSP = 0 
        'Set cmd = Nothing 
End Function 

Function RunSPReturnRS(ByVal strSP, params, byRef OutArray, ByVal strDBName) 

        'On Error resume next 
         
        ' Create the ADO objects 
        Dim rs, cmd, OutPutParms 
        Set rs = Server.CreateObject("adodb.Recordset") 
        Set cmd = Server.CreateObject("adodb.Command") 
         
        ' Init the ADO objects  & the stored proc parameters 
        cmd.ActiveConnection = GetConnectionString(strDBName) 
        cmd.CommandText = strSP 
        cmd.CommandType = adCmdStoredProc 
         
        collectParams cmd, params, OutPutParms 
         
        ' Execute the query for readonly 
        rs.CursorLocation = adUseClient 
        rs.Open cmd, , adOpenStatic, adLockReadOnly 
        if OutPutParms then OutArray = collectOutputParms(cmd, params) 
        ' Disconnect the recordset and clean up 
        ' Disconnect the recordset 
        Set cmd.ActiveConnection = Nothing 
        Set cmd = Nothing 
        Set rs.ActiveConnection = Nothing 

        ' Return the resultant recordset 
        Set RunSPReturnRS = rs 
End Function 


'Function Name: RunSQLReturnRS 
'Purpose:  Run a pre-prepared SQL statement with zero or more parameters,  
'           return an ADO recordset to caller. 

Function RunSQLReturnRS(ByVal strSQL,ByVal params, ByVal strDBName) 
        'On Error resume next 
         
        ' Set up Command and Connection objects 
        Dim rs, cmd, OutPutParms 
        Set rs = Server.CreateObject("adodb.Recordset") 
        Set cmd = Server.CreateObject("adodb.Command")
	  'cmd.ConnectionTimeout = 300
	  cmd.CommandTimeout = 300
        'Run the SQL 
        cmd.ActiveConnection = GetConnectionString(strDBName)
        cmd.CommandText = strSQL 
        cmd.CommandType = adCmdText 
        cmd.Prepared = true 
         
        collectParams cmd, params, OutPutParms 
         
        rs.CursorLocation = adUseClient 
         
        'Note: These are optimal cursor types and lock levels for performance 
        '       In general, if you are not going to update a recordset, then do not 
        '       return an updatable recordset --its more overhead.  Also, open forward 
        '      only and use ADO pagination functions to re-page the recordset.  This 
        '       allows all recordsets to remain completely stateless and disconnected (not 
        '       persisted on per-session basis between pages.  Its still quite easy to 
        '       put page forward/backward functonality into the application, although the 
        '       logic to do so is not included here. I will be happy to show you how 
        '       to do so when I review the complete Nile code you are working from 
                                        
        rs.Open cmd, , adOpenForwardOnly, adLockReadOnly 
         
        ' Disconnect the recordsets and cleanup 
        Set cmd.ActiveConnection = Nothing 
        Set cmd = Nothing 
        Set rs.ActiveConnection = Nothing 
        Set RunSQLReturnRS = rs 
         
End Function 

'Function Name: RunSQLReturnRS 
'Purpose:  Run a pre-prepared SQL statement with zero or more parameters,  
'           return an ADO recordset to caller. 

Function RunSQLReturnRS2(ByVal strSQL,ByVal params, ByVal strDBName) 
        'On Error resume next 
         
        ' Set up Command and Connection objects 
        Dim rs, cmd, OutPutParms 
        Set rs = Server.CreateObject("adodb.Recordset") 
        Set cmd = Server.CreateObject("adodb.Command")
	  'cmd.ConnectionTimeout = 300
	  cmd.CommandTimeout = 300
        'Run the SQL 
        cmd.ActiveConnection = GetConnectionString(strDBName)
        cmd.CommandText = strSQL 
        cmd.CommandType = adCmdText 
        cmd.Prepared = true 
         
        collectParams cmd, params, OutPutParms 
         
        rs.CursorLocation = adUseClient 
         
        'Note: These are optimal cursor types and lock levels for performance 
        '       In general, if you are not going to update a recordset, then do not 
        '       return an updatable recordset --its more overhead.  Also, open forward 
        '      only and use ADO pagination functions to re-page the recordset.  This 
        '       allows all recordsets to remain completely stateless and disconnected (not 
        '       persisted on per-session basis between pages.  Its still quite easy to 
        '       put page forward/backward functonality into the application, although the 
        '       logic to do so is not included here. I will be happy to show you how 
        '       to do so when I review the complete Nile code you are working from 
                                        
        rs.Open cmd, , adOpenStatic, adLockReadOnly 
         
        ' Disconnect the recordsets and cleanup 
        Set cmd.ActiveConnection = Nothing 
        Set cmd = Nothing 
        Set rs.ActiveConnection = Nothing 
        Set RunSQLReturnRS2 = rs 
         
End Function 


'Function Name: RunSQL 
'Purpose:  Run a pre-prepared SQL statement with no returned recordset.  This is what 
'           should be used to run updates, deletes, inserts, for example. 

Function RunSQL(ByVal strSQL, byRef params, ByVal strDBName) 
        'On Error resume next 
         
        ' Create the ADO objects 
        Dim cmd, outPutParms 
        Set cmd = Server.CreateObject("adodb.Command") 

        ' Init the ADO objects & the stored proc parameters 
         
        cmd.ActiveConnection = GetConnectionString(strDBName) 
         
        cmd.CommandText = strSQL 
        cmd.CommandType = adCmdText 
        collectParams cmd, params, OutPutParms 
         
        ' Execute the query without returning a recordset 
        ' Specifying adExecuteNoRecords reduces overhead and improves performance 
        cmd.Execute , , adExecuteNoRecords 
        ' Cleanup 
        Set cmd.ActiveConnection = Nothing 
        Set cmd = Nothing 
End Function 

'Function Name: PageRecords 
'Purpose:  Paginate an ADO recordset, returning a 2-dimensional array 
'           consisting of the database rows for the page requested 
         
Function PageRecords(rs, byRef intPage, byVal PageSize, NumPages, NumRecords)  
     
   If intPage < 1 Then intPage = 1 
   rs.PageSize = PageSize 
   NumPages = rs.PageCount 
   If intPage > NumPages Then intPage = NumPages 
   rs.AbsolutePage = intPage 
   PageRecords = rs.GetRows(PageSize, adBookmarkCurrent) 
   If (intPage < NumPages) Or (rs.RecordCount Mod PageSize = 0) Then 
       NumRecords = PageSize 
   Else 
       NumRecords = rs.RecordCount Mod PageSi
   End If 
     
End Function 

'Sub Name: collectParams 
'Purpose:  collect parameters from array of parameters, for binding to pre- 
'           prepared SQL statements 

Private Sub collectParams(ByRef cmd, ByVal argparams, ByRef OutPutParms) 
        Dim params, v 
        Dim i, l, u 
        'if argparams is empty 
         
        If Not IsArray(argparams) Then Exit Sub 
         
        OutPutParms = false 
        params = argparams 
        For i = LBound(params) To UBound(params) 
            l = LBound(params(i)) 
            u = UBound(params(i)) 
            ' Check for nulls. 
            If u - l >= 3 Then 
                If VarType(params(i)(4)) = vbString Then 
                    if params(i)(4) = "" then 
                        v=null 
                    else 
                        v=params(i)(4) 
                    end if 
                Else 
                    v = params(i)(4) 
                End If 
                if params(i)(2) = adParamOutput then OutPutParms = true 
                cmd.Parameters.Append cmd.CreateParameter(params(i)(0), params(i)(1), params(i)(2), params(i)(3), v) 
            Else 
                err.raise m_modName, "collectParams(...): incorrect # of parameters" 
            End If 
        Next     
         
End Sub   

Private Function collectOutputParms(ByRef cmd, argparams) 
        Dim params, v, OutArray(20) 
        Dim i, l, u 
        'if argparams is empty 
         
        'If Not IsArray(argparams) Then Exit Sub 
         
        params = argparams 
        For i = LBound(params) To UBound(params) 
            OutArray(i) = cmd.Parameters(i).Value                 
        Next     
        collectOutputParms = OutArray 
End Function   

End class 
</script> 