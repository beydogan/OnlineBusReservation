<%@ Page Language="C#" AutoEventWireup="true" 
CodeBehind="Default.aspx.cs" Inherits="BusReservation._Default" 
MasterPageFile="~/Site1.Master"%>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
  <!-- pagemid -->
	<div class="pagemid rightsidebar">	
		<div class="topshadow">
			<div class="inner">
		
				<div id="mainfull">
				
					<!-- breadcrumb -->
					<div id="breadcrumbs">
						<img src="images/home-icon.png" width="16" height="16" class="bread-icon" />  	
						<div class="breadcrumbs">
							<a href="default.aspx">Home</a>
						</div>
					</div><!-- breadcrumb -->
					
					<div class="content">
						<div class="post">
                        <p>
                            Since our establishment, we laid the ground for safe, comfortable and modern passenger transportation, with our exclusive service at international standards and the countless innovative practices we have introduced in the sector. We are proud to serve our customers with 230 ticket sales locations throughout Turkey, 2,000 employees and our state-of-the-art fleet of 350 buses with personal TV, internet connection and freedom to use satellite and mobile phones. We carry approximately 2.5 million passengers annually to 692 locations, variable by season, in Marmara, Aegean, Mediterranean, Black Sea and Central Anatolian regions.
                        </p>
                            <h3>Tour Services</h3>
                            <p>
Varan Tour Services offers special transport services for domestic and international events such as dealer meetings, seminars, conferences, tours, congresses, etc. We have provided transport services for more than 2,000 events of nearly 200 companies, with the Varan comfort and quality.
<br />
Thanks to our Setra buses with personal TV, internet connection and freedom to use satellite and mobile phones, and the service you will receive from our experienced and cheerful staff, you will enjoy the exclusive Varan experience and comfort, and always remember our unique contribution to your special journey.
<br />


TOUR SERVICES DEPARTMENT
<br />

Telephone: 0212 692 15 00 / Ext. 2678 or 2777
<br />

Fax: 0212 693 33 04
<br />

E-mail: turhizmetleri@varan.com.tr
                            </p>
                        </div>
				</div>
			</div>				
			
		</div>	
	</div>
</div>
<!-- pagemid -->	</asp:Content>


<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="SliderPanel">
     <!--featured slider--> 
		        <div id="featured_slider">
			        <div class="inner">
                        <div id="slider">
				            <a href=""><img src="images/slide/1.jpg" alt="" height="300" ></a>
				            <a href=""><img src="images/slide/2.jpg" alt="" height="300" /></a>
				            <a href=""><img src="images/slide/3.jpg" alt="" height="300"/></a>
				        </div>
				        <!-- Start: Highlight-->
				        <div class="header_highlight">
                            <asp:Panel ID="errorPanel" runat="server" CssClass="alert alert-warning" Visible="false" style="margin-top: -10px">
                            </asp:Panel>
                            <div class="fancybox">
                                <h4 class="fancytitle" style="background-color: #3b8ed4; color: white">Reservation</h4>
                                <div class="boxcontent">
                                    From:<asp:DropDownList ID="ddlFromCity" runat="server" DataSourceID="CityDataSource" DataTextField="city_name" DataValueField="city_id"></asp:DropDownList>
                                    To:<asp:DropDownList ID="ddlToCity" runat="server" DataSourceID="CityDataSource" DataTextField="city_name" DataValueField="city_id"></asp:DropDownList><br />
                                    <br />
                                    Departure Date:<asp:TextBox ID="departureDate" class="datepicker" runat="server"></asp:TextBox><br />
                                    <p class="center">
                                        <asp:LinkButton ID="SearchButton" runat="server" CssClass="center button large full" OnClick="SearchButton_Click"><span>Search</span></asp:LinkButton>
                                    </p>
                                </div>
                            </div>                        
				        </div><!-- End: Highlight-->
			        </div>
		        </div>
		        <!--featured slider--> 
   		<div class="clear"></div>



    <asp:SqlDataSource ID="CityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:bus_reservationConnectionString %>" SelectCommand="SELECT [city_id], [city_name] FROM [Cities]"></asp:SqlDataSource>
</asp:Content>