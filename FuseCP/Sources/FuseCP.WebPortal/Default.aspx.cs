// Copyright (C) 2025 FuseCP
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

using System;
using System.Resources;
using System.IO;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Caching;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Globalization;
using System.Diagnostics;
using FuseCP.Portal;
using FuseCP.Providers.OS;
using System.Linq;
using System.Text.RegularExpressions;

namespace FuseCP.WebPortal
{
    public partial class DefaultPage : System.Web.UI.Page
    {
        private const string THEME_PALETTE_LIGHT_COOKIE = "UserThemePaletteLight";
        private const string THEME_PALETTE_DARK_COOKIE = "UserThemePaletteDark";
        private const string THEME_BUTTONS_LIGHT_COOKIE = "UserThemeButtonsLight";
        private const string THEME_BUTTONS_DARK_COOKIE = "UserThemeButtonsDark";
        private const string THEME_MODE_COOKIE = "UserThemeMode";
        private const string BOOTSTRAP_STYLESHEET = "bootstrap5.min.css";
        private const string BOOTSTRAP_RTL_STYLESHEET = "~/Styles/bootstrap5.rtl.min.css";

        private CultureInfo requestCulture;

        private static readonly string[] LightPaletteCssVars = new[]
        {
            "--fcp-bg",
            "--fcp-topbar-bg",
            "--fcp-topbar-bdr",
            "--fcp-sidebar-bg",
            "--fcp-surface",
            "--fcp-surface-alt",
            "--fcp-surface-h",
            "--fcp-border",
            "--fcp-input-bdr",
            "--fcp-text",
            "--fcp-text-hi",
            "--fcp-accent"
        };

        private static readonly string[] DarkPaletteCssVars = new[]
        {
            "--fcp-dark-bg",
            "--fcp-dark-topbar-bg",
            "--fcp-dark-topbar-bdr",
            "--fcp-dark-sidebar-bg",
            "--fcp-dark-surface",
            "--fcp-dark-surface-alt",
            "--fcp-dark-surface-h",
            "--fcp-dark-border",
            "--fcp-dark-input-bdr",
            "--fcp-dark-text",
            "--fcp-dark-text-hi",
            "--fcp-dark-accent"
        };

        private static readonly string[] LightButtonCssVars = new[]
        {
            "--fcp-btn-primary-text",
            "--fcp-btn-primary-bg",
            "--fcp-btn-primary-bdr",
            "--fcp-btn-primary-h-text",
            "--fcp-btn-primary-h-bg",
            "--fcp-btn-primary-h-bdr",
            "--fcp-btn-success-text",
            "--fcp-btn-success-bg",
            "--fcp-btn-success-bdr",
            "--fcp-btn-success-h-text",
            "--fcp-btn-success-h-bg",
            "--fcp-btn-success-h-bdr",
            "--fcp-btn-danger-text",
            "--fcp-btn-danger-bg",
            "--fcp-btn-danger-bdr",
            "--fcp-btn-danger-h-text",
            "--fcp-btn-danger-h-bg",
            "--fcp-btn-danger-h-bdr",
            "--fcp-btn-warning-text",
            "--fcp-btn-warning-bg",
            "--fcp-btn-warning-bdr",
            "--fcp-btn-warning-h-text",
            "--fcp-btn-warning-h-bg",
            "--fcp-btn-warning-h-bdr",
            "--fcp-btn-info-text",
            "--fcp-btn-info-bg",
            "--fcp-btn-info-bdr",
            "--fcp-btn-info-h-text",
            "--fcp-btn-info-h-bg",
            "--fcp-btn-info-h-bdr",
            "--fcp-btn-radius"
        };

        private static readonly string[] DarkButtonCssVars = new[]
        {
            "--fcp-dark-btn-primary-text",
            "--fcp-dark-btn-primary-bg",
            "--fcp-dark-btn-primary-bdr",
            "--fcp-dark-btn-primary-h-text",
            "--fcp-dark-btn-primary-h-bg",
            "--fcp-dark-btn-primary-h-bdr",
            "--fcp-dark-btn-success-text",
            "--fcp-dark-btn-success-bg",
            "--fcp-dark-btn-success-bdr",
            "--fcp-dark-btn-success-h-text",
            "--fcp-dark-btn-success-h-bg",
            "--fcp-dark-btn-success-h-bdr",
            "--fcp-dark-btn-danger-text",
            "--fcp-dark-btn-danger-bg",
            "--fcp-dark-btn-danger-bdr",
            "--fcp-dark-btn-danger-h-text",
            "--fcp-dark-btn-danger-h-bg",
            "--fcp-dark-btn-danger-h-bdr",
            "--fcp-dark-btn-warning-text",
            "--fcp-dark-btn-warning-bg",
            "--fcp-dark-btn-warning-bdr",
            "--fcp-dark-btn-warning-h-text",
            "--fcp-dark-btn-warning-h-bg",
            "--fcp-dark-btn-warning-h-bdr",
            "--fcp-dark-btn-info-text",
            "--fcp-dark-btn-info-bg",
            "--fcp-dark-btn-info-bdr",
            "--fcp-dark-btn-info-h-text",
            "--fcp-dark-btn-info-h-bg",
            "--fcp-dark-btn-info-h-bdr",
            "--fcp-dark-btn-radius"
        };

        private static readonly Regex PaletteHexColorRegex = new Regex("^#(?:[0-9A-Fa-f]{3}|[0-9A-Fa-f]{6})$", RegexOptions.Compiled);
        private static readonly Regex CssLengthRegex = new Regex("^(?:0|(?:\\d+(?:\\.\\d+)?)(?:px|rem|em|%))$", RegexOptions.Compiled);

        public const string DEFAULT_PAGE = "~/Default.aspx";
        public const string PAGE_ID_PARAM = "pid";
        public const string CONTROL_ID_PARAM = "ctl";
        public const string MODULE_ID_PARAM = "mid";
        public const string THEMES_FOLDER = "App_Themes";
        public const string IMAGES_FOLDER = "Images";
        public const string ICONS_FOLDER = "Icons";
        public const string SKINS_FOLDER = "App_Skins";
        public const string CONTAINERS_FOLDER = "App_Containers";
        public const string CONTENT_PANE_NAME = "ContentPane";
        public const string LEFT_PANE_NAME = "LeftPane";
        public const string MODULE_TITLE_CONTROL_ID = "lblModuleTitle";
        public const string MODULE_ICON_CONTROL_ID = "imgModuleIcon";
        public const string DESKTOP_MODULES_FOLDER = "DesktopModules";

		protected string CultureCookieName
        {
            get { return PortalConfiguration.SiteSettings["CultureCookieName"]; }
        }

        private string CurrentPageID
        {
            get
            {
                string pid = Request[PAGE_ID_PARAM];
                if (pid == null)
                {
                    // get default page
                    pid = PortalConfiguration.SiteSettings["DefaultPage"];
                }
                return pid.ToLower(CultureInfo.InvariantCulture);
            }
        }

        private string ModuleControlID
        {
            get
            {
                string ctl = Request[CONTROL_ID_PARAM];
                if (ctl == null)
                {
                    ctl = "";
                }
                return ctl.ToLower(CultureInfo.InvariantCulture);
            }
        }

        private int ModuleID
        {
            get
            {
                string smid = Request[MODULE_ID_PARAM];
                if (smid == null)
                {
                    smid = "0";
                }
                return Int32.Parse(smid);
            }
        }

        public static string GetPageUrl(string pid)
        {
            return DefaultPage.DEFAULT_PAGE + "?" + DefaultPage.PAGE_ID_PARAM + "=" + pid;
        }

        public static bool IsAccessibleToUser(HttpContext context, IList roles)
        {
            foreach (string role in roles)
            {
                if (role == "?")
                    return true;

                if ((role == "*") || ((context.User != null) && context.User.IsInRole(role)))
                {
                    return true;
                }
            }
            return false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ApplyLanguageAndDirection();

            string sethtmlclassTheme = BuildThemeClassValue();
            if (!String.IsNullOrWhiteSpace(sethtmlclassTheme))
            {
                htmltheme.Attributes.Add("class", sethtmlclassTheme);
            }

            ApplyThemePaletteVariables();

        }

        private void ApplyLanguageAndDirection()
        {
            htmltheme.Attributes["lang"] = PortalUtils.CurrentUICulture.Name;

            if (!PortalUtils.IsRightToLeft)
            {
                return;
            }

            htmltheme.Attributes["dir"] = "rtl";

            // The theme links the LTR build of Bootstrap; swap in the matching RTL build.
            foreach (Control control in Page.Header.Controls)
            {
                HtmlLink link = control as HtmlLink;
                if (link != null && link.Href.EndsWith("/" + BOOTSTRAP_STYLESHEET, StringComparison.OrdinalIgnoreCase))
                {
                    link.Href = BOOTSTRAP_RTL_STYLESHEET;
                    break;
                }
            }
        }

        private void ApplyThemePaletteVariables()
        {
            bool isDarkThemeActive = IsDarkThemeActive();
            bool isLightThemeActive = IsLightThemeActive();

            if (isDarkThemeActive)
            {
                ApplyThemePaletteVariablesFromCookie(
                    THEME_PALETTE_DARK_COOKIE,
                    DarkPaletteCssVars,
                    LightPaletteCssVars,
                    (_, __) => true);
            }
            else if (isLightThemeActive)
            {
                ApplyThemePaletteVariablesFromCookie(
                    THEME_PALETTE_LIGHT_COOKIE,
                    LightPaletteCssVars,
                    LightPaletteCssVars,
                    (_, __) => true);
            }

            ApplyThemePaletteVariablesFromCookie(THEME_PALETTE_DARK_COOKIE, DarkPaletteCssVars, DarkPaletteCssVars, (_, __) => true);

            if (isDarkThemeActive)
            {
                ApplyThemePaletteVariablesFromCookie(
                    THEME_BUTTONS_DARK_COOKIE,
                    DarkButtonCssVars,
                    LightButtonCssVars,
                    IsButtonValueValid);
            }
            else if (isLightThemeActive)
            {
                ApplyThemePaletteVariablesFromCookie(
                    THEME_BUTTONS_LIGHT_COOKIE,
                    LightButtonCssVars,
                    LightButtonCssVars,
                    IsButtonValueValid);
            }

            ApplyThemePaletteVariablesFromCookie(THEME_BUTTONS_DARK_COOKIE, DarkButtonCssVars, DarkButtonCssVars, IsButtonValueValid);
        }

        private bool IsDarkThemeActive()
        {
            return IsThemeClassPresent("dark-theme");
        }

        private bool IsLightThemeActive()
        {
            return IsThemeClassPresent("light-theme");
        }

        private bool IsThemeClassPresent(string themeClass)
        {
            string themeClasses = BuildThemeClassValue();
            if (String.IsNullOrWhiteSpace(themeClasses))
                return false;

            return themeClasses
                .Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)
                .Any(token => token.Equals(themeClass, StringComparison.OrdinalIgnoreCase));
        }

        private static bool IsButtonValueValid(string cssVariable, string value)
        {
            if (cssVariable.EndsWith("-radius", StringComparison.OrdinalIgnoreCase))
            {
                return CssLengthRegex.IsMatch(value);
            }

            return PaletteHexColorRegex.IsMatch(value);
        }

        private void ApplyThemePaletteVariablesFromCookie(string cookieName, string[] sourceCssVariables, string[] targetCssVariables, Func<string, string, bool> validator, bool shouldApply = true)
        {
            if (!shouldApply)
                return;

            HttpCookie paletteCookie = Request.Cookies[cookieName];
            if (paletteCookie == null || String.IsNullOrWhiteSpace(paletteCookie.Value))
                return;

            string decodedValue = HttpUtility.UrlDecode(paletteCookie.Value) ?? String.Empty;
            string[] values = decodedValue.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            if (values.Length != sourceCssVariables.Length || targetCssVariables == null || targetCssVariables.Length != sourceCssVariables.Length)
                return;

            for (int i = 0; i < sourceCssVariables.Length; i++)
            {
                string normalizedValue = values[i].Trim();
                if (!validator(sourceCssVariables[i], normalizedValue))
                    return;

                values[i] = normalizedValue;
            }

            for (int i = 0; i < targetCssVariables.Length; i++)
            {
                htmltheme.Style[targetCssVariables[i]] = values[i];
            }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            Theme = PortalThemeProvider.Instance.GetTheme();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            // get page info
            string pid = CurrentPageID;
            if (PortalConfiguration.Site.Pages[pid] == null)
            {
                ShowError(skinPlaceHolder, String.Format("Page with ID '{0}' is not found", HttpUtility.HtmlEncode(pid)));
                return;
            }

            PortalPage page = PortalConfiguration.Site.Pages[pid];

            // check if page is accessible to user
            if (!IsAccessibleToUser(Context, page.Roles))
            {
                // redirect to login page
                string returnUrl = Request.RawUrl;
                Response.Redirect(DEFAULT_PAGE + "?" + PAGE_ID_PARAM + "=" +
                    PortalConfiguration.SiteSettings["LoginPage"] + "&ReturnUrl=" + Uri.EscapeDataString(returnUrl));
            }

            Title = String.Format("{0} - {1}",
                PortalConfiguration.SiteSettings["PortalName"],
                PageTitleProvider.Instance.ProcessPageTitle(GetLocalizedPageTitle(page.Name)));

            // load skin
            bool editMode = (ModuleControlID != "" && ModuleID > 0);

            string skinName = page.SkinSrc;
            if (!editMode)
            {
                // browse skin
                if (String.IsNullOrEmpty(skinName))
                {
                    // load portal skin
                    skinName = PortalConfiguration.SiteSettings["PortalSkin"];
                }
            }
            else
            {
                // edit skin
                if (!String.IsNullOrEmpty(page.AdminSkinSrc))
                    skinName = page.AdminSkinSrc;
                else
                    skinName = PortalConfiguration.SiteSettings["AdminSkin"];
            }

            // load skin control
            string skinPath = "~/" + SKINS_FOLDER + "/" + this.Theme + "/" + skinName;
            Control ctrlSkin = null;
            try
            {
                ctrlSkin = LoadControl(skinPath);
                skinPlaceHolder.Controls.Add(ctrlSkin);
            }
            catch (Exception ex)
            {
                ShowError(skinPlaceHolder, String.Format("Can't load {0} skin: {1}", skinPath, ex.ToString()));
                return;
            }

            // load page modules
            if (!editMode)
            {
                // browse mode
                foreach (string paneId in page.ContentPanes.Keys)
                {
                    // try to find content pane
                    Control ctrlPane = ctrlSkin.FindControl(paneId);
                    if (ctrlPane != null)
                    {
                        // insert modules
                        ContentPane pane = page.ContentPanes[paneId];
                        foreach (PageModule module in pane.Modules)
                        {
                            if (IsAccessibleToUser(Context, module.ViewRoles))
                            {
                                // add module
                                if (module.Settings.Contains("UseDefault"))
                                {
                                    string useDefault = Convert.ToString(module.Settings["UseDefault"]).ToLower(CultureInfo.InvariantCulture);
                                    AddModuleToContentPane(ctrlPane, module, useDefault, editMode);
                                }
                                else
                                    AddModuleToContentPane(ctrlPane, module, "", editMode);
                            }
                        }
                    }
                }
            }
            else
            {
                // edit mode
                // find ContentPane
                Control ctrlPane = ctrlSkin.FindControl(CONTENT_PANE_NAME);
                if (ctrlPane != null)
                {
                    // add "edit" module
                    if (PortalConfiguration.Site.Modules.ContainsKey(ModuleID))
                        AddModuleToContentPane(ctrlPane, PortalConfiguration.Site.Modules[ModuleID],
                            ModuleControlID, editMode);
                }
                // find LeftPane
                ctrlPane = ctrlSkin.FindControl(LEFT_PANE_NAME);
                if (ctrlPane != null && page.ContentPanes.ContainsKey(LEFT_PANE_NAME))
                {
                    ContentPane pane = page.ContentPanes[LEFT_PANE_NAME];
                    foreach (PageModule module in pane.Modules)
                    {
                        if (IsAccessibleToUser(Context, module.ViewRoles))
                        {
                            // add module
                            AddModuleToContentPane(ctrlPane, module, "", false);
                        }
                    }
                }
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Ensure the page's form action attribute is not empty
            if (Request.RawUrl.Equals("/") == false)
                return;
            // Assign default page to avoid ASP.NET 4 issue w/ Extensionless URL Module & Custom HTTP Modules
            Form.Action = Form.ResolveUrl(DEFAULT_PAGE);
        }

        private void AddModuleToContentPane(Control pane, PageModule module, string ctrlKey, bool editMode)
        {
            string defId = module.ModuleDefinitionID;
            if (!PortalConfiguration.ModuleDefinitions.ContainsKey(defId))
            {
                ShowError(pane, String.Format("Module definition '{0}' could not be found", defId));
                return;
            }

            ModuleDefinition definition = PortalConfiguration.ModuleDefinitions[defId];
            ModuleControl control = null;
            if (String.IsNullOrEmpty(ctrlKey))
                control = definition.DefaultControl;
            else
            {
                if (definition.Controls.ContainsKey(ctrlKey))
                    control = definition.Controls[ctrlKey];
            }

            if (control == null)
                return;

            // container
            string containerName = editMode ?
                PortalConfiguration.SiteSettings["AdminContainer"] : PortalConfiguration.SiteSettings["PortalContainer"];

            if (!editMode && !String.IsNullOrEmpty(module.ContainerSrc))
                containerName = module.ContainerSrc;

            if (editMode && !String.IsNullOrEmpty(module.AdminContainerSrc))
                containerName = module.AdminContainerSrc;

            // load container
            string containerPath = "~/" + CONTAINERS_FOLDER + "/" + this.Theme + "/" + containerName;
            Control ctrlContainer = null;
            try
            {
                ctrlContainer = LoadControl(containerPath);
            }
            catch (Exception ex)
            {
                ShowError(pane, String.Format("Container '{0}' could not be loaded: {1}", containerPath, ex.ToString()));
                return;
            }

            string title = module.Title;
            if (editMode || String.IsNullOrEmpty(title))
            {
                // get control title
                title = control.Title;
            }

            string iconFile = module.IconFile;
            if (editMode || String.IsNullOrEmpty(iconFile))
            {
                // get control icon
                iconFile = control.IconFile;
            }

            // set title
            Label lblModuleTitle = (Label)ctrlContainer.FindControl(MODULE_TITLE_CONTROL_ID);
            if (lblModuleTitle != null)
            {
                lblModuleTitle.Text = GetLocalizedModuleTitle(title);
            }

            // set icon
            System.Web.UI.WebControls.Image imgModuleIcon = (System.Web.UI.WebControls.Image)ctrlContainer.FindControl(MODULE_ICON_CONTROL_ID);
            if (imgModuleIcon != null)
            {
                if (String.IsNullOrEmpty(iconFile))
                {
                    imgModuleIcon.Visible = false;
                }
                else
                {
                    string iconPath = "~/" + THEMES_FOLDER + "/" + this.Theme + "/" + ICONS_FOLDER + "/" + iconFile;
                    imgModuleIcon.ImageUrl = iconPath;
                }
            }

            Control contentPane = ctrlContainer.FindControl(CONTENT_PANE_NAME);
            if (contentPane != null)
            {
                string controlName = control.Src;
                string controlPath = "~/" + DESKTOP_MODULES_FOLDER + "/" + controlName;
                if (!String.IsNullOrEmpty(controlName))
                {
                    PortalControlBase ctrlControl = null;
                    try
                    {
                        ctrlControl = (PortalControlBase)LoadControl(controlPath);
                        ctrlControl.Module = module;
                        ctrlControl.ContainerControl = ctrlContainer;
                        contentPane.Controls.Add(ctrlControl);
                    }
                    catch (Exception ex)
                    {
                        ShowError(contentPane, String.Format("Control '{0}' could not be loaded: {1}", controlPath, ex.ToString()));
                    }
                }
            }


            // add controls to the pane
            pane.Controls.Add(ctrlContainer);
        }

        protected override void InitializeCulture()
        {
            HttpCookie localeCrub = Request.Cookies[CultureCookieName];

            if (localeCrub != null)
            {
                string localeCode = localeCrub.Value;
                UICulture = localeCode;
                Culture = localeCode;

                System.Globalization.CultureInfo ci = System.Globalization.CultureInfo.CreateSpecificCulture(localeCode);

                if (ci != null)
                {
                    // Reset currency symbol to deal with the existing ISO currency symbol implementation
                    ci.NumberFormat.CurrencySymbol = String.Empty;
                    // Setting up culture
                    System.Threading.Thread.CurrentThread.CurrentCulture = ci;
                    System.Threading.Thread.CurrentThread.CurrentUICulture = ci;
                    requestCulture = ci;
                }
            }

            base.InitializeCulture();
        }

        protected override void Render(HtmlTextWriter writer)
        {
            // The page can render outside the async scope in which InitializeCulture ran,
            // so restore the request culture for content localized while rendering.
            if (requestCulture != null)
            {
                System.Threading.Thread.CurrentThread.CurrentCulture = requestCulture;
                System.Threading.Thread.CurrentThread.CurrentUICulture = requestCulture;
            }

            base.Render(writer);
        }

        private void ShowError(Control placeholder, string message)
        {
            Label lbl = new Label();
            lbl.Text =
                PortalAntiXSS.Encode("<div style=\"height:300px;overflow:auto;\">" + message.Replace("\n", "<br>") +
                                   "</div>");
            lbl.ForeColor = Color.Red;
            lbl.Font.Bold = true;
            lbl.Font.Size = FontUnit.Point(8);
            placeholder.Controls.Add(lbl);
        }

        public static string GetLocalizedModuleTitle(string moduleName)
        {
            string localizedString = GetLocalizedResourceString("Modules", String.Concat("ModuleTitle.", moduleName));
            return localizedString != null ? localizedString : moduleName;
        }

        public static string GetLocalizedPageTitle(string tabName)
        {
            string localizedString = GetLocalizedResourceString("Pages", String.Concat("PageTitle.", tabName));
            return localizedString != null ? localizedString : tabName;
        }

        public static string GetLocalizedPageName(string tabName)
        {
            return GetLocalizedResourceString("Pages", String.Concat("PageName.", tabName));
        }

        private static string GetLocalizedResourceString(string suffix, string key)
        {
            List<string> list1 = null;
            if (suffix == "Pages")
            {
                list1 = GetResourceFiles("Pages", "FCPLocaleAdapterPages");
            }
            else
            {
                list1 = GetResourceFiles("Modules", "FCPLocaleAdapterModules");
            }

            string text1 = null;
            foreach (string text2 in list1)
            {
                text1 = GetGlobalLocalizedString(text2, key);

                if (!String.IsNullOrEmpty(text1))
                {
                    return text1;
                }
            }
            return text1;
        }

        private static List<string> GetResourceFiles(string suffix, string cacheKey)
        {
            List<string> list = (List<string>)HttpContext.Current.Cache[cacheKey];
            if (list == null)
            {
                string resDir = HttpContext.Current.Server.MapPath("~/App_GlobalResources");

                if (Directory.Exists(resDir))
                {
                    FileInfo[] infoArray1 = new DirectoryInfo(resDir).GetFiles("*_" + suffix + ".ascx.resx");

                    list = new List<string>();
                    foreach (FileInfo info1 in infoArray1)
                    {
                        list.Add(info1.Name);
                    }
                }
                else // when app is precompiled there is no App_GlobalResources directory so use a file with the
                     // resource names instead. The file is created by the FuseCP.WebPortal.csproj when you execute
                     // its Deploy target
                {
                    var resNamesFile = HttpContext.Current.Server.MapPath("~/App_Data/App_GlobalResources.list");
                    list = File.ReadAllLines(resNamesFile)
                        .Where(file => file.EndsWith($"_{suffix}.ascx.resx"))
                        .ToList();
                }

                HttpContext.Current.Cache.Insert(cacheKey, list, new CacheDependency(resDir));
            }
            return list;
        }

        public static string GetGlobalLocalizedString(string fileName, string resourceKey)
        {
            string className = fileName.Replace(".resx", "");
            return (string)HttpContext.GetGlobalResourceObject(className, resourceKey);
        }

        public void Recreatehtmlclasses()
        {
            //clear any current classes
            htmltheme.Attributes.Remove("class");

            string sethtmlclassTheme = BuildThemeClassValue();
            if (!String.IsNullOrWhiteSpace(sethtmlclassTheme))
            {
                htmltheme.Attributes.Add("class", sethtmlclassTheme);
            }

            ApplyThemePaletteVariables();
        }

        private string BuildThemeClassValue()
        {
            string styleClass = String.Empty;
            HttpCookie styleCookie = Request.Cookies["UserThemeStyle"];
            if (styleCookie != null)
            {
                styleClass = (styleCookie.Value ?? String.Empty).Trim();
            }

            string modeClass = String.Empty;
            HttpCookie modeCookie = Request.Cookies[THEME_MODE_COOKIE];
            if (modeCookie != null)
            {
                string requestedMode = (modeCookie.Value ?? String.Empty).Trim().ToLowerInvariant();
                if (requestedMode == "dark-theme" || requestedMode == "light-theme")
                {
                    modeClass = requestedMode;
                }
            }

            if (String.IsNullOrWhiteSpace(styleClass))
            {
                return modeClass;
            }

            if (String.IsNullOrWhiteSpace(modeClass))
            {
                return styleClass;
            }

            string[] styleTokens = styleClass.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)
                .Where(t => !t.Equals("light-theme", StringComparison.OrdinalIgnoreCase)
                    && !t.Equals("dark-theme", StringComparison.OrdinalIgnoreCase))
                .ToArray();

            if (styleTokens.Length == 0)
            {
                return modeClass;
            }

            return String.Join(" ", styleTokens) + " " + modeClass;
        }
    }
}
