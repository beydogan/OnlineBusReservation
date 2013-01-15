<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="users.aspx.cs" Inherits="BusReservation.admin.users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2>User List</h2>
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

                    <asp:GridView ID="UserGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"
                     
                        ShowFooter="false"
                        DataKeyNames="user_id"
                        >

                        <Columns>
                            <asp:TemplateField HeaderText="User Name" HeaderStyle-HorizontalAlign="Left">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lblUName" runat="server" Text='<%# Bind("username") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Password" HeaderStyle-HorizontalAlign="Left">
                                
                                <ItemTemplate>
                                    <asp:Label ID="lblPassword" runat="server" Text='<%# Bind("password") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="E-mail" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                </ItemTemplate>

                                     <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User level" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblULevel" runat="server" Text='<%# Bind("user_level") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>

                              
                            <asp:TemplateField HeaderText="Sales" HeaderStyle-HorizontalAlign="Left">
                               
                                <ItemTemplate>
                                    <asp:Label ID="lblSales" runat="server" Text='<%# Bind("sales") %>'></asp:Label>
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
