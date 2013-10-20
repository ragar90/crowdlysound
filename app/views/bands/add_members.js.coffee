cache = {}
$("#add_member").val("")
$("#band_members").html("<%=j render :partial => "musician", :collection => @band.members %>")
alert "The new members were added to the band"