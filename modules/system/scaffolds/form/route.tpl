
#new a record
get '/<%=@t[:layout]%>/<%=@t[:file_name]%>/new' do

	@title = 'Create a new <%=@t[:file_name]%>'
	<%=@t[:file_name]%>_set_fields
	slim :<%=@t[:layout]%>_<%=@t[:file_name]%>_form

end

post '/<%=@t[:layout]%>/<%=@t[:file_name]%>/new' do

	<%=@t[:file_name]%>_set_fields
	<%=@t[:file_name]%>_valid_fields
	<% if @t[:fields].include?('created') %>@fields[:created] = Time.now<% end %>
	<% if @t[:fields].include?('changed') %>@fields[:changed] = Time.now<% end %>
	DB[:<%=@t[:table_name]%>].insert(@fields)
	redirect back

end