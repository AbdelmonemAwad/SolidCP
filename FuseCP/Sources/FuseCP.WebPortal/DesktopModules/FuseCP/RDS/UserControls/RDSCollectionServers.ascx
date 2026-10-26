<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RDSCollectionServers.ascx.cs" Inherits="FuseCP.Portal.RDS.UserControls.RDSCollectionServers" %>
<%@ Register Src="../../UserControls/PopupHeader.ascx" TagName="PopupHeader" TagPrefix="fcp" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="../../UserControls/CollapsiblePanel.ascx" %>

<asp:UpdatePanel ID="UsersUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
	<div class="FormButtonsBarClean">
		<asp:LinkButton id="btnDelete" CssClass="btn btn-danger" runat="server" OnClick="btnDelete_Click"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>&nbsp;
        <asp:LinkButton id="btnRefresh" CssClass="btn btn-warning" runat="server" OnClick="btnRefresh_Click" OnClientClick="ShowProgressDialog('Refreshing...'); return true;"> <i class="bi bi-arrow-clockwise">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnRefreshText"/> </asp:LinkButton>&nbsp;
        <asp:LinkButton id="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click"> <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddText"/> </asp:LinkButton>
	</div>
	<asp:GridView ID="gvServers" runat="server" meta:resourcekey="gvServers" AutoGenerateColumns="False"
		Width="600px" CssSelectorClass="NormalGridView"
		DataKeyNames="Id" OnRowCommand="gvServers_RowCommand">
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
			<asp:TemplateField meta:resourcekey="gvServerName" HeaderText="gvServerName">
				<ItemStyle Wrap="false">
				</ItemStyle>
				<ItemTemplate>
                    <asp:Literal ID="litFqdName" runat="server" Text='<%# Eval("FqdName") %>'></asp:Literal>
				</ItemTemplate>
			</asp:TemplateField>
            <asp:TemplateField meta:resourcekey="gvPopupStatus">
                <ItemStyle CssClass="text-start" />
                <ItemTemplate>
                    <asp:Literal ID="litStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Literal>
                    <asp:HiddenField ID="hdnRdsCollectionId" runat="server" Value='<%# Eval("RdsCollectionId") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="gvViewInfo">
                <ItemStyle CssClass="text-end"/>
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="ShowProgressDialog('Getting Server Info ...');return true;" CssClass="btn btn-primary" Visible='<%# Eval("Status") != null && Eval("Status").ToString().StartsWith("Online") %>' 
                        CommandName="ViewInfo" CommandArgument='<%# Eval("FqdName")%>' ID="lbViewInfo" runat="server" Text="View Info" meta:resourcekey="lbViewInfo"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="gvRestart">
                <ItemStyle CssClass="text-end"/>
                <ItemTemplate>
                    <asp:LinkButton ID="lbRestart" CommandName="Restart" CommandArgument='<%# Eval("FqdName")%>' CssClass="btn btn-warning" Visible='<%# Eval("Status") != null && Eval("Status").ToString().StartsWith("Online") %>'
                        runat="server" Text="Restart" OnClientClick="return confirm('Are you sure you want to restart selected server?')" meta:resourcekey="lbRestart"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="gvShutdown">
                <ItemStyle CssClass="text-end"/>
                <ItemTemplate>
                    <asp:LinkButton ID="lbShutdown" CommandName="ShutDown" CommandArgument='<%# Eval("FqdName")%>' CssClass="btn btn-danger" Visible='<%# Eval("Status") != null && Eval("Status").ToString().StartsWith("Online") %>'
                        runat="server" Text="Shut Down" OnClientClick="return confirm('Are you sure you want to shu down selected server?')" meta:resourcekey="lbShutdown"/>
                </ItemTemplate>
            </asp:TemplateField>
		</Columns>
	</asp:GridView>
    <br />

    <asp:Panel ID="ServerInfoPanel" runat="server" style="display:none">
        <div class="widget">
             <div class="widget-header clearfix">
                           <h3><i class="bi bi-server"></i>  <asp:Localize ID="Localize1" runat="server" meta:resourcekey="headerServerInfo"></asp:Localize></h3>
                </div>
                    <div class="widget-content Popup">
                <asp:UpdatePanel ID="serverInfoUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>
                        <div class="Popup-Scroll" style="height:auto">
                            <fcp:CollapsiblePanel id="secServerInfo" runat="server" TargetControlID="panelHardwareInfo" meta:resourcekey="secRdsApplicationEdit" Text=""/>                            
                            <asp:Panel runat="server" ID="panelHardwareInfo">
                                <table>
                                    <tr>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="locProcessor" runat="server" Text="Processor:"/>
                                        </td>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="litProcessor" runat="server"/>
                                        </td>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="locLoadPercentage" Text="Load Percentage:" runat="server"/>
                                        </td>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="litLoadPercentage" runat="server"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="locMemoryAllocated" runat="server" Text="Allocated Memory:"/>
                                        </td>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="litMemoryAllocated" runat="server"/>
                                        </td>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="locFreeMemory" Text="Free Memory:" runat="server"/>
                                        </td>
                                        <td class="FormLabel150" >
                                            <asp:Literal ID="litFreeMemory" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <fcp:CollapsiblePanel id="secRdsApplicationEdit" runat="server" TargetControlID="panelDiskDrives" meta:resourcekey="secRdsApplicationEdit" Text="Disk Drives"/>
                            <asp:Panel runat="server" ID="panelDiskDrives">
                                <table>
                                    <asp:Repeater ID="rpServerDrives" runat="server" EnableViewState="false">
                                        <ItemTemplate>
                                            <tr>
                                                <td class="FormLabel150" >
                                                    <asp:Localize ID="locDeviceID" runat="server" meta:resourcekey="locDeviceID" />
                                                </td>
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="litDeviceId" runat="server" Text='<%# Eval("DeviceId") %>'/>
                                                </td>                                                                                                                                   
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="locVolumeName" Text="Volume Name:" runat="server"/>
                                                </td>
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="litVolumeName" Text='<%# Eval("VolumeName") %>' runat="server"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="locSize" Text="Size:" runat="server"/>
                                                </td>
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="litSize" Text='<%# Eval("SizeMb") + " MB" %>' runat="server"/>
                                                </td>                                                                                                                                    
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="locFreeSpace" Text="Free Space:" runat="server"/>
                                                </td>
                                                <td class="FormLabel150" >
                                                    <asp:Literal ID="litFreeSpace" Text='<%# Eval("FreeSpaceMb") + " MB" %>' runat="server"/>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </table>
                            </asp:Panel>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
			<br /><br />             
                <asp:LinkButton id="btnCancelServerInfo" CssClass="btn btn-warning" runat="server" CausesValidation="false"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnServerInfoCancelText"/> </asp:LinkButton>
            </div>
        </div>
    </asp:Panel>
        
        <asp:Panel ID="AddServersPanel" runat="server" style="display:none">
	<div class="widget">
             <div class="widget-header clearfix">
                           <h3><i class="bi bi-person"></i>  <asp:Localize ID="headerAddServers" runat="server" meta:resourcekey="headerAddServers"></asp:Localize><h3 />
			</div>
                    <div class="widget-content Popup">
<asp:UpdatePanel ID="AddServersUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>
	            
                <div class="FormButtonsBarClean">
                    <div class="FormButtonsBarCleanRight">
                        <asp:Panel ID="SearchPanel" runat="server" DefaultButton="cmdSearch">
                            <div class="input-group">
                            <asp:TextBox ID="txtSearchValue" runat="server" CssClass="form-control"></asp:TextBox>
                                <div class="d-flex">
                                <asp:LinkButton ID="cmdSearch" runat="server" CausesValidation="false" OnClick="cmdSearch_Click" CssClass="btn btn-primary align-middle" >
                                    <i class="bi bi-search" aria-hidden="true"></i>
                                </asp:LinkButton>      
                                    </div>
                                </div>
                        </asp:Panel>
                    </div>
                </div>
                <div class="Popup-Scroll">
					<asp:GridView ID="gvPopupServers" runat="server" meta:resourcekey="gvPopupServers" AutoGenerateColumns="False"
					 CssSelectorClass="NormalGridView"
						DataKeyNames="Id">
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
							<asp:TemplateField meta:resourcekey="gvPopupServerName">
								<ItemStyle/>
								<ItemTemplate>
									<asp:Literal ID="litName" runat="server" Text='<%# Eval("FqdName") %>'></asp:Literal>
								</ItemTemplate>
							</asp:TemplateField>                            
						</Columns>
					</asp:GridView>
				</div>
	</ContentTemplate>
</asp:UpdatePanel>
                        </div>
					<div class="popup-buttons text-end">
			<asp:LinkButton id="btnCancelAdd" CssClass="btn btn-warning" runat="server" CausesValidation="False"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancelText"/> </asp:LinkButton>&nbsp;
            <asp:LinkButton id="btnAddSelected" CssClass="btn btn-success" runat="server" OnClick="btnAddSelected_Click"> <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAddSelectedText"/> </asp:LinkButton>
		</div>
        </div>
</asp:Panel>

        <asp:Button ID="btnViewInfoFake" runat="server" style="display:none" />
        <ajaxToolkit:ModalPopupExtender ID="ViewInfoModal" runat="server" TargetControlID="btnViewInfoFake" PopupControlID="ServerInfoPanel" 
            BackgroundCssClass="modalBackground" DropShadow="false" CancelControlID="btnCancelServerInfo"/>
        
        <asp:Button ID="btnAddServersFake" runat="server" style="display:none" />
        <ajaxToolkit:ModalPopupExtender ID="AddServersModal" runat="server" TargetControlID="btnAddServersFake" PopupControlID="AddServersPanel"
            BackgroundCssClass="modalBackground" DropShadow="false" CancelControlID="btnCancelAdd"/>
	</ContentTemplate>
</asp:UpdatePanel>

