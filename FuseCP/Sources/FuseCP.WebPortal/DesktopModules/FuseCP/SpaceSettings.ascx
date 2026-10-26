<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpaceSettings.ascx.cs" Inherits="FuseCP.Portal.SpaceSettings" %>
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
            <li><asp:HyperLink ID="lnkNameServers" runat="server" meta:resourcekey="lnkNameServers" Text="Name Servers"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkPreviewDomain" runat="server" meta:resourcekey="lnkPreviewDomain" Text="Preview Domain"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkSharedSSL" runat="server" meta:resourcekey="lnkSharedSSL" Text="Shared SSL Sites"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkPackagesFolder" runat="server" meta:resourcekey="lnkPackagesFolder" Text="Child Spaces Location"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkDnsRecords" runat="server" meta:resourcekey="lnkDnsRecords" Text="Global DNS Records"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkExchangeServer" runat="server" meta:resourcekey="lnkExchangeServer" Text="Exchange Server"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkVps" runat="server" meta:resourcekey="lnkVps" Text="Virtual Private Servers"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkVps2012" runat="server" meta:resourcekey="lnkVps2012" Text="HyperV"></asp:HyperLink></li>
            <li><asp:HyperLink ID="lnkVpsForPC" runat="server" meta:resourcekey="lnkVpsForPC" Text="Virtual Private Servers for Private Cloud"></asp:HyperLink></li>
        </ul>
    </asp:Panel>
                                </div></div>
