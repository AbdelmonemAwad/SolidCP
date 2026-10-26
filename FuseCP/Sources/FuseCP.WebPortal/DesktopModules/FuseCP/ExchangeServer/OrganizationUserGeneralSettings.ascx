<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OrganizationUserGeneralSettings.ascx.cs" Inherits="FuseCP.Portal.HostedSolution.UserGeneralSettings" %>
<%@ Register Src="UserControls/UserSelector.ascx" TagName="UserSelector" TagPrefix="fcp" %>
<%@ Register Src="UserControls/CountrySelector.ascx" TagName="CountrySelector" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/PasswordControl.ascx" TagName="PasswordControl" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/CollapsiblePanel.ascx" TagName="CollapsiblePanel" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport" TagPrefix="fcp" %>
<%@ Register Src="UserControls/EmailAddress.ascx" TagName="EmailAddress" TagPrefix="fcp" %>
<%@ Register Src="../UserControls/SendToControl.ascx" TagName="SendToControl" TagPrefix="fcp" %>
<%@ Register Src="UserControls/UserTabs.ascx" TagName="UserTabs" TagPrefix="fcp" %>
<%@ Register Src="UserControls/MailboxTabs.ascx" TagName="MailboxTabs" TagPrefix="fcp" %>

<%@ Register Src="../UserControls/ItemButtonPanel.ascx" TagName="ItemButtonPanel" TagPrefix="fcp" %>


<fcp:EnableAsyncTasksSupport ID="asyncTasks" runat="server" />

<div class="card-header">
    <h3 class="card-title">
        <asp:Image ID="Image1" SkinID="OrganizationUser48" runat="server" />
        <asp:Localize ID="locTitle" runat="server" meta:resourcekey="locTitle" Text="Edit User"></asp:Localize>
        -
					<asp:Literal ID="litDisplayName" runat="server" Text="John Smith" />
        <asp:Image ID="imgVipUser" SkinID="VipUser16" runat="server" ToolTip="VIP user" Visible="false" />
        <asp:Label ID="litServiceLevel" runat="server" CssClass="float-end pe-2" Visible="false"></asp:Label>
    </h3>
</div>
<div class="card-body form-horizontal fcp-modern-page">
    <fcp:UserTabs ID="UserTabsId" runat="server" SelectedTab="edit_user" />
    <fcp:MailboxTabs ID="MailboxTabsId" runat="server" SelectedTab="edit_user" />
    <div class="card tab-content">
        <fcp:SimpleMessageBox ID="messageBox" runat="server" />
        <div class="row">
        <div class="col-sm-9">
            <h3><i class="bi bi-person"></i> <asp:Localize ID="Generalinfo" runat="server" meta:resourcekey="Generalinfo" Text="General Information"></asp:Localize></h3>
             <div class="row mb-3 fcp-user-header-row">
								<div class="col-sm-2">
                                    <asp:Label runat="server" ID="lblUserPrincipalName" Text="Login Name:" CssClass="form-label" AssociatedControlID="ddlEmailAddresses">
                                    </asp:Label>
									</div>
                                    <div class="col-sm-7">
                                            <fcp:EmailAddress ID="upn" runat="server" ValidationGroup="CreateMailbox"></fcp:EmailAddress>
                                <asp:DropDownList ID="ddlEmailAddresses" runat="server" CssClass="form-control"></asp:DropDownList>
                                    </div>
                                        <asp:LinkButton ID="btnSetUserPrincipalName" CssClass="col-sm-3 btn btn-primary" runat="server" OnClick="btnSetUserPrincipalName_Click"><i class="bi bi-person">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSetUserPrincipalNameText" />
                                </asp:LinkButton>
                 </div>
       <div class="row mb-3 fcp-user-display-row">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtDisplayName">
                                        <asp:Localize ID="locDisplayName" runat="server" meta:resourcekey="locDisplayName" Text="Display Name:"/>
                                    </asp:Label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtDisplayName" runat="server" CssClass="form-control" MaxLength="64"></asp:TextBox>
                                            <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                                <asp:RequiredFieldValidator ID="valRequireDisplayName" runat="server" meta:resourcekey="valRequireDisplayName" ControlToValidate="txtDisplayName"
                                    ErrorMessage="Enter Display Name" ValidationGroup="EditMailbox" Display="Dynamic" Text="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="valDisplayName" runat="server" ErrorMessage="Enter valid name" ControlToValidate="txtDisplayName" meta:resourcekey="valRequireCorrectName" 
                                                ValidationExpression="^[^'&quot;]+$" SetFocusOnError="True" ValidationGroup="EditMailbox" Display="Dynamic" Text="*"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
       </div>
            <div class="row">
                <div class="col-sm-10 offset-sm-2">
                    <br />
        <fcp:SendToControl ID="sendToControl" runat="server" ValidationGroup="CreateMailbox" ControlToHide="PasswordBlock"></fcp:SendToControl>
                </div>
                </div>
                <div id="PasswordBlock" runat="server" style="position:relative">
                    <fcp:PasswordControl ID="password" runat="server" ValidationGroup="ValidatePassword" AllowGeneratePassword="true"></fcp:PasswordControl>
                    <div class="fcp-org-user-password-action"><asp:LinkButton ID="btnSetUserPassword" CssClass="btn btn-primary btn-sm" runat="server" OnClick="btnSetUserPassword_Click" ValidationGroup="ValidatePassword"><i class="bi bi-key">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSetUserPasswordText" />
                                </asp:LinkButton></div>
                </div>
     
                    <fieldset>
                     <div class="row mb-3 fcp-user-toggle-row">
                         <div class="col-sm-10 offset-sm-2">
                             <div class="fcp-user-toggle-list">
                                <asp:CheckBox ID="chkUserMustChangePassword" runat="server" meta:resourcekey="chkUserMustChangePassword" Text="User must change password at next login" />
                                <asp:CheckBox ID="chkDisable" runat="server" meta:resourcekey="chkDisable" Text="Disable User" />
                                <asp:CheckBox ID="chkInherit" runat="server" meta:resourcekey="chkInherit" Text="Services inherit Login Name" Checked="true" />
                                <asp:CheckBox ID="chkLocked" runat="server" meta:resourcekey="chkLocked" Text="Lock User" />
                             </div>
                         </div>
                    </div>
                    </fieldset>
                    <fieldset>
                  
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtFirstName">
                                        <asp:Localize ID="locName" runat="server" meta:resourcekey="locName" Text="Name:" />
                                    </asp:Label>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="First Name" MaxLength="64"></asp:TextBox>
                                            <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                                        </div>
                                    </div>
                                    <div class="col-sm-2">
                                            <asp:TextBox ID="txtInitials" runat="server" MaxLength="6" CssClass="form-control" onKeyUp="buildDisplayName();" placeholder="Initials"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" onKeyUp="buildDisplayName();" placeholder="Last Name" MaxLength="64"></asp:TextBox>
                                            <span class="input-group-text" runat="server" title="<%$ Resources:FuseCP_SharedResources.ascx, Text.Required %>"><i class="bi bi-asterisk" aria-hidden="true"></i></span>
                                        </div>
                                    </div>
                                </div>
                     
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtSubscriberNumber">
                                        <asp:Localize ID="locSubscriberNumber" runat="server" meta:resourcekey="locSubscriberNumber" Text="Account Number:" />
                                    </asp:Label>
                                    <div class="col-sm-10">
                                            <asp:TextBox ID="txtSubscriberNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                         
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtExternalEmailAddress">
                                        <asp:Localize ID="locExternalEmailAddress" runat="server" meta:resourcekey="locExternalEmailAddress" Text="E-mail Address:" />
                                    </asp:Label>
                                    <div class="col-sm-10">
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-envelope" aria-hidden="true"></i></span>
                                            <asp:TextBox ID="txtExternalEmailAddress" runat="server" CssClass="form-control" />
                                        </div>
                                    </div>
                                </div>
                 
                                <div class="row mb-3">
                                    <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtNotes">
                                        <asp:Localize ID="locNotes" runat="server" meta:resourcekey="locNotes" Text="Notes:" />
                                    </asp:Label>
                                    <div class="col-sm-10">
                                            <asp:TextBox ID="txtNotes" runat="server" Rows="4" TextMode="MultiLine" CssClass="form-control" />
                                    </div>
                                </div>
                 
                    </fieldset>
    </div>
        <div class="col-sm-3">
                    <asp:Panel ID="pnlThumbnailphoto" runat="server" HorizontalAlign="Center">
                            <h3><i class="bi bi-camera"></i> <asp:Localize ID="locThumbnailphoto" runat="server" meta:resourcekey="locThumbnailphoto" Text="Thumbnail photo:"></asp:Localize></h3>
                        <div id="divUpThumbnailphoto" style="display: none">
                            <asp:FileUpload ID="upThumbnailphoto" ClientIDMode="Static" runat="server" CssClass="fcp-w-190"
                                onchange="__doPostBack('<%= btnLoadThumbnailphoto.ClientID %>', '')" />
                            <br />
                            <br />
                        </div>
                        <asp:Image ID="imgThumbnailphoto" runat="server" />
                        <br />
                        <asp:Button ID="btnLoadThumbnailphoto" runat="server" meta:resourcekey="btnLoadThumbnailphoto"
                            CssClass="btn btn-primary" Text="Load"
                            OnClientClick="$('#upThumbnailphoto').click(); return false;" />
                        <asp:Button ID="btnClearThumbnailphoto" runat="server" meta:resourcekey="btnClearThumbnailphoto"
                            CssClass="btn btn-danger" Text="Clear"
                            OnClick="btnClearThumbnailphoto_Click" />

                        <!--[if lte IE 9]>
                                    <script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/organization-user-general-settings-ie9.js"></script>
                                    <![endif]-->
                    </asp:Panel>
            </div>
            </div>
        <div class="row fcp-org-user-sections">
            <div class="accordion" id="accordion">
                <div class="card">
                    <div class="card-header card-header-link">
                        <a data-bs-toggle="collapse"  data-bs-parent="#accordion" href="#secServiceLevels2" aria-expanded="false" class="collapsed">
                            <asp:Localize runat="server" meta:resourcekey="secServiceLevels" Text="Service Level Information" />
							<span class='bi bi-plus-lg float-end' aria-hidden='true'> </span>
                        </a>
                    </div>
                    <div id="secServiceLevels2" class="accordion-collapse collapse" aria-expanded="false" style="height: 0px">
					<div id="secServiceLevels" TargetControlID="ServiceLevels" runat="server">
                        <div class="card-body">
                            <fieldset>
                                
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtFirstName">
                                                <asp:Localize ID="locServiceLevel" runat="server" meta:resourcekey="locServiceLevel" Text="Service Level:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                    <asp:DropDownList ID="ddlServiceLevels" DataValueField="LevelId" CssClass="form-control" DataTextField="LevelName" runat="server"></asp:DropDownList>
                                            </div>
                                        </div>
                               
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtFirstName">
                                                <asp:Localize ID="locVIPUser" runat="server" meta:resourcekey="locVIPUser" Text="VIP:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:CheckBox ID="chkVIP" runat="server" />
                                            </div>
                                        </div>
                        
                            </fieldset>
                        </div>
						</div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header card-header-link">
                        <a data-bs-toggle="collapse" data-bs-parent="#accordion" href="#secCompanyInfo" aria-expanded="false" class="collapsed">
                            <asp:Localize runat="server" meta:resourcekey="secCompanyInfo" Text="Company Information" /><span class='bi bi-plus-lg float-end' aria-hidden='true'> </span>
                        </a>
                    </div>
                    <div id="secCompanyInfo" class="accordion-collapse collapse" aria-expanded="false" style="height: 0px">
                        <div class="card-body">
                            <fieldset>
                              
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locJobTitle" runat="server" meta:resourcekey="locJobTitle" Text="Job Title:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                               
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locCompany" runat="server" meta:resourcekey="locCompany" Text="Company:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locDepartment" runat="server" meta:resourcekey="locDepartment" Text="Department:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                
                               
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locOffice" runat="server" meta:resourcekey="locOffice" Text="Office:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtOffice" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                           
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locManager" runat="server" meta:resourcekey="locManager" Text="Manager:" />
                                            </asp:Label>
                                            <div class="col-sm-10 fcp-manager-selector-wrap">
                                                <fcp:UserSelector ID="manager" IncludeMailboxes="true" runat="server" />
                                            </div>
                                        </div>
                         
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header card-header-link">
                        <a data-bs-toggle="collapse" data-bs-parent="#accordion" href="#secContactInfo2" aria-expanded="false" class="collapsed">
                            <asp:Localize runat="server" meta:resourcekey="secContactInfo" Text="Contact Information" /><span class='bi bi-plus-lg float-end' aria-hidden='true'> </span>
                        </a>
                    </div>
                    <div id="secContactInfo2" class="accordion-collapse collapse" aria-expanded="false" style="height: 0px">
                        <div class="card-body">
                            <fieldset>
                           
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locBusinessPhone" runat="server" meta:resourcekey="locBusinessPhone" Text="Business Phone:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtBusinessPhone" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                             
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locFax" runat="server" meta:resourcekey="locFax" Text="Fax:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtFax" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                             
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locHomePhone" runat="server" meta:resourcekey="locHomePhone" Text="Home Phone:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtHomePhone" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                 
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locMobilePhone" runat="server" meta:resourcekey="locMobilePhone" Text="Mobile Phone:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtMobilePhone" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtPager">
                                                <asp:Localize ID="locPager" runat="server" meta:resourcekey="locPager" Text="Pager:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtPager" runat="server" CssClass="form-control" />
                                            </div>
                                        </div>
                                 
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locWebPage" runat="server" meta:resourcekey="locWebPage" Text="Web Page:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtWebPage" runat="server" CssClass="form-control" />
                                            </div>
                                        </div>
                              
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header card-header-link">
                        <a data-bs-toggle="collapse" data-bs-parent="#accordion" href="#secAddressInfo" aria-expanded="false" class="collapsed">
                            <asp:Localize runat="server" meta:ResourceKey="secAddressInfo" Text="Address" /><span class='bi bi-plus-lg float-end' aria-hidden='true'> </span>
                        </a>
                    </div>
                    <div id="secAddressInfo" class="accordion-collapse collapse" aria-expanded="false" style="height: 0px">
                        <div class="card-body">
                            <fieldset>
                             
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locAddress" runat="server" meta:resourcekey="locAddress" Text="Street Address:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Rows="2" TextMode="MultiLine"></asp:TextBox>
                                            </div>
                                        </div>
                                  
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtCity">
                                                <asp:Localize ID="locCity" runat="server" meta:resourcekey="locCity" Text="City:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                  
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtState">
                                                <asp:Localize ID="locState" runat="server" meta:resourcekey="locState" Text="State/Province:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                 
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtZip">
                                                <asp:Localize ID="locZip" runat="server" meta:resourcekey="locZip" Text="Zip/Postal Code:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                  
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtPager">
                                                <asp:Localize ID="locCountry" runat="server" meta:resourcekey="locCountry" Text="Country/Region:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <fcp:CountrySelector ID="country" runat="server"></fcp:CountrySelector>
                                            </div>
                                        </div>
                                    
                            </fieldset>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header card-header-link">
                        <a data-bs-toggle="collapse" data-bs-parent="#accordion" href="#secAdvanced" aria-expanded="false" class="collapsed">
                            <asp:Localize runat="server" meta:ResourceKey="secAdvanced" Text="Advanced" /><span class='bi bi-plus-lg float-end' aria-hidden='true'> </span>
                        </a>
                    </div>
                    <div id="secAdvanced" class="accordion-collapse collapse" aria-expanded="false" style="height: 0px">
                        <div class="card-body">
                            <fieldset>
                               
                                        <div class="row mb-3">
                                            <asp:Label runat="server" CssClass="form-label col-sm-2" AssociatedControlID="txtJobTitle">
                                                <asp:Localize ID="locUserDomainName" runat="server" meta:resourcekey="locUserDomainName" Text="User Domain Name:" />
                                            </asp:Label>
                                            <div class="col-sm-10">
                                                <asp:Label CssClass="form-control" runat="server" ID="lblUserDomainName" />
                                            </div>
                                        </div>
                             
                            </fieldset>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
<div class="card-footer text-end">
    <fcp:ItemButtonPanel ID="buttonPanel" runat="server" ValidationGroup="EditMailbox"
        OnSaveClick="btnSave_Click" OnSaveExitClick="btnSaveExit_Click" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="EditMailbox" />
</div>
