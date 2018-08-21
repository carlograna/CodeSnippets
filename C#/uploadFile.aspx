<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="uploadFile.aspx.cs" Inherits="FileUploadProject._Default" MasterPageFile="~/HolderSite.Master"%>
<asp:Content ID="uploadFileContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">--%>
    <p>Upload file with Owner Information:</p>
    <asp:FileUpload ID="SingleFileUpload" runat="server"  />
    <p>
        <asp:Button ID="SingleFileUploadButton" runat="server" Text="Upload File" 
            OnClick="SingleFileUploadButton_Click"/>        
    </p>
    <asp:Label ID="ErrLbl" runat="server"></asp:Label>   




<%--    
    </form>
    
</body>
</html>--%>

</asp:Content>
