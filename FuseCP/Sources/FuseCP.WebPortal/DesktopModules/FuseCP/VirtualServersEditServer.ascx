<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VirtualServersEditServer.ascx.cs" Inherits="FuseCP.Portal.VirtualServersEditServer" %>
<%@ Register Src="GlobalDnsRecordsControl.ascx" TagName="GlobalDnsRecordsControl" TagPrefix="uc1" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="UserControls/CollapsiblePanel.ascx" %>

<div class="card-body form-horizontal">
    <asp:ValidationSummary ID="summary" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="VirtualServer" />
    <div class="row mb-3">
        <label class="col-sm-2">
            <asp:Label ID="lblServerName" runat="server" meta:resourcekey="lblServerName"></asp:Label></label>
        <div class="col-sm-10">
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="VirtualServerNameValidator" runat="server" ControlToValidate="txtName"
                ValidationGroup="VirtualServer" meta:resourcekey="VirtualServerNameValidator"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="row mb-3">
        <label class="col-sm-2">
            <asp:Label ID="lblServerComments" runat="server" meta:resourcekey="lblServerComments"></asp:Label></label>
        <div class="col-sm-10">
            <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" Rows="2" TextMode="MultiLine"></asp:TextBox>
        </div>
    </div>
    <fcp:CollapsiblePanel ID="secServices" runat="server"
        TargetControlID="ServicesPanel" ResourceKey="secServices" Text="Services"></fcp:CollapsiblePanel>
    <asp:Panel ID="ServicesPanel" runat="server">
        <div class="row mb-3" id="rowPrimaryGroup" runat="server">
            <label class="col-sm-2">
                <asp:Label ID="lblPDR" runat="server" meta:resourcekey="lblPDR" Text="Primary distribution group:"></asp:Label></label>
            <div class="col-sm-10">
                <asp:DropDownList ID="ddlPrimaryGroup" runat="server" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
            </div>
        </div>
        <div class="text-end">
            <asp:LinkButton ID="btnAddServices" runat="server" CssClass="btn btn-primary" OnClick="btnAddServices_Click">
                <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddServices" />
            </asp:LinkButton>
            <asp:LinkButton ID="btnRemoveSelected" runat="server" CssClass="btn btn-danger"  OnClick="btnRemoveSelected_Click" >
                <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnRemoveSelected" />
            </asp:LinkButton>
            <br /><br/>
        </div>
        <asp:DataList ID="dlServiceGroups" RepeatLayout="Flow" RepeatDirection="Horizontal" runat="server" DataKeyField="GroupID" OnItemDataBound="dlServiceGroups_ItemDataBound">
            <ItemTemplate>
                <div class="card border-info">
                    <div class="card-header">
                        <%# GetSharedLocalizedString("ResourceGroup." + (string)Eval("GroupName")) %>
                    </div>
                    <div class="card-body">
<fieldset  id="tblGroupDistribution" runat="server">
                        <div class="row mb-3" id="rowBound" runat="server">
                            <label class="col-sm-2">Distribution</label>
                            <div class="col-sm-10">
                                <asp:CheckBox ID="chkBind" runat="server" Text="Bind to primary" CssClass="fcp-check-inline"
                                    AutoPostBack="true" Checked='<%# Eval("BindDistributionToPrimary") %>' />
                            </div>
                        </div>
                        <div class="row mb-3" id="rowDistType" runat="server">
                            <label class="col-sm-2">Distribution Type</label>
                            <div class="col-sm-10">
                                <asp:DropDownList ID="ddlDistType" runat="server" CssClass="form-control" SelectedValue='<%# Eval("DistributionType") %>'>
                                    <asp:ListItem Value="1">Balanced</asp:ListItem>
                                    <asp:ListItem Value="2">Randomized</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
						</fieldset>
                        <div class="row">
                            <asp:DataList ID="dlServices" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                DataSource='<%# GetGroupServices((int)Eval("GroupID")) %>'
                                DataKeyField="ServiceID">
                                <%--<ItemStyle CssClass="Brick text-start" VerticalAlign="Top"></ItemStyle>--%>
                                <ItemTemplate>
                                    <div class="col-md-6">
                                        <div class="card border-success">
                                            <div class="card-header">
                                                <h3 class="card-title m-0 d-flex align-items-center gap-2 text-nowrap overflow-hidden" title="<%# (((string)Eval("ServerName")) ?? string.Empty).Trim() %>">
                                                    <i class="bi bi-server"></i>
                                                    <span><%# (((string)Eval("ServerName")) ?? string.Empty).Trim() %></span>
                                                </h3>
                                            </div>
                                            <div class="card-body">
                                                <div class="checkbox">
                                                    <label>
                                                        <asp:CheckBox ID="chkSelected" runat="server" />
                                                        <%# Eval("ServiceName") %>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </asp:Panel>

    <fcp:CollapsiblePanel ID="secDnsRecords" runat="server" IsCollapsed="true"
        TargetControlID="DnsRecordsPanel" ResourceKey="secDnsRecords" Text="DNS Records Template">
	</fcp:CollapsiblePanel>

    <asp:Panel ID="DnsRecordsPanel" runat="server">
 
          <uc1:GlobalDnsRecordsControl ID="GlobalDnsRecordsControl" runat="server" ServerIdParam="ServerID" />

    </asp:Panel>


    <fcp:CollapsiblePanel ID="secPreviewDomain" runat="server" IsCollapsed="true"
        TargetControlID="PreviewDomainPanel" ResourceKey="secPreviewDomain" Text="Preview Domain">
	</fcp:CollapsiblePanel>
    <asp:Panel ID="PreviewDomainPanel" runat="server">
         <div class="d-flex flex-wrap gap-2 align-items-center">
      customerdomain.com.&nbsp;
       <asp:TextBox ID="txtPreviewDomain" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="DomainFormatValidator" ValidationGroup="VirtualServer" runat="server" meta:resourcekey="DomainFormatValidator"
                        ControlToValidate="txtPreviewDomain" Display="Dynamic" SetFocusOnError="true"
                        ValidationExpression="^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.){1,16}[a-zA-Z]{2,15}$"></asp:RegularExpressionValidator>
             </div>
    </asp:Panel>
</div>

<div class="card-footer text-end">
    <asp:LinkButton ID="btnDelete" CssClass="btn btn-danger" runat="server" CausesValidation="False" OnClick="btnDelete_Click" OnClientClick="return confirm('Delete server?');"><i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText" />
    </asp:LinkButton>
    &nbsp;
    <asp:LinkButton ID="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"><i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel" />
    </asp:LinkButton>
    &nbsp;
    <asp:LinkButton ID="btnUpdate" CssClass="btn btn-success" runat="server" OnClick="btnUpdate_Click" CausesValidation="true" ValidationGroup="VirtualServer"><i class="bi bi-arrow-clockwise">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnUpdate" />
    </asp:LinkButton>
    &nbsp;
</div>
