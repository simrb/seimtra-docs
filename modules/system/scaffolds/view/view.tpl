table.table
	thead<% @t[:fields].each do | field | %><% origin = field; field = @t[:assoc][field][2] if @t[:assoc].has_key?(field) %>
		th : a href="#{sys_url('/<%=@t[:layout]%>/<%=@t[:file_name]%>', :order => '<%=origin%>')}" = L[:<%=field%>]<% end %>
		th
	tbody<% unless @t[:assoc].empty?
			@t[:assoc].each do | field, data | %>
		- <%=data[0]%>s = sys_kv(:<%=data[0]%>, :<%=data[1]%>, :<%=data[2]%>)<% end %><% end %>
		- @<%=@t[:file_name]%>.each do | row |
			tr<% @t[:fields].each do | field | 
					if @t[:assoc].has_key? field
						if @t[:htmls][field] == "checkbox"%>
				td
					- row[:<%=@t[:assoc][field][1]%>].split(".").each do | item |
						label = <%=@t[:assoc][field][0]%>s[item.to_i]
						label &nbsp;<% 
						else %>
				td = <%=@t[:assoc][field][0]%>s[row[:<%=field%>]]<%
						end
					else %>
				td = row[:<%=field%>]<% end %><% end %>

- if @page_count > 1
	p.page_bar
		- for i in 1..@page_count
			- page_focus = i == @page_curr ? "page_focus" : ""
			span : a class="#{page_focus}" href="#{sys_url(request.path, :page_curr => i)}" = i
