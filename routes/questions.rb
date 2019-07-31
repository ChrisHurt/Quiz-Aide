
post '/students/questions' do
  student_answer =  Student_Answer.new
  student_answer.studentid = session[:user_id]
  student_answer.questionid = params[:question_id]
  student_answer.answer = params[:answer]
  student_answer.save
  redirect '/students/questions'
end

  # All Question Records
get '/questions' do
  case session[:user_type]

  when 'Administrator'

  when 'Teacher'
    @questions = Latin_Question.all
    erb :questions
  when 'Student'
    @questions = Latin_Question.all
    erb :student_questions
  else
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
  @question = Latin_Question.find(params[:id])
erb :question
end

# Creating a New Question
post '/questions' do 

  question = Latin_Question.new
  question.body = params[:question]
  question.assessment_type = params[:assessment_type]
  question.answer_key = params[:answer_key]
  question.save

  redirect '/questions'
end

# Updating a Question Record
put '/questions/:id' do 
    question = Latin_Question.find(params[:id])
    question.question = params[:question]
    question.question_type = params[:question_type]
    question.answer_key = params[:answer_key]
    question.save
    redirect '/questions'
end

# Deleting a Question Record
delete '/questions/:id' do 
question = Latin_Question.find(params[:id])
question.delete
redirect '/questions'
end