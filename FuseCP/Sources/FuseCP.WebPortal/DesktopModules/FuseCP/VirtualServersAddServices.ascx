<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VirtualServersAddServices.ascx.cs" Inherits="FuseCP.Portal.VirtualServersAddServices" %>
<div class="FormButtonsBar">
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAdd"/> </asp:LinkButton>
</div>
<div class="card-body form-horizontal">
    <asp:DataList ID="dlServers" Runat="server" RepeatColumns="3" RepeatDirection="Horizontal">
	    <ItemStyle Height="120px" VerticalAlign="Top"></ItemStyle>
	    <ItemTemplate>
            <div class="col-sm-12">
                <div class="card border-info server-panel matchHeight">
                    <div class="card-header">
                        <h3 class="card-title m-0 d-flex align-items-center gap-2 text-nowrap overflow-hidden" title="<%# (((string)Eval("ServerName")) ?? string.Empty).Trim() %>">
                            <i class="bi bi-server" aria-hidden="true"></i>
                            <span><%# (((string)Eval("ServerName")) ?? string.Empty).Trim() %></span>
                        </h3>
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <%# Eval("Comments") %>
                        </li>
                        <li class="list-group-item">
                            <asp:DataList ID="dlServices" Runat="server" DataSource='<%# GetServerServices((int)Eval("ServerID")) %>'
                            DataKeyField="ServiceID">
							    <ItemStyle CssClass="text-start" Wrap="false"></ItemStyle>
							    <ItemTemplate>
				                     <asp:CheckBox ID="chkSelected" runat="server" Text='<%# Eval("ServiceName") %>' />
							    </ItemTemplate>
						    </asp:DataList>
                        </li>
                    </ul>
                </div>
            </div>
	    </ItemTemplate>
    </asp:DataList>
</div>
