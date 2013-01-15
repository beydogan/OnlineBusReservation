<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="bus.aspx.cs" Inherits="BusReservation.admin.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2>Bus List</h2>
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

                    <asp:GridView ID="BusGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"
                        OnRowCommand="Grid_Insert" 
                        OnRowEditing="Grid_Edit"
                        OnRowUpdating="Grid_Update"
                        OnRowDeleting="Grid_Delete"
                        OnRowDataBound = "Grid_DataBound"
                        OnRowCancelingEdit="BusGrid_RowCancelingEdit"
                        ShowFooter="True"
                        DataKeyNames="bus_id"
                        >

                        <Columns>
                            <asp:TemplateField HeaderText="Bus Name" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNameEdit" runat="server" Text='<%# Bind("bus_name") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtNameNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("bus_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Seat Count" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSeatEdit" runat="server" Text='<%# Bind("seat_count") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtSeatNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSeat" runat="server" Text='<%# Bind("seat_count") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bus Type" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtTypeEdit" runat="server" Text='<%# Bind("type") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtTypeNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblType" runat="server" Text='<%# Bind("type") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="License Plate" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPlateEdit" runat="server" Text='<%# Bind("license_plate") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtPlateNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPlate" runat="server" Text='<%# Bind("license_plate") %>'></asp:Label>
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
