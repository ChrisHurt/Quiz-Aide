# All Users: Login Portal
get '/login' do
  erb :login
end

# All Users: Authenticate User (Login)
post '/sessions' do 
  user = Student.find_by(email: params[:email])
  if !user
    user = Teacher.find_by(email: params[:email])
  end
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    session[:user_type] = user.class.to_s
    redirect '/home'
  else
    erb :login
  end  
end

# All Users: Logout
delete '/sessions' do
  session[:user_id] = nil
  session[:user_type] = nil
  redirect 'login'
end