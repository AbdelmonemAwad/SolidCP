<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpaceOrganizationsSelector.ascx.cs" Inherits="FuseCP.Portal.SkinControls.SpaceOrganizationsSelector" %>
<div class="col-12 col-md-auto ms-md-auto">
    <div id="spanOrgsSelector" class="OrgsSelector d-flex justify-content-end" runat="server" >
    <div class="input-group w-auto">
        <asp:DropDownList ID="ddlSpaceOrgs" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlSpaceOrgs_SelectedIndexChanged" EnableViewState="true" AutoPostBack="true">
        </asp:DropDownList>
        <asp:HyperLink ID="lnkOrgnsList" runat="server" CssClass="btn btn-primary"><i class="bi bi-pencil" aria-hidden="true"></i><span class="ms-1"><asp:Localize runat="server" meta:resourcekey="locEdit" Text="Edit" /></span></asp:HyperLink>
    </div>
    </div>
</div>