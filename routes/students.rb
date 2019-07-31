# Student's home page
get '/students/home' do
    # @student - once you have a teacher database
    erb :student_home
  end
  
  # Student's question list
  get '/students/questions' do
    # @student - once you have a teacher database
    # After authentication, consolidate the home page
    @questions = Latin_Question.all
    erb :student_questions
  end
  
  post '/students/questions' do
    student_answer =  Student_Answer.new
    student_answer.studentid = session[:user_id]
    student_answer.questionid = params[:question_id]
    student_answer.answer = params[:answer]
    student_answer.save
    redirect '/students/questions'
  end
  
  # Student's answer history
  get '/students/answers' do
    # @student - once you have a teacher database
    # After authentication, consolidate the home page
    erb :student_answers
  end
  
  # Student's metrics
  get '/students/metrics' do
    # @student - once you have a teacher database
    # After authentication, consolidate the home page
    erb :student_metrics
  end