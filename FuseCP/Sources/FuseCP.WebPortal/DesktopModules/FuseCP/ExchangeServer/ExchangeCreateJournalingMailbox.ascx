<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ExchangeCreateJournalingMailbox.ascx.cs" Inherits="FuseCP.Portal.ExchangeServer.ExchangeCreateJournalingMailbox" %>
<%@ Register Src="../UserControls/EmailControl.ascx" TagName="EmailControl" TagPrefix="fcp" %>
<%@ Register Src="UserControls/UserSelector.ascx" TagName="UserSelector" TagPrefix="uc1" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/PasswordControl.ascx" TagName="PasswordControl" TagPrefix="fcp" %>
<%@ Register Src="UserControls/EmailAddress.ascx" TagName="EmailAddress" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Menu.ascx" TagName="Menu" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Breadcrumb.ascx" TagName="Breadcrumb" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>
<%@ Register Src="UserControls/MailboxPlanSelector.ascx" TagName="MailboxPlanSelector" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/SendToControl.ascx" TagName="SendToControl" TagPrefix="fcp" %>

<fcp:EnableAsyncTasksSupport ID="asyncTasks" runat="server" />
<script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/exchange-create-mailbox.js"></script>
<div class="card-header">
    <h3 class="card-title">
        <asp:Image ID="Image1" SkinID="ExchangeJournalingMailbox48" runat="server" />
        <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Create Mailbox"></asp:Localize>
    </h3>
</div>

<div class="card-body form-horizontal">
    <fcp:SimpleMessageBox ID="messageBox" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
        <ContentTemplate>


            <div class="card-body">
                <h4>
                    <asp:Literal ID="TopComments" runat="server" meta:resourcekey="TopComments" /></h4>
                <div class="radio">
                    <label class="btn btn-primary form-check-inline" data-initialize="radio" id="radios-inline-0">
                        <asp:RadioButton runat="server" name="radios-inline" type="button" ID="rbtnCreateNewMailbox" AutoPostBack="true" Checked="true" GroupName="CreateMailboxGoup" OnCheckedChanged="rbtnCreateNewMailbox_CheckedChanged" CssClass="visually-hidden form-control" />
                        <span class="radio-label">
                            <asp:Localize runat="server" meta:resourcekey="rbtnCreateNewMailbox" Text="First Name: " /></span>
                    </label>
                    <label class="btn btn-primary form-check-inline" data-initialize="radio" id="radios-inline-1">
                        <asp:RadioButton runat="server" name="radios-inline" type="button" ID="rbtnUserExistingUser" AutoPostBack="true" GroupName="CreateMailboxGoup" OnCheckedChanged="rbtnUserExistingUser_CheckedChanged" CssClass="visually-hidden form-control" />
                        <span class="radio-label">
                            <asp:Localize runat="server" meta:resourcekey="rbtnUserExistingUser" Text="First Name: " /></span>
                    </label>
                </div>
            </div>
            <hr />
            <div id="NewUserDiv" runat="server">

                <fieldset>

                    <div class="row mb-3">
                        <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtFirstName">
                            <asp:Localize ID="locName" runat="server" meta:resourcekey="locName" Text="Name:" />
                        </asp:Label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" onKeyUp="FuseCPExchangeCreateMailbox.buildDisplayName('<%= txtDisplayName.ClientID %>','<%= txtFirstName.ClientID %>','<%= txtInitials.ClientID %>','<%= txtLastName.ClientID %>');" placeholder="First Name"></asp:TextBox>
                                <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <asp:TextBox ID="txtInitials" runat="server" MaxLength="6" CssClass="form-control" onKeyUp="FuseCPExchangeCreateMailbox.buildDisplayName('<%= txtDisplayName.ClientID %>','<%= txtFirstName.ClientID %>','<%= txtInitials.ClientID %>','<%= txtLastName.ClientID %>');" placeholder="Initials"></asp:TextBox>
                        </div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" onKeyUp="FuseCPExchangeCreateMailbox.buildDisplayName('<%= txtDisplayName.ClientID %>','<%= txtFirstName.ClientID %>','<%= txtInitials.ClientID %>','<%= txtLastName.ClientID %>');" placeholder="Last Name"></asp:TextBox>
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

                </fieldset>

                <fcp:SendToControl ID="sendToControl" runat="server" ValidationGroup="CreateMailbox" ControlToHide="PasswordBlock"></fcp:SendToControl>
                <div id="PasswordBlock" runat="server">
                    <fcp:PasswordControl ID="password" runat="server" ValidationGroup="CreateMailbox" AllowGeneratePassword="true"></fcp:PasswordControl>
                </div>
            </div>
            <div id="ExistingUserDiv" visible="false" runat="server">
                <div class="container">
                    <div class="row mb-3">
                        <label for="userSelector">
                            <asp:Localize ID="Localize1" runat="server" meta:resourcekey="locDisplayName" Text="Display Name:" />
                        </label>
                        <uc1:UserSelector ID="userSelector" runat="server"></uc1:UserSelector>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <fieldset>
        <div class="row mb-3">
            <label for="mailboxPlanSelector" class="col-sm-2 form-label">
                <asp:Localize ID="locMailboxplanName" runat="server" meta:resourcekey="locMailboxplanName" Text="Mailboxplan Name: *" />
            </label>
            <div class="col-sm-10">
                <div class="input-group">
                    <fcp:MailboxPlanSelector ID="mailboxPlanSelector" runat="server" Archiving="false" IsForJournaling="true" ValidationGroup="CreateMailbox" OnChanged="mailboxPlanSelector_Change" />
                </div>
            </div>
        </div>

        <hr />

        <div class="row mb-3">
            <label for="ddlScope" class="col-sm-2 form-label">
                <asp:Localize ID="locScope" runat="server" meta:resourcekey="locScope" Text="If the message is sent to or received from:" />
            </label>
            <div class="col-sm-10">
                <div class="input-group">
                    <asp:DropDownList ID="ddlScope" runat="server" CssClass="form-control col-sm-4">
                        <asp:ListItem Selected="True" Value="Global" meta:resourcekey="ddlScopeGlobal">All messages</asp:ListItem>
                        <asp:ListItem Value="Internal" meta:resourcekey="ddlScopeInternal">Internal messages only</asp:ListItem>
                        <asp:ListItem Value="External" meta:resourcekey="ddlScopeExternal">External messages only</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <label for="ddlRecipient" class="col-sm-2 form-label">
                <asp:Localize ID="locRecipient" runat="server" meta:resourcekey="locRecipient" Text="Journal messages sent to or received from:" />
            </label>
            <div class="col-sm-10">
                <div class="input-group">
                    <asp:DropDownList ID="ddlRecipient" runat="server" CssClass="form-control col-sm-4" />
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-sm-2 form-label">
            </div>
            <div class="col-sm-10">
                <div class="input-group">
                    <asp:CheckBox ID="cbEnabled" runat="server" Checked="true" meta:resourcekey="locEnabled" Text="Enable journal rule"/>
                </div>
            </div>
        </div>

    </fieldset>

</div>

<div class="card-footer text-end">
    <asp:LinkButton ID="btnCreate" CssClass="btn btn-success" runat="server" OnClick="btnCreate_Click" ValidationGroup="CreateMailbox" meta:resourcekey="btnCreate" OnClientClick="ShowProgressDialog('Creating journaling mailbox...');">
        <i class="bi bi-envelope">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCreateText" />
    </asp:LinkButton>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="CreateMailbox" />
</div>
