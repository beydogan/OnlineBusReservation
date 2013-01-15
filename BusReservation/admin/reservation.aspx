<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="reservation.aspx.cs" Inherits="BusReservation.admin.Reservation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2 style="float:left">Reservations List</h2>
                    
                    <script type="text/javascript">
                        $(function () {
                            $('.datetimepicker1').datetimepicker({
                                language: 'tr-TR'
                            });
                        });
                     </script>
                    <asp:Panel ID="errorPanel" runat="server" CssClass="alert alert-error" Visible="false">
                    </asp:Panel>

                    <div style="float:right">  
                        <div style="float:left; padding-top: 5px; font-weight: bold">Search Between:</div>                      
                        <div class="datetimepicker1 input-append date" style="float:left">
                            <asp:TextBox ID="rangeFrom" runat="server" Width="90px" data-format="dd.MM.yyyy" text='<%# DateTime.Now.ToString("dd.MM.yyyy") %>'></asp:TextBox>
                            <span class="add-on">
                                <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
                            </span>
                        </div>
                        <div style="float:left; padding-top: 5px; font-weight: bold"> &nbsp;-&nbsp; </div>      
                         <div class="datetimepicker1 input-append date" style="float:left">
                            <asp:TextBox ID="rangeTo" runat="server" Width="90px" data-format="dd.MM.yyyy" text='<%# DateTime.Now.ToString("dd.MM.yyyy") %>'></asp:TextBox>
                            <span class="add-on">
                                <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
                            </span>
                        </div>
                        <div style="float:left; margin-left: 5px" >
                            <asp:LinkButton ID="SearchRange" runat="server" CssClass="btn btn-inverse" OnClick="SearchRange_Click"><span>Search</span></asp:LinkButton>

                        </div> 
                    </div>
			    </header>
			    <section>
                    <asp:GridView ID="ReservationGrid" runat="server" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"> </asp:GridView>

                </section>
            </div>
        </article>
         <!-- /Data block -->

     </div>
    <!-- /Grid row -->
</asp:Content>
