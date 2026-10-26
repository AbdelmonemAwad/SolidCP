<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignedInUser.ascx.cs" Inherits="FuseCP.Portal.SkinControls.SignedInUser" %>

<asp:Panel ID="AnonymousPanel" runat="server" CssClass="signedin-anonymous">
	<asp:HyperLink ID="lnkSignIn" runat="server" meta:resourcekey="lnkSignIn">Sign In</asp:HyperLink>
</asp:Panel>


<asp:Panel ID="LoggedPanel" runat="server" CssClass="signedin-desktop">

    <ul class="nav navbar-sm ms-auto d-none d-sm-block">
        <li>
            <asp:HyperLink ID="lnkEditUserDetails" runat="server">
                <i class="bi bi-person fs-4" aria-hidden="true"></i>
                <span class="visually-hidden"><asp:Localize runat="server" meta:resourcekey="lnkEditUserDetails" /></span>
            </asp:HyperLink>
        </li>
        <li>
            <asp:LinkButton ID="cmdSignOut" runat="server" CausesValidation="false" OnClick="cmdSignOut_Click" ToolTip="<%$ Resources:cmdSignOut.Text %>">
                <i class="bi bi-box-arrow-right fs-4" aria-hidden="true"></i>
                <span class="visually-hidden"><asp:Localize runat="server" Text="<%$ Resources:cmdSignOut.Text %>" /></span>
            </asp:LinkButton>
        </li>
    </ul>
</asp:Panel>


<asp:Panel ID="LoggedPanelSm" runat="server" CssClass="signedin-mobile">
    <ul class="nav navbar-sm ms-auto">
    <li>
     <a href="#" class="show-search">
        <i class="bi bi-search fs-2"></i>
     </a>
    </li>
    <li>
    <asp:HyperLink ID="lnkEditUserDetailsSm" runat="server"><span><i class="bi bi-person fs-2"></i></span>
    </asp:HyperLink>
    </li>
    <li>
    <asp:LinkButton ID="cmdSignOutSm" runat="server" CausesValidation="false" OnClick="cmdSignOut_Click">
        <i class="bi bi-box-arrow-right fs-2"></i>
    </asp:LinkButton>
    </li>
        </ul>
</asp:Panel>