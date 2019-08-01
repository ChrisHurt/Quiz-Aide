get '/metrics' do
    if current_user.class.to_s == 'Student'
        @student = current_user
        erb :student
    end 
end