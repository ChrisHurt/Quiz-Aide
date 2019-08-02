get '/answers' do
    redirect '/login' unless logged_in?   
    if session[:user_type] == 'Student'
        @student =  current_user
    elsif session[:user_type] == 'Teacher'

    elsif session[:user_type] == 'Administrator'
        
    end
    @student_answers = StudentAnswer.all.where(student_id: @student.id)
    erb :student_answers
end

get '/answers/review' do
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Administrator'
    if logged_in? && session[:user_type] == 'Teacher'
        teachers_questions = current_user.latin_questions
        @review_questions = []
        teachers_questions.each do |teacher_question|
            @review_questions << teacher_question.student_answers   
        end
        @review_questions.flatten!
    elsif logged_in? && session[:user_type] == 'Student'

    end
    
    # @student_answers = StudentAnswer.where(student_id: @student.id)
    erb :answers_review
end

# Admin|Student: Answer a question
post '/students/questions' do
  redirect '/login' unless logged_in?
  redirect '/questions' unless session[:user_type] != 'Teacher'
  session[:question] = nil
  student_answer =  StudentAnswer.new
  student_answer.student_id = session[:user_id]
  student_answer.latin_question_id = params[:latin_question_id]
  student_answer.answer = params[:answer]
  student_answer.outcome = params[:outcome]
  student_answer.save
  redirect '/questions'
end
  
# Admin|Teacher: Review an answer and update the outcome
put '/answers:id' do
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
    student_answer = StudentAnswer.find_by(id: params[:id])
    student_answer.outcome = params[:outcome]
    student_answer.reviewed = true
    student_answer.save
    case session[:user_type]
    when 'Teacher'
        redirect '/answers/review'
    when 'Administrator'
        redirect '/answers'
    end
end