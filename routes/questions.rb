post '/students/questions' do
  student_answer =  StudentAnswer.new
  student_answer.student_id = session[:user_id]
  student_answer.latin_question_id = params[:latin_question_id]
  student_answer.answer = params[:answer]
  student_answer.outcome = params[:outcome]
  student_answer.save
  redirect '/questions'
end

# All Question Records
get '/questions' do
  case session[:user_type]

  when 'Administrator'

  when 'Teacher'
    @questions = LatinQuestion.all
    erb :teacher_questions
  when 'Student'
    # Find list of all questions student has attempted
    attempted_questions = StudentAnswer.all.where(student_id: current_user.id).distinct.pluck(:latin_question_id)
    all_questions = LatinQuestion.all.pluck(:id)

    @questions = LatinQuestion.all.where.not(id: attempted_questions)
    # Find a list of all questions the student has not attempted


    erb :student_questions
  else
    redirect '/login'
  end
end

# Show a specific teachers' questions
get '/teachers/:id/questions' do
  if session[:user_id] && session[:user_type] != 'Student'
    @questions = LatinQuestion.where(teacher_id: params[:id])
    # Connect to a relevant page
    erb :questions
  else
    session = {}
    redirect '/login'
  end
end

# Show all questions
get '/teachers/questions' do
  if session[:user_id] && session[:user_type] != 'Student'
    @questions = LatinQuestion.all
    # Connect to a relevant page
    erb :questions
  else
    session = {}
    redirect '/login'
  end
end


# New Question Record
get '/questions/new' do
  redirect '/questions' unless (session[:user_id] && (session[:user_type] != 'Student'))
  erb :add_question
end

# Individual Question Record
get '/questions/:id' do
  @question = LatinQuestion.find(params[:id])
erb :question
end

# Creating a New Question
post '/questions' do 
  if loggedIn? && session[:user_type] && session[:user_type] == 'Teacher'
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
  if loggedIn? && session[:user_type] && session[:user_type] == 'Teacher'
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
question = LatinQuestion.find(params[:id])
question.delete
redirect '/questions'
end