get '/answers' do
    if loggedIn? && session[:user_type] == 'Student'
        @student =  current_user
    elsif loggedIn? && session[:user_type] == 'Teacher'
        
    end
    @student_answers = StudentAnswer.all.where(student_id: @student.id)
    erb :student_answers
end