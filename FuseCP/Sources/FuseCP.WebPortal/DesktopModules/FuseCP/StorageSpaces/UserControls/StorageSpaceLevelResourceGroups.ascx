<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StorageSpaceLevelResourceGroups.ascx.cs" Inherits="FuseCP.Portal.StorageSpaces.UserControls.StorageSpaceLevelResourceGroups" %>

<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="../../UserControls/CollapsiblePanel.ascx" %>

<asp:UpdatePanel ID="ResourceGroupsUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
        <div class="FormButtonsBarClean">
            <asp:LinkButton id="btnDelete" CssClass="btn btn-danger" runat="server" OnClick="btnDelete_Click"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>&nbsp;
            <asp:LinkButton id="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click"> <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddText"/> </asp:LinkButton>
        </div>
        <asp:GridView ID="gvResourceGroups" runat="server" meta:resourcekey="gvResourceGroups" AutoGenerateColumns="False"
            Width="600px" CssSelectorClass="NormalGridView" 
            DataKeyNames="GroupId">
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
                <asp:TemplateField meta:resourcekey="gvResourceGroupsName" >
                    <ItemStyle CssClass="text-start" Wrap="false"></ItemStyle>
                    <ItemTemplate>
                        <asp:Literal ID="litGroupName" runat="server" Text='<%# LocalizeGroup(Eval("GroupName").ToString()) %>'></asp:Literal>
                        <asp:HiddenField ID="hdnGroupId" runat="server" Value='<%# Eval("GroupId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />


        <asp:Panel ID="AddAccountsPanel" runat="server" Style="display: none">
            <div class="widget">
             <div class="widget-header clearfix">
                           <h3><i class="bi bi-plus-lg"></i> <asp:Localize ID="headerAddResourceGroups" runat="server" meta:resourcekey="headerAddResourceGroups"></asp:Localize></h3>
                   </div>
                    <div class="widget-content">
                    <asp:UpdatePanel ID="AddAccountsUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                        <ContentTemplate>

                            <div class="FormButtonsBarClean">
                                <div class="FormButtonsBarCleanRight">
                                    <asp:Panel ID="SearchPanel" runat="server" DefaultButton="cmdSearch">
                                        <div class="d-flex flex-wrap gap-2 align-items-center">
                                            <div class="input-group">
                                        <asp:TextBox ID="txtSearchValue" runat="server" CssClass="form-control"></asp:TextBox>
                <div class="d-flex">
                    <asp:LinkButton ID="cmdSearch" Runat="server" meta:resourcekey="cmdSearch" CausesValidation="false" OnClick="cmdSearch_Click" CssClass="btn btn-primary"><i class="bi bi-search" aria-hidden="true"></i></asp:LinkButton>
                       </div></div></div>
                                    </asp:Panel>
                                </div>
                            </div>
                            <div class="Popup-Scroll">
                                <asp:GridView ID="gvPopupResourceGroups" runat="server" meta:resourcekey="gvPopupResourceGroups" AutoGenerateColumns="False"
                                    CssSelectorClass="NormalGridView"
                                    DataKeyNames="GroupId">
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
                                        <asp:TemplateField meta:resourcekey="gvResourceGroupsName">
                                            <ItemStyle CssClass="text-start"></ItemStyle>
                                            <ItemTemplate>
                                                <asp:Literal ID="litGroupName" runat="server" Text='<%# LocalizeGroup(Eval("GroupName").ToString()) %>'></asp:Literal>
                                                <asp:HiddenField ID="hdnGroupId" runat="server" Value='<%# Eval("GroupId") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br /><br />
                    <asp:LinkButton id="btnCancelAdd" CssClass="btn btn-warning" runat="server" CausesValidation="False"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancelText"/> </asp:LinkButton>&nbsp;
                    <asp:LinkButton id="btnAddSelected" CssClass="btn btn-success" runat="server" OnClick="btnAddSelected_Click"> <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddSelectedText"/> </asp:LinkButton>
                </div>
            </div>
        </asp:Panel>

        <asp:Button ID="btnAddAccountsFake" runat="server" Style="display: none;" />
        <ajaxToolkit:ModalPopupExtender ID="AddAccountsModal" runat="server"
            TargetControlID="btnAddAccountsFake" PopupControlID="AddAccountsPanel"
            BackgroundCssClass="modalBackground" DropShadow="false" CancelControlID="btnCancelAdd" />

    </ContentTemplate>
</asp:UpdatePanel>


