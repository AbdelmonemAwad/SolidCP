<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RDSCollectionUsers.ascx.cs" Inherits="FuseCP.Portal.RDS.UserControls.RDSCollectionUsers" %>
<%@ Register Src="../../UserControls/PopupHeader.ascx" TagName="PopupHeader" TagPrefix="fcp" %>

<asp:UpdatePanel ID="UsersUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="FormButtonsBarClean">
            <asp:LinkButton ID="btnDelete" CssClass="btn btn-danger" runat="server" OnClick="btnDelete_Click" OnClientClick="ShowProgressDialog('Checking users ...');return true;"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>&nbsp;
            <asp:LinkButton ID="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click" OnClientClick="ShowProgressDialog('Loading ...');return true;"> <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddText"/> </asp:LinkButton>
        </div>
        <asp:GridView ID="gvUsers" runat="server" meta:resourcekey="gvUsers" AutoGenerateColumns="False"
            CssSelectorClass="NormalGridView" OnRowCommand="gvUsers_RowCommand"
            DataKeyNames="AccountName">
            <Columns>
                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkSelectAll" runat="server" onclick="javascript:SelectAllCheckboxes(this);" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" />
                    </ItemTemplate>
                    <ItemStyle Width="10px" />
                </asp:TemplateField>
                <asp:TemplateField meta:resourcekey="gvUsersAccount" HeaderText="gvUsersAccount">
                    <ItemStyle CssClass="text-start" Wrap="false"></ItemStyle>
                    <ItemTemplate>
                        <asp:Literal ID="litAccount" runat="server" Text='<%# Eval("DisplayName") %>'></asp:Literal>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# GetThemedImage("Exchange/admin_16.png") %>' Visible='<%# Convert.ToBoolean(Eval("IsVIP")) %>' ImageAlign="AbsMiddle" />
                        <asp:HiddenField ID="hdnSamAccountName" runat="server" Value='<%# Eval("SamAccountName") %>' />
                        <asp:HiddenField ID="hdnIsVip" runat="server" Value='<%# Eval("IsVIP").ToString() %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField meta:resourcekey="gvEmail" HeaderText="gvEmail">
                    <ItemStyle CssClass="text-start" Wrap="false"></ItemStyle>
                    <ItemTemplate>
                        <asp:Literal ID="litEmail" runat="server" Text='<%# Eval("PrimaryEmailAddress") %>'></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField meta:resourcekey="gvSetupInstructions">
                    <ItemStyle HorizontalAlign="right"></ItemStyle>
                    <ItemTemplate>
                        <asp:LinkButton ID="lbSetupInstructions" CommandName="SetupInstructions" CommandArgument='<%# Eval("AccountId")%>' runat="server"
                            Text="Setup Instructions" OnClientClick="ShowProgressDialog('Loading ...');return true;" meta:resourcekey="lbSetupInstructions" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />


        <asp:Panel ID="AddAccountsPanel" runat="server" Style="display: none">
            <div class="widget">
                <div class="widget-header clearfix">
                    <h3><i class="bi bi-person"></i>
                        <asp:Localize ID="headerAddAccounts" runat="server" meta:resourcekey="headerAddAccounts"></asp:Localize><h3 />
                </div>
                <div class="widget-content Popup">
                    <asp:UpdatePanel ID="AddAccountsUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>

                            <div class="FormButtonsBarClean">
                                <div class="FormButtonsBarCleanRight">
                                    <asp:Panel ID="SearchPanel" runat="server" DefaultButton="cmdSearch">
                                        <div class="d-flex flex-wrap gap-2 align-items-center">
                                            <div class="input-group">
                                                <asp:DropDownList ID="ddlSearchColumn" runat="server" CssClass="form-control">
                                                    <asp:ListItem Value="DisplayName" meta:resourcekey="ddlSearchColumnDisplayName">DisplayName</asp:ListItem>
                                                    <asp:ListItem Value="PrimaryEmailAddress" meta:resourcekey="ddlSearchColumnEmail">Email</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtSearchValue" runat="server" CssClass="form-control"></asp:TextBox><div class="d-flex">
                                                    <asp:LinkButton ID="cmdSearch" runat="server" meta:resourcekey="cmdSearch" CausesValidation="false" OnClick="cmdSearch_Click" CssClass="btn btn-primary"><i class="bi bi-search" aria-hidden="true"></i></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="Popup-Scroll">
                                <asp:GridView ID="gvPopupAccounts" runat="server" meta:resourcekey="gvPopupAccounts" AutoGenerateColumns="False"
                                    CssSelectorClass="NormalGridView"
                                    DataKeyNames="AccountName">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkSelectAll" runat="server" onclick="javascript:SelectAllCheckboxes(this);" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" runat="server" />
                                                <asp:Literal ID="litAccountType" runat="server" Visible="false" Text='<%# Eval("AccountType") %>'></asp:Literal>
                                            </ItemTemplate>
                                            <ItemStyle Width="10px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField meta:resourcekey="gvAccountsDisplayName">
                                            <ItemStyle CssClass="text-start"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Image ID="imgAccount" runat="server" ImageUrl='<%# GetAccountImage((int)Eval("AccountType")) %>' ImageAlign="AbsMiddle" />
                                                <asp:Literal ID="litDisplayName" runat="server" Text='<%# Eval("DisplayName") %>'></asp:Literal><asp:HiddenField ID="hdnSamName" runat="server" Value='<%# Eval("SamAccountName") %>' />
                                                <asp:HiddenField ID="hdnLocalAdmin" runat="server" Value='<%# Eval("IsVIP").ToString() %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField meta:resourcekey="gvAccountsEmail">
                                            <ItemStyle CssClass="text-start"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Literal ID="litPrimaryEmailAddress" runat="server" Text='<%# Eval("PrimaryEmailAddress") %>'></asp:Literal>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="popup-buttons text-end">
                        <asp:LinkButton ID="btnCancelAdd" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClientClick="CloseProgressDialog();">
                            <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancelText" />
                        </asp:LinkButton>
                        &nbsp;
                        <asp:LinkButton ID="btnAddSelected" CssClass="btn btn-success" runat="server" OnClick="btnAddSelected_Click" OnClientClick="CloseProgressDialog();">
                            <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddSelectedText" />
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="DeleteWarningPanel" runat="server" Style="display: none">
            <div class="widget">
                <div class="widget-header clearfix">
                    <h3><i class="bi bi-trash"></i>
                        <asp:Localize ID="lcDeleteWarningHeader" runat="server" meta:resourcekey="headerDeleteWarning"></asp:Localize><h3 />
                </div>
                <div class="widget-content Popup">
                    <asp:UpdatePanel ID="deleteWarningUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>
                            <div class="Popup-Scroll" style="height: auto">
                                <asp:Panel runat="server" ID="panelDeleteWarning">
                                    <asp:Localize runat="server" ID="locDeleteWarning" Text="Unable to remove the following user(s) since they are local admins or<br/>they were granted access to remote applications" />
                                    <br />
                                    <asp:Literal runat="server" ID="ltUsers" Text="" />
                                </asp:Panel>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="popup-buttons text-end">
                    <asp:LinkButton ID="btnCancelDeleteWarning" CssClass="btn btn-warning" runat="server" CausesValidation="False">
                        <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancelDeleteWarningText" />
                    </asp:LinkButton>
                </div>
            </div>
        </asp:Panel>
        <asp:Button ID="btnDeleteWarningFake" runat="server" Style="display: none;" />
        <ajaxToolkit:ModalPopupExtender ID="DeleteWarningModal" runat="server" TargetControlID="btnDeleteWarningFake" PopupControlID="DeleteWarningPanel"
            BackgroundCssClass="modalBackground" DropShadow="false" CancelControlID="btnCancelDeleteWarning" />

        <asp:Button ID="btnAddAccountsFake" runat="server" Style="display: none;" />
        <ajaxToolkit:ModalPopupExtender ID="AddAccountsModal" runat="server"
            TargetControlID="btnAddAccountsFake" PopupControlID="AddAccountsPanel"
            BackgroundCssClass="modalBackground" DropShadow="false" CancelControlID="btnCancelAdd" />

    </ContentTemplate>
</asp:UpdatePanel>
