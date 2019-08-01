get '/answers' do
    if loggedIn? && session[:user_type] == 'Student'
        @student =  current_user
    elsif loggedIn? && session[:user_type] == 'Teacher'
        
    end
    @student_answers = StudentAnswer.all.where(student_id: @student.id)
    erb :student_answers
end

get '/answers/review' do
    if loggedIn? && session[:user_type] == 'Teacher'
        teachers_questions = current_user.latin_questions
        @review_questions = []
        teachers_questions.each do |teacher_question|
            @review_questions << teacher_question.student_answers   
        end
        @review_questions.flatten!
    elsif loggedIn? && session[:user_type] == 'Student'

    end
    
    # @student_answers = StudentAnswer.where(student_id: @student.id)
    erb :answers_review
end

put '/answers:id' do 
    student_answer = StudentAnswer.find_by(id: params[:id])
    student_answer.outcome = params[:outcome]
    student_answer.reviewed = true
    student_answer.save

    redirect '/answers/review'
end