# Admin|Teacher|Student: View Relevant Question Records
get '/questions' do
  redirect '/login' unless logged_in? 
  case session[:user_type]

  when 'Administrator'

  when 'Teacher'
    @questions = LatinQuestion.all
    erb :teacher_questions
  when 'Student'
    attempted_questions = StudentAnswer.all.where(student_id: current_user.id).distinct.pluck(:latin_question_id)
    @questions = LatinQuestion.all.where.not(id: attempted_questions)
    erb :student_questions
  else
    redirect '/login'
  end
end

# Admin|Teacher: Show a specific teachers' questions
get '/teachers/:id/questions' do
  redirect '/login' unless logged_in?
  if session[:user_type] != 'Student'
    @questions = LatinQuestion.where(teacher_id: params[:id])
    # Connect to a relevant page
    erb :questions
  else
    session = {}
    redirect '/login'
  end
end

# Admin|Teacher:  View questions added by a specific teacher
get '/teachers/:id/questions' do
  redirect '/login' unless logged_in?
  redirect '/home' unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @questions = LatinQuestion.where(teacher_id: params[:id])
  erb :questions
end

# Admin|Teacher: Show all questions
get '/teachers/questions' do
  redirect '/login' unless logged_in?
  if session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
    @questions = LatinQuestion.all
    erb :questions
  else
    session = {}
    redirect '/login'
  end
end


# Teacher: New Question Record
get '/questions/new' do
  redirect '/login' unless logged_in?
  redirect '/questions' unless session[:user_type] == 'Teacher'
  erb :add_question
end

# Admin|Teacher: Individual Question Record
get '/questions/:id' do
  redirect '/login' unless logged_in?
  redirect '/questions' unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @question = LatinQuestion.find(params[:id])
erb :question
end

# Teacher: Creating a New Question
post '/questions' do 
  if logged_in? && session[:user_type] && session[:user_type] == 'Teacher'
    question = LatinQuestion.new
    question.body = params[:question]
    question.assessment_type = params[:assessment_type]
    question.answer_key = params[:answer_key]
    question.teacher_id = current_user.id
    question.save
  end
  redirect '/questions'
end

# Updating a Question Record
put '/questions/:id' do
  if logged_in? && session[:user_type] == 'Administrator' || session[:user_type] == 'Teacher'
    question = LatinQuestion.find_by(id: params[:id])
    question.body = params[:body]
    question.assessment_type = params[:assessment_type]
    question.answer_key = params[:answer_key]
    question.teacher_id = current_user.id
    question.save
  end
  redirect '/questions'
end

# Deleting a Question Record
delete '/questions/:id' do 
  redirect '/login' unless logged_in?
  redirect '/questions' unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  question = LatinQuestion.find(params[:id])
  question.delete
  redirect '/questions'
end
