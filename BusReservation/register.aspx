<%@ Page Title="sasdsa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="BusReservation.WebForm2" %>
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
							<a href="index.html">Home</a> &#187;
							<a href="#">Pages</a> &#187;    
							<a href="typography.html">Contact</a>
						</div>
					</div><!-- breadcrumb -->
					
					<div class="content">
						<div class="post">
                            <h3>Register</h3>
                            <div id="contactform" class="sysform" style="margin: 0 auto">
                                <div id="note" runat="server"></div>
                                    <p><label>Username:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><asp:TextBox ID="username" runat="server" CssClass="input_small txt"></asp:TextBox></p>
                                    <p><label>E-Mail:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><asp:TextBox ID="email" runat="server" CssClass="input_small txt"></asp:TextBox></p>
                                    <p><label>Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><asp:TextBox ID="password" runat="server" CssClass="input_small txt" TextMode="Password"></asp:TextBox></p>
                                    <p><label>Confirm Password:&nbsp;&nbsp;</label><asp:TextBox ID="password_confirm" runat="server" CssClass="input_small txt" TextMode="Password"></asp:TextBox></p>
                                    
                                     <asp:Button ID="Button1" runat="server" Text="Register" 
                                        onclick="Register_Click" CssClass="button small" />
                            </div> 
                        </div>

				</div>
			</div>				
			
		</div>	
	</div>
</div>
<!-- pagemid -->	
	
<div class="clear"></div>

</asp:Content>