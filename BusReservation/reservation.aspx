<%@ Page Title="sasdsa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="reservation.aspx.cs" Inherits="BusReservation.Reservation" %>
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
							<a href="#">Reservation</a>
						</div>
					</div><!-- breadcrumb -->
					
					<div class="content">
						<div class="post">
                            <asp:Panel ID="errorPanel" runat="server" CssClass="alert alert-error" Visible="false">
                    </asp:Panel>

                            <h1><asp:Label ID="result_title" runat="server" Text="Select Seat"></asp:Label></h1>
                            <asp:RadioButtonList ID="seat_list1" runat="server" Width="400px" style=" float: left;" RepeatColumns="4" RepeatDirection="Horizontal">
                            </asp:RadioButtonList>
                            <asp:Panel ID="Panel1" runat="server" Width="400px" style="margin-left: 10px; float: left; border: 1px solid #E7E7E7">
                                <div id="contactform" class="sysform" style="margin: 0 auto">
                                    <h4>Passenger Information</h4>
                                    <div id="note" runat="server"></div>
                                    <p>
                                        <label>First Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><asp:TextBox ID="firstname" runat="server" CssClass="input_small txt"></asp:TextBox></p>
                                    <p>
                                        <label>Last Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><asp:TextBox ID="lastname" runat="server" CssClass="input_small txt"></asp:TextBox></p>
                                    <p>
                                        <label>Phone Number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><asp:TextBox ID="phonenumber" runat="server" CssClass="input_small txt"></asp:TextBox></p>
                                    <p>
                                        <label>Birth Date:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><asp:TextBox ID="birthdate" runat="server" CssClass="input_small txt datepicker"></asp:TextBox></p>
                                    <p>
                                        <label>E-Mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><asp:TextBox ID="email" runat="server" CssClass="input_small txt"></asp:TextBox></p>
                                    <p>
                                        <label>Gender:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><asp:RadioButtonList ID="gender" runat="server" EnableTheming="False" RepeatColumns="2" RepeatLayout="Flow">
                                            <asp:ListItem Value="0">Male</asp:ListItem>
                                            <asp:ListItem Value="1">Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </p>
                                    
                                </div>

                            </asp:Panel>
                            <div style="clear:both"></div>
                                <asp:LinkButton ID="SearchButton" runat="server" CssClass="center button large full" OnClick="ProcessReservation"><span>Make Reservation</span></asp:LinkButton>

                            <asp:HiddenField ID="selectedSeatNumber" runat="server" />
                            <asp:HiddenField ID="routeId" runat="server" />

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