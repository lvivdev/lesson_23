#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@barber = params[:barber]
	@username = params[:username]
	@date = params[:date]
	@color = params[:colorpicker]

	hh = {
		:username => 'Enter username',
		:date => 'Enter date'
	}

	@error = hh.select {|key,_| params[key] == ''}.values.join(", ")

	if @error != ''
    	return erb :visit
	end
	
	# hh.each do |key, value|
	# 	if params[key] == ''

	# 		@error = hh[key]
	# 		return erb :visit
			
	# 	end
	# end

	f = File.open './public/file.txt', 'a'
	f.write "Barber is: #{@barber}, Username: #{@username}, date: #{@date}, color: #{@color}"
	f.close

	erb "Username: #{@username}, date: #{@date}, barber: #{@barber}, color: #{@color}"

end


get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@textarea = params[:textarea]

	f = File.open './public/contacts.txt', 'a'
	f.write "===Email: #{@email}, message: #{@textarea}==="
	f.close

	erb 'Thank you for your message. We will contact you as soon as possible.'
end