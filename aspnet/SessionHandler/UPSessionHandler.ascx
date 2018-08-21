<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UPSessionHandler.ascx.cs" Inherits="controls_UPSessionHandler" %>
<script src="/scripts/upSessionHandler.js"></script>
<link href="/css/upSessionHandler.css" rel="stylesheet" />

<div id="GreyoutDiv" runat="server" class="greyoutDiv"  ClientIDMode="Static" style="display:none"></div>

<div id="TimeoutPopup" runat="server" class="timeoutPopup" ClientIDMode="Static" style="display:none">
    <div class="f19">Session Timeout Warning</div>
    <div style="margin: 20px 0 24px">Session timeout in:<div id="TimeoutRemainingTime" class="attention bold" style="display:inline;margin: 0 .45em 0 .6em"></div>seconds</div>
        <%--<asp:Label ID="TimeoutRemainingTime" runat="server" CssClass="attention bold" style="margin: 0 .45em 0 .6em" Text="XX" />--%>
    <ul class="tc piped">
        <li class="first">
            <%--<asp:LinkButton ID="KeepSessionAliveLnkBtn" runat="server" Text="Keep Session Alive" OnClick="KeepSessionAliveLnkBtn_Click" ClientIDMode="Static" />--%>
            <a id="KeepSessionAliveLnkBtn" href="#">Keep Session Alive</a> 
        </li>
        <li>
            <%--<asp:LinkButton ID="EndSessionLnkBtn" runat="server" Text="End Session (Sign Out)" OnClick="EndSessionLnkBtn_Click" ClientIDMode="Static"/>--%>
            <a id="EndSessionLnkBtn" href="#">End Session (Sign Out)</a>
        </li>
    </ul>
</div>