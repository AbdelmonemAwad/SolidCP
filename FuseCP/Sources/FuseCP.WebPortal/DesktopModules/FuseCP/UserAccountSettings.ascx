<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserAccountSettings.ascx.cs" Inherits="FuseCP.Portal.UserAccountSettings" %>
<div class="widget">
							<div class="widget-header clearfix">
								<h3><i class="bi bi-cogs"></i> <span><asp:Localize id="SettingsHeader" runat="server" meta:resourcekey="SettingsHeader" Text="Settings"></asp:Localize></span></h3>
								<div class="btn-group widget-header-toolbar">
									<a href="#" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.ExpandCollapse %>" class="btn btn-link btn-toggle-expand"><i class="bi bi-chevron-up"></i></a>
									<a href="#" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Remove %>" class="btn btn-link btn-remove"><i class="bi bi-x-lg"></i></a>
								</div>
							</div>
							<div class="widget-content">
	<asp:Panel ID="SettingsPanel" runat="server" CssClass="Normal">
		<ul class="LinksList mb-0">
			<li><asp:HyperLink ID="lnkMailTemplates" runat="server" meta:resourcekey="lnkMailTemplates" Text="Mail Templates"></asp:HyperLink></li>
			<li><asp:HyperLink ID="lnkPolicies" runat="server" meta:resourcekey="lnkPolicies" Text="Policies"></asp:HyperLink></li>
		</ul>
	</asp:Panel>
                                </div>
    </div>
