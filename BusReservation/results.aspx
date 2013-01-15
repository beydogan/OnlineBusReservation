<%@ Page Title="sasdsa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="results.aspx.cs" Inherits="BusReservation.Results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- pagemid -->
	<div class="pagemid rightsidebar">	
		<div class="topshadow">
			<div class="inner">
		
				<div id="mainfull">
				
					<!-- breadcrumb -->
					<div id="breadcrumbs">
						<img src="images/home-icon.png" width="16" height="16" class="bread-icon" />  	
						<div class="breadcrumbs">
							<a href="default.aspx">Home</a> &#187;
							<a href="#">Results</a>
						</div>
					</div><!-- breadcrumb -->
					 <asp:Panel ID="errorPanel" runat="server" CssClass="alert alert-error" Visible="false">
                    </asp:Panel>
					<div class="content">
						<div class="post">
                            <h1><asp:Label ID="result_title" runat="server" Text="Label"></asp:Label></h1>
                            <asp:GridView ID="RouteGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CssClass="table table-striped" EnableTheming="False"                                
                                ShowFooter="True"
                                OnRowCommand="RouteGrid_RowCommand"
                                DataKeyNames="route_id">
                                <Columns>                                    
                                    <asp:TemplateField HeaderText="Departure Date" HeaderStyle-HorizontalAlign="Left">
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDate" runat="server" Text='<%# Convert.ToDateTime(Eval("departure_time")).ToString("dd/MM/yyyy H:mm") %>'></asp:Label>
                                        </ItemTemplate>

                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fare" HeaderStyle-HorizontalAlign="Left">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtFareEdit" runat="server" Text='<%# Bind("fare") %>' Width="50px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblFare" runat="server" Text='<%# Bind("fare") %>'></asp:Label>
                                        </ItemTemplate>

                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False" HeaderStyle-HorizontalAlign="Left">
                                        <EditItemTemplate>
                                            <asp:LinkButton class="btn btn-flat" ID="btnUpdate" runat="server" CausesValidation="True" CommandName="Update"><span class="awe-ok"></span></asp:LinkButton>
                                            <asp:LinkButton class="btn btn-flat" ID="btnCancel" runat="server" CausesValidation="True" CommandName="Cancel"><span class="awe-remove"></span></asp:LinkButton>

                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:LinkButton class="btn btn-flat" ID="btnInsert" runat="server" CausesValidation="True" CommandName="New"><span class="awe-plus"></span></asp:LinkButton>
                                        </FooterTemplate>
                                        <ItemTemplate>
                                            <asp:LinkButton class="btn btn-flat" ID="btnMake" runat="server" CausesValidation="True" CommandName="Reservation"  CommandArgument='<%# Bind("route_id") %>'><span class="awe-edit">Make Reservation</span></asp:LinkButton>
                                        </ItemTemplate>

                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    </asp:TemplateField>

                                </Columns>

                                <RowStyle BorderWidth="0px" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="BusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:bus_reservationConnectionString %>" SelectCommand="SELECT [bus_id], [license_plate] FROM [Bus]"></asp:SqlDataSource>
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bus_reservationConnectionString %>" SelectCommand="SELECT * FROM [Cities]"></asp:SqlDataSource>
                        </div>

				</div>
			</div>				
			
		</div>	
	</div>
</div>
<!-- pagemid -->	
	
<div class="clear"></div>

</asp:Content>