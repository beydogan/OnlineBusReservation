<%@ Page Title="sasdsa" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="BusReservation.Contact" %>
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
							<a href="#">Contact</a> 
						</div>
					</div><!-- breadcrumb -->
					
					<div class="content">
						<div class="post">
                        <h3>Contact Us</h3>
							<div id="contactform" class="sysform">


								 <!--begin:notice message block-->
								 <div id="note"></div>
								 <!--begin:notice message block-->
								 <br />
					
								 <form id="ajax-contact-form" method="post" action="javascript:alert('success!');">
								   
									<p><input class="required input_small txt" type="text" name="name" value="" /><label>Name</label></p>
									
									<p><input class="required input_small txt" type="text" name="email" value="" /><label>E-Mail</label></p>
									
									<p><input class="required input_small txt" type="text" name="phone" value="" /><label>Phone Number</label></p>
									
									<p><input class="required input_small txt" type="text" name="subject" value="" /><label>Subject</label>
									<!--  <input class="required inpt" type="text" name="subject" value="" /> -->
									</p>
						
									<p><textarea class="textbox input_medium" name="message" rows="6" cols="30"></textarea><label>Comments</label></p>
									
									<p><input class="required input_small txt" type="text" name="answer" value="" /><label>Calculate (5-2+1) </label></p>
										
									<p><a class="button small" onclick="jQuery('#ajax-contact-form').submit();return false;"><span>Send</span></a><label id="load"></label></p>
								</form>
							</div>
				</div>
			</div>				
			
		</div>	
	</div>
</div>
<!-- pagemid -->	
</asp:Content>
