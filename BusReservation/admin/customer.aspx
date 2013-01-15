<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="customer.aspx.cs" Inherits="BusReservation.admin.customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2>Customer List</h2>
			    </header>
			    <section>
                    <script type="text/javascript">
                        $(function () {
                            $('.datetimepicker1').datetimepicker({
                                language: 'tr-TR'
                            });
                        });
                        </script>
                    <asp:Panel ID="errorPanel" runat="server" CssClass="alert alert-error" Visible="false">
                    </asp:Panel>

                    <asp:GridView ID="CustomerGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"
                     
                        ShowFooter="false"
                        DataKeyNames="customer_id"
                        >

                        <Columns>
                            <asp:TemplateField HeaderText="First Name" HeaderStyle-HorizontalAlign="Left">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lblFName" runat="server" Text='<%# Bind("first_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" HeaderStyle-HorizontalAlign="Left">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lblLName" runat="server" Text='<%# Bind("last_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone Number" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblPhone" runat="server" Text='<%# Bind("phone_number") %>'></asp:Label>
                                </ItemTemplate>

                                     <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Birthdate" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lbleBDate" runat="server" Text='<%# Bind("birth_date") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>

                              
                            <asp:TemplateField HeaderText="Gender" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblgender" runat="server" Text='<%# Bind("gender") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>

                                
                            <asp:TemplateField HeaderText="E-Mail" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblemailr" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>

                                 
                            <asp:TemplateField HeaderText="Dependent Agent" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblUserID" runat="server" Text='<%# Bind("agent_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                           

                        </Columns>

                        <RowStyle BorderWidth="0px" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="BusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:bus_reservationConnectionString %>" SelectCommand="SELECT [bus_id], [license_plate] FROM [Bus]"></asp:SqlDataSource>
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bus_reservationConnectionString %>" SelectCommand="SELECT * FROM [Cities]"></asp:SqlDataSource>
                </section>
            </div>
        </article>
        <!-- /Data block -->

    </div>
    <!-- /Grid row -->
</asp:Content>
