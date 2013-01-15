<%@ Page Title="sasdsa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="agent.aspx.cs" Inherits="BusReservation.Agent" %>
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
							<a href="#">My Sales Page</a> 
						</div>
					</div><!-- breadcrumb -->
					
					<div class="content">
						<div class="post">
                            <h1><asp:Label ID="result_title" runat="server" Text="Label">My Sales Page</asp:Label></h1>
                            <asp:GridView ID="TicketsGrid" runat="server"></asp:GridView>

                        </div>
				</div>
			</div>				
			
		</div>	
	</div>
</div>
<!-- pagemid -->	
	
<div class="clear"></div>

</asp:Content>