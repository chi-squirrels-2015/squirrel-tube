get '/' do
  erb :index
end

get "/search" do
  @videos = Playlist.find(1).sorted_videos
  erb :search
end

get '/player' do
  @videos = Playlist.find(1).sorted_videos

  erb :player, layout: false
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
  @video.playlist_id = 1
  @video.save

  if request.xhr?
    puts "I'm in here!"
    puts
    @videos = Playlist.find(1).sorted_videos
    erb :_playlist, layout: false
  else
    redirect '/search'
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
  session.delete(:user_id)
end

post '/votes' do
  @video = Video.find(params[:vidId])
  Vote.create(video: @video, user: current_user)
  @videos = Playlist.find(1).sorted_videos
  erb :_playlist, layout: false
end
