# Login Portal
get '/login' do
    erb :login
  end
  
  # Authenticate User (Login)
  post '/sessions' do 
    user = Student.find_by(email: params[:email])
    if !user
      user = Teacher.find_by(email: params[:email])
    end
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:user_type] = user.class.to_s
      if session[:user_type] == 'Student'
        redirect '/students/home'
      else
        redirect '/teachers/home'
      end
    else
      erb :login
    end  
  end
  
  # Logout
  delete '/sessions' do
    session[:user_id] = nil
    redirect 'login'
  end