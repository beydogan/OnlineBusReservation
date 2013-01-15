<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="route.aspx.cs" Inherits="BusReservation.admin.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2>Routes List</h2>
			    </header>
			    <section>
                    <script type="text/javascript">
                        $(function () {
                            $('.datetimepicker1').datetimepicker({
                                language: 'tr-TR'
                            });
                        });
                     </script>
                    <asp:GridView ID="RouteGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"
                        OnSelectedIndexChanged="RouteGrid_SelectedIndexChanged"
                        OnRowCommand="Grid_Insert" 
                        OnRowEditing="Grid_Edit"
                        OnRowUpdating="Grid_Update"
                        OnRowDeleting="Grid_Delete"
                        OnRowDataBound = "Grid_DataBound"
                        OnRowCancelingEdit="RouteGrid_RowCancelingEdit"
                        ShowFooter="True"
                        DataKeyNames="route_id"
                        ShowHeaderWhenEmpty="true"
                        >

                        <Columns>
                            <asp:TemplateField HeaderText="Departure City" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlFromEdit" runat="server" DataSourceID="SqlDataSource1" DataTextField="city_name" DataValueField="city_id" SelectedValue='<%# Eval("from_city") %>' Width="120px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlFromNew" runat="server" DataSourceID="SqlDataSource1" DataTextField="city_name" DataValueField="city_id"  Width="120px">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblFrom" runat="server" Text='<%# Bind("from_city_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Arrival City" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlToEdit" runat="server" DataSourceID="SqlDataSource1" DataTextField="city_name" DataValueField="city_id" SelectedValue='<%# Eval("to_city") %>' Width="120px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlToNew" runat="server" DataSourceID="SqlDataSource1" DataTextField="city_name" DataValueField="city_id"  Width="120px">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblTo" runat="server" Text='<%# Bind("to_city_name")%>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Departure Date" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <div class="datetimepicker1 input-append date">
                                        <asp:TextBox ID="txtDepEdit" runat="server" Width="90px" data-format="dd.MM.yyyy hh:mm" text='<%# Convert.ToDateTime(Eval("departure_time")).ToString("dd.MM.yyyy H:mm") %>'></asp:TextBox>
                                        <span class="add-on">
                                            <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
                                        </span>
                                    </div>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <div class="datetimepicker1 input-append date">
                                        <asp:TextBox ID="txtDepNew" runat="server" Width="90px" data-format="dd.MM.yyyy hh:mm" Text='<%# DateTime.Now.ToString("dd.MM.yyyy H:mm") %>' ></asp:TextBox>
                                        <span class="add-on">
                                            <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
                                        </span>
                                    </div>
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
                                    <asp:TextBox ID="txtFareNew" runat="server" Width="50px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblFare" runat="server" Text='<%# Bind("fare") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Driver Name" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtDriverEdit" runat="server" Text='<%# Bind("driver_name") %>' Width="90px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtDriverNew" runat="server" Width="90px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDriver" runat="server" Text='<%# Bind("driver_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bus Licence Plate" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlBusEdit" runat="server" DataSourceID="BusDataSource" DataTextField="license_plate" DataValueField="bus_id"  SelectedValue='<%# Eval("b_id") %>' Width="110px">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlBusNew" runat="server" DataSourceID="BusDataSource" DataTextField="license_plate" DataValueField="bus_id"  Width="110px">
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblBus" runat="server" Text='<%# Bind("license_plate") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False"  HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:LinkButton class="btn btn-flat" ID="btnUpdate" runat="server" CausesValidation="True" CommandName="Update" ><span class="awe-ok"></span></asp:LinkButton> 
                                    <asp:LinkButton class="btn btn-flat" ID="btnCancel" runat="server" CausesValidation="True" CommandName="Cancel" ><span class="awe-remove"></span></asp:LinkButton> 

                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:LinkButton class="btn btn-flat" ID="btnInsert" runat="server" CausesValidation="True" CommandName="New"><span class="awe-plus"></span></asp:LinkButton> 
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton class="btn btn-flat" ID="btnEdit" runat="server" CausesValidation="True" CommandName="Edit" ><span class="awe-edit"></span></asp:LinkButton> 
                                    <asp:LinkButton class="btn btn-flat" ID="btnDelete" runat="server" CommandName="Delete" CausesValidation="true" OnClientClick="return confirm('Are you sure?')" ><span class="awe-trash" ></span></asp:LinkButton> 
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
