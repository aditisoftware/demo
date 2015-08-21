<cfoutput>
    <form action="">
        <div class="col-md-6">
            <div class="row">
                <div class="col-md-6 margin-bottom-15">
                    <Label ID="lblStatus" Text="Label" class="alert-danger" Visible="false"></Label>
                </div>
            </div>
            <div class="form-group">
                <label>First Name</label>
                <input type="text" ID="firstname" name="firstname" class="form-control" placeholder="First Name" />
            </div>
            <div class="form-group">
                <label>Last Name</label>
                <input type="text" ID="lastname" name="lastname" class="form-control" placeholder="Last Name" />
            </div>
            <div class="form-group">
                <label>Address1</label>
                <input type="text" ID="address1" name="address1" class="form-control" placeholder="Address1" />
            </div>
            <div class="form-group">
                <label>Address2</label>
                <input type="text" ID="address2" name="address2" class="form-control" placeholder="Address2" />
            </div>
            <div class="form-group">
                <label>City</label>
                <input type="text" ID="city" name="city" class="form-control" placeholder="City" />
            </div>
            <div class="form-group">
                <label>State</label>
                <input type="text" ID="state" name="state" class="form-control" placeholder="State" />
            </div>
            <div class="form-group">
                <label>Country</label>
                <input type="text" ID="country" name="country" class="form-control" placeholder="State" />
            </div>
            <div class="form-group">
                <label>Username</label>
                <input type="text" ID="username" name="username" class="form-control" placeholder="Username" />
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="text" ID="password" name="password" class="form-control" placeholder="Password" />
            </div>
            <div class="form-group">
                <label>Usertype</label>
                <select ID="usertype" name="usertype"  class="form-control">
                    <option>Admin</option>
                    <option>Agent</option>
                    <option>Staff</option>
                </select>
            </div>
        </div>
        <div class="col-md-8">
            <asp:HiddenField ID="id" Value="" />
            <Button type="submit" ID="Add" CssClass="btn btn-primary" Text="Add" OnClick="add_click" />&nbsp;
            <Button type="submit" ID="Update" class="btn btn-info" Text="Update" OnClick="Update_Click" />
            <Button type="submit" ID="Delete" class="btn btn-danger" Text="Delete" OnClick="Delete_Click" />
            <Button type="reset" id="reset" class="btn btn-default" title="Reset" type="reset" value="Reset" />
        </div>
    </form>
</cfoutput>