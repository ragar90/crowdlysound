$("#rock_<%= @item.class.name + "_" + @item.id.to_s %>").html("<%=j render :partial => "rocks/rock_content", :locals => {:item => @item} %>")