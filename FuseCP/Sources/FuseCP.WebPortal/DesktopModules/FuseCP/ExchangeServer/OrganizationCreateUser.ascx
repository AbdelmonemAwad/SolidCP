<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrganizationCreateUser.ascx.cs" Inherits="FuseCP.Portal.HostedSolution.OrganizationCreateUser" %>
<%@ Register Src="UserControls/EmailAddress.ascx" TagName="EmailAddress" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/PasswordControl.ascx" TagName="PasswordControl" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/QuotaViewer.ascx" TagName="QuotaViewer" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EmailControl.ascx" TagName="EmailControl" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/SendToControl.ascx" TagName="SendToControl" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server"/>

<div id="orgCreateUserConfig"
     data-display-id="<%= txtDisplayName.ClientID %>"
     data-first-id="<%= txtFirstName.ClientID %>"
     data-initials-id="<%= txtInitials.ClientID %>"
     data-last-id="<%= txtLastName.ClientID %>"></div>
<script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/organization-create-user.js"></script>
<div class="card-header">
                    <h3 class="card-title">
                    <asp:Image ID="Image1" SkinID="OrganizationUserAdd48" runat="server" />
                    <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Create User"></asp:Localize>
                </h3>
                        </div>
<asp:UpdatePanel ID="CreateUserUpdatePanel" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div class="card-body form-horizontal">
        <fcp:SimpleMessageBox id="messageBox" runat="server" />
            <div id="NewUserDiv" runat="server">
             
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtFirstName">
                                        <asp:Localize ID="locName" runat="server" meta:resourcekey="locName" Text="Name:" />
                                    </asp:Label>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" onKeyUp="FuseCPOrganizationCreateUser.buildDisplayName();" placeholder="First Name"></asp:TextBox>
                                            <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                            <asp:TextBox ID="txtInitials" runat="server" MaxLength="6" CssClass="form-control" onKeyUp="FuseCPOrganizationCreateUser.buildDisplayName();" placeholder="Initials"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" onKeyUp="FuseCPOrganizationCreateUser.buildDisplayName();" placeholder="Last Name"></asp:TextBox>
                                            <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtDisplayName">
                                        <asp:Localize ID="locDisplayName" runat="server" meta:resourcekey="locDisplayName" Text="Display Name:" />
                                    </asp:Label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                                        </div>
                                        <asp:RequiredFieldValidator ID="valRequireDisplayName" runat="server" meta:resourcekey="valRequireDisplayName" ControlToValidate="txtDisplayName"
                                            ErrorMessage="Enter Display Name" ValidationGroup="CreateMailbox" Display="Dynamic" Text="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                  
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtSubscriberNumber">
                                        <asp:Localize ID="locSubscriberNumber" runat="server" meta:resourcekey="locSubscriberNumber" Text="Account Number:" />
                                    </asp:Label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtSubscriberNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <asp:RequiredFieldValidator ID="valRequireSubscriberNumber" runat="server" meta:resourcekey="valRequireSubscriberNumber" ControlToValidate="txtSubscriberNumber"
                                            ErrorMessage="Enter Account Number" ValidationGroup="CreateMailbox" Display="Dynamic" Text="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="email">
                                        <asp:Localize ID="locAccount" runat="server" meta:resourcekey="locAccount" Text="E-mail Address:" />
                                    </asp:Label>
                                    <div class="col-sm-10">
                                        <fcp:EmailAddress ID="email" runat="server" ValidationGroup="CreateMailbox"></fcp:EmailAddress>
                                    </div>
                                </div>
              
                </div>
                <fcp:SendToControl ID="sendToControl" runat="server" ValidationGroup="CreateMailbox" ControlToHide="PasswordBlock"></fcp:SendToControl>
                <div id="PasswordBlock" runat="server">
                    <fcp:PasswordControl ID="password" runat="server" ValidationGroup="CreateMailbox" AllowGeneratePassword="true"></fcp:PasswordControl>
                    <asp:CheckBox ID="chkUserMustChangePassword" runat="server" meta:resourcekey="chkUserMustChangePassword" Text="User must change password at next login" Visible="False" />
                </div>
                <div class="container">
                    <fieldset>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row mb-3">
                                        <label for="chkSendInstructions" class="col-sm-2 form-label">
                                        <asp:CheckBox ID="chkSendInstructions" runat="server" meta:resourcekey="chkSendInstructions" Text="Send Setup Instructions" Checked="true" />
                                        </label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <fcp:EmailControl id="sendInstructionEmail" runat="server" RequiredEnabled="true" ValidationGroup="CreateMailbox"></fcp:EmailControl></td>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
</ContentTemplate>
</asp:UpdatePanel>
<div class="card-footer text-end">
    <asp:LinkButton id="btnCreate" CssClass="btn btn-success" runat="server" OnClick="btnCreate_Click" ValidationGroup="CreateMailbox" OnClientClick="ShowProgressDialog('Creating user...');"> <i class="bi bi-person">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCreateText"/> </asp:LinkButton>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="CreateMailbox" />
</div>
