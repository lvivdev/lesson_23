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

	f = File.open './public/file.txt', 'a'
	f.write "Barber is: #{@barber}, Username: #{@username}, date: #{@date}"
	f.close

	erb "Dear #{@username}! We will wait for you on #{@date}. Remember, your barber is #{@barber}"
end


get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@textarea = params[:textarea]

	f = File.open './public/contacts.txt', 'a'
	f.write "Email: #{@email}, message: #{@textarea}"
	f.close

	erb 'Thank you for your message. We will contact you as soon as possible.'
end