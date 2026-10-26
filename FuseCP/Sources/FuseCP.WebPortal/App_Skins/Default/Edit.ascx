<%@ Control AutoEventWireup="true" %>
<%@ Import Namespace="FuseCP.Portal" %>
<%@ Register TagPrefix="fcp" TagName="SiteFooter" Src="~/DesktopModules/FuseCP/SkinControls/SiteFooter.ascx" %>
<%@ Register TagPrefix="fcp" TagName="TopMenu" Src="~/DesktopModules/FuseCP/SkinControls/TopMenu.ascx" %>
<%@ Register TagPrefix="fcp" TagName="Logo" Src="~/DesktopModules/FuseCP/SkinControls/Logo.ascx" %>
<%@ Register TagPrefix="fcp" TagName="SignedInUser" Src="~/DesktopModules/FuseCP/SkinControls/SignedInUser.ascx" %>
<%@ Register TagPrefix="fcp" TagName="GlobalSearch" Src="~/DesktopModules/FuseCP/SkinControls/GlobalSearch.ascx" %>
<%@ Register TagPrefix="fcp" TagName="GlobalSearchTop" Src="~/DesktopModules/FuseCP/SkinControls/GlobalSearch.ascx" %>
<%@ Register TagPrefix="fcp" TagName="UserSpaceBreadcrumb" Src="~/DesktopModules/FuseCP/SkinControls/UserSpaceBreadcrumb.ascx" %>
<%@ Register TagPrefix="fcp" TagName="ThemeScripts" Src="~/DesktopModules/FuseCP/SkinControls/ThemeScripts.ascx" %>
 
<asp:ScriptManager ID="scriptManager" runat="server" AsyncPostBackTimeout="1800" EnablePartialRendering="true" EnableScriptGlobalization="true" EnableScriptLocalization="true">
    <Services>
        <asp:ServiceReference Path="~/DesktopModules/FuseCP/TaskManager.asmx" />
    </Services>
</asp:ScriptManager>
<!-- WRAPPER -->
<div class="wrapper" id="SkinOutline">
    <nav class="top-bar navbar-fixed-top" role="navigation">
        <div class="search-top" style="display: none;">
            <fcp:GlobalSearch ID="GlobalSearchTop" runat="server" />
        </div>
        <div class="logo-area">
            <a class="btn btn-link btn-off-canvas float-start"><i class="bi bi-list"></i></a>
            <div class="logo float-start">
                <fcp:Logo ID="logo" runat="server" />
            </div>
        </div>
        <fcp:SignedInUser ID="signedInUser" runat="server" />
        <div class="d-none d-sm-block">
            <fcp:GlobalSearch ID="globalSearch" runat="server" />
        </div>
    </nav>
    <!-- END TOP NAV BAR -->
    <!-- COLUMN LEFT -->
    <div id="col-left" class="col-left">
        <div class="main-nav-wrapper">
            <nav id="main-nav" class="main-nav">
                <a href="#" id="btn-nav-sidebar-minified" class="btn btn-link btn-nav-sidebar-minified" title='<%: PortalUtils.GetSharedLocalizedString(Utils.ModuleName, "Skin.CollapseMenu") %>' aria-label='<%: PortalUtils.GetSharedLocalizedString(Utils.ModuleName, "Skin.CollapseMenu") %>' data-label-collapse='<%: PortalUtils.GetSharedLocalizedString(Utils.ModuleName, "Skin.CollapseMenu") %>' data-label-expand='<%: PortalUtils.GetSharedLocalizedString(Utils.ModuleName, "Skin.ExpandMenu") %>'><i class="bi bi-chevron-bar-left"></i></a>
                <h3><%: PortalUtils.GetSharedLocalizedString(Utils.ModuleName, "Skin.MainMenu") %></h3>
                <fcp:TopMenu ID="leftMenu" runat="server" MenuAlignment="left" />
                <asp:PlaceHolder ID="LeftPane" runat="server"></asp:PlaceHolder>
                <fcp:TopMenu ID="rightMenu" runat="server" MenuAlignment="right" />
            </nav>
        </div>
    </div>
    <!-- END COLUMN LEFT -->
    <!-- COLUMN RIGHT -->
    <div id="col-right" class="col-right">
        <div class="container-fluid primary-content" id="SkinContent">
            <!-- PRIMARY CONTENT HEADING -->
            <div class="primary-content-heading clearfix">
                <fcp:UserSpaceBreadcrumb ID="UserSpaceBreadcrumb" runat="server" />
                <section id="ContentOneColumn">
                    <asp:PlaceHolder ID="ContentPane" runat="server"></asp:PlaceHolder>
                </section>
            </div>
            <!-- END PRIMARY CONTENT HEADING -->
            <div class="widget widget-no-header widget-transparent bottom-30px"></div>
        </div>
        <div id="Footer" class="content-footer">
            <fcp:SiteFooter ID="footer" runat="server" />
        </div>
    </div>
</div>
<!-- Javascript -->
<fcp:ThemeScripts ID="themeScripts" runat="server" />