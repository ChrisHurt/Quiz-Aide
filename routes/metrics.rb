get '/metrics' do
    redirect '/login' unless logged_in? && session[:user_type] == 'Student'
    erb :page_not_found unless session[:user_type] == 'Student'
    @student = current_user
    erb :student
end