get '/' do
  erb :index
end

get "/search" do
  @videos = Playlist.find(1).videos
  erb :search
end

post '/search' do
  @results = Playlist.search_for_video(params[:query])

  if request.xhr?
    erb :_results, layout: false
  else
    "You dun goofed"
  end
end



post '/videos' do
  p params
  @video = Video.new(params[:video])

  if @video.save
    if request.xhr?
      @videos = Playlist.find(1).videos << @video
      erb :_playlist, layout: false
    else
      redirect '/search'
    end
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
