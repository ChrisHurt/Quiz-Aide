get '/metrics' do
    redirect '/login' unless logged_in?
    redirect '/home' unless session[:user_type] == 'Student'
    @student = current_user
    erb :student
end