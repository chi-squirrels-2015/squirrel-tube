post '/users' do
  user= User.new(params[:user])

  if user.save
    session[:user_id] = user.id
    erb :playlist
  else
    redirect '/'
  end

end
