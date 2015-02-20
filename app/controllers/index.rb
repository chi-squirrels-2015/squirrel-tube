get '/' do
  erb :index
end

get "/playlist" do
  erb :playlist
end

post '/playlist' do
  @results = Playlist.search_for_video(params[:query])
  erb :_results
end

post '/videos' do
  p params
  video = Video.new(params[:video])

  if video.save
    "Turnt"
  end
end

post '/login' do
  if user = User.authenticate(params[:email], params[:password])
    session[:user_id] = user.id
    erb :playlist
  else
    redirect '/'
  end
end

get '/logout' do

end
