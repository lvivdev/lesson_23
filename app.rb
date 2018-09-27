#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def is_barber_exists? db, name
	db.execute('select * from Barbers where name=?', [name]).length > 0
end

def seed_db db, barbers
	barbers.each do |barber|
		if !is_barber_exists? db, barber
			db.execute 'insert into Barbers (name) values (?)', [barber]
		end
	end	
end

def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end

before do
	db = get_db
	@barbers = db.execute'select * from Barbers'
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS "Users" ( 
	"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
	"barber" TEXT, 
	"username" TEXT, 
	"date_stamp" TEXT, 
	"color" TEXT 
	)'
	db.execute 'CREATE TABLE IF NOT EXISTS "Barbers" ( 
	"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
	"name" TEXT
	)'

	seed_db db, ['Jessie Pinkman', 'Walter White', 'Gus Fring', 'Mike Ehrmantraut']
end

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
	@date_stamp = params[:date_stamp]
	@color = params[:colorpicker]

	hh = {
		:username => 'Enter username',
		:date_stamp => 'Enter date'
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

	db = get_db
	db.execute 'insert into Users (
	barber,
	username,
	date_stamp,
	color
	)
	values (?, ?, ?, ?)',[@barber, @username, @date_stamp, @color]
	db.close

	erb "Username: #{@username}, date: #{@date_stamp}, barber: #{@barber}, color: #{@color}"

end


get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@textarea = params[:textarea]

	hh = {
		:email => 'Enter email',
		:textarea => 'Enter text'
	}

	@error = hh.select {|key,_| params[key] == ''}.values.join(", ")

	if @error != ''
		return erb :contacts
	end

	erb 'Thank you for your message. We will contact you as soon as possible.'
end

get '/showusers' do
	db = get_db
	@results = db.execute 'select * from Users order by id desc'
	
	erb :showusers
end