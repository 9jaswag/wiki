require 'sinatra'
require 'uri'

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  nil
end

def save_content(title, content)
  File.open("pages/#{title}.txt", 'w') do |file|
    file.puts content
  end
end

get('/') do
  erb :welcome
end

get '/new' do
  erb :new
end

post '/create' do
  title = params[:title]
  content = params[:content]
  save_content(title, content)
  redirect URI.escape("/#{title}")
end

get '/:title' do
  @title = params[:title]
  @content = page_content @title
  erb :show
end

get '/:title/edit' do
  @title = params[:title]
  @content = page_content @title
  erb :edit
end

put '/:title' do
  title = params[:title]
  content = params[:content]
  save_content(title, content)
  redirect URI.escape("/#{title}")
end
