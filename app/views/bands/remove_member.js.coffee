$("#band_members").html("<%=j render :partial => "musician", :collection => @band.members %>")
alert "The member was removed from band"