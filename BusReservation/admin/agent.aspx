<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="agent.aspx.cs" Inherits="BusReservation.admin.Agent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2>Agents List</h2>
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

                    <asp:GridView ID="AgentGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"
                        OnRowCommand="Grid_Insert" 
                        OnRowEditing="Grid_Edit"
                        OnRowUpdating="Grid_Update"
                        OnRowDeleting="Grid_Delete"
                        OnRowDataBound = "Grid_DataBound"
                        OnRowCancelingEdit="AgentGrid_RowCancelingEdit"
                        ShowFooter="True"
                        DataKeyNames="agent_id"
                        >

                        <Columns>
                            <asp:TemplateField HeaderText="Agent Name" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtNameEdit" runat="server" Text='<%# Bind("agent_name") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtNameNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("agent_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmailEdit" runat="server" Text='<%# Bind("email") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtEmailNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone Number" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPhoneEdit" runat="server" Text='<%# Bind("phone_number") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtPhoneNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPhone" runat="server" Text='<%# Bind("phone_number") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAddressEdit" runat="server" Text='<%# Bind("address") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtAddressNew" runat="server" Width="100px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("address") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="false" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                </EditItemTemplate>
                                <FooterTemplate>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:HyperLink ID="showEmployees" runat="server" NavigateUrl='<%# String.Format("employee.aspx?agent_id={0}", Eval("agent_id")) %>'>Employees</asp:HyperLink> |
                                    <asp:HyperLink ID="showSales" runat="server" NavigateUrl='<%# String.Format("reservation.aspx?agent_id={0}", Eval("agent_id")) %>' >Sales</asp:HyperLink> 
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
