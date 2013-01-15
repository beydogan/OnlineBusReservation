<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="employee.aspx.cs" Inherits="BusReservation.admin.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">				
	    <!-- Data block -->
	    <article class="span12 data-block">
		    <div class="data-container">
			    <header>
				    <h2>Employee List</h2>
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

                    <asp:GridView ID="EmpGrid" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CssClass="table table-striped" EnableTheming="False"
                        OnRowCommand="Grid_Insert" 
                        OnRowEditing="Grid_Edit"
                        OnRowUpdating="Grid_Update"
                        OnRowDeleting="Grid_Delete"
                        OnRowDataBound = "Grid_DataBound"
                        OnRowCancelingEdit="EmpGrid_RowCancelingEdit"
                        ShowFooter="True"
                        DataKeyNames="employee_id" OnSelectedIndexChanged="EmpGrid_SelectedIndexChanged1"
                        >

                        <Columns>

                            <asp:TemplateField HeaderText="First Name" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtFNameEdit" runat="server" Text='<%# Bind("first_name") %>' Width="80px"></asp:TextBox>
                                   <asp:HiddenField ID="User_id" Value='<%# Bind("user_id") %>' runat="server"></asp:HiddenField>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtFNameNew" runat="server" Width="80px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    
                                    <asp:Label ID="lblFName" runat="server" Text='<%# Bind("first_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLNameEdit" runat="server" Text='<%# Bind("last_name") %>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtLNameNew" runat="server" Width="80px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblLName" runat="server" Text='<%# Bind("last_name") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="E-Mail" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEmailEdit" runat="server" Text='<%# Bind("email") %>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtEmailNew" runat="server" Width="80px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Phone Number" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPhoneEdit" runat="server" Text='<%# Bind("phone_number") %>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtPhoneNew" runat="server" Width="80px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPhone" runat="server" Text='<%# Bind("phone_number") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="User Name" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtUserNameEdit" runat="server" Text='<%# Bind("username") %>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtUserNameNew" runat="server" Width="60px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblUserName" runat="server" Text='<%# Bind("username") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Password" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPasswordEdit" runat="server" Text='<%# Bind("password") %>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtPasswordNew" runat="server" Width="60px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblPassword" runat="server" Text='<%# Bind("password") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sales" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtSalesEdit" runat="server" Text='<%# Bind("sales") %>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtSalesNew" runat="server" Width="30px"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSales" runat="server" Text='<%# Bind("sales") %>'></asp:Label>
                                </ItemTemplate>

                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Gender" HeaderStyle-HorizontalAlign="Left">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlGenderEdit" runat="server" SelectedValue='<%# Eval("gender") %>' Width="120px">
                                        <asp:ListItem Value="0">Male</asp:ListItem>
                                        <asp:ListItem Value="1">Female</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:DropDownList ID="ddlGenderNew" runat="server"  Width="80px">
                                        <asp:ListItem Value="0">Male</asp:ListItem>
                                        <asp:ListItem Value="1">Female</asp:ListItem>
                                    </asp:DropDownList>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblGender" runat="server" Text='<%# Bind("gender") %>'></asp:Label>
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
