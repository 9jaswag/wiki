require 'sinatra'

def page_content(title)
  File.read("pages/#{title}.txt")
rescue Errno::ENOENT
  nil
end

get('/') do
  erb :welcome
end

get '/:title' do
  @title = params[:title]
  @content = page_content @title
  erb :show
end
