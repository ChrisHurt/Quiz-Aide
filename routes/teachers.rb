# Teacher's home page
get '/teachers/home' do
    # @teacher - once you have a teacher database
    # After authentication, consolidate the home page
    erb :teacher_home
  end

  # All Student Records
get '/students' do 
  @students = Student.all
  erb :students
end

# New Student Record
get '/students/new' do
  erb :add_student
end

# Individual Student Record
get '/students/:id' do
  @student = Student.find(params[:id])
  erb :student
end

# Creating a New Student
post '/students' do 

  student = Student.new
  student.first_name = params[:first_name]
  student.middle_name = params[:middle_name]
  student.last_name = params[:last_name]
  student.class_id = params[:class_id]
  student.email = params[:email]
  student.password = params[:password]
  student.save

  redirect '/students'
end

# Updating a Student Record
put '/students/:id' do 
  student = Student.find(params[:id])
  student.first_name = params[:first_name]
  student.middle_name = params[:middle_name]
  student.last_name = params[:last_name]
  student.class_id = params[:class_id]
  student.email = params[:email]
  student.password = params[:password]
  student.save
  redirect '/students'
end

# Deleting a Student Record
delete '/students/:id' do 
  student = Student.find(params[:id])
  student.delete
  redirect '/students'
end

# All Class Records
get '/classes' do 
  @classes = School_Class.all
  erb :classes
end

# New Class Record
get '/classes/new' do
  erb :add_class
end

# Individual Class Record
get '/classes/:id' do
  @class = School_Class.find(params[:id])
  erb :class
end

# Creating a New Class
post '/classes' do 

  school_class = School_Class.new
  school_class.year = params[:year]
  school_class.class_letter = params[:class_letter]
  school_class.teacher_id = params[:teacher_id]
  school_class.save

  redirect '/classes'
end

# Updating a Class Record
put '/classes/:id' do 
  school_class = School_Class.find(params[:id])
  school_class.year = params[:year]
  school_class.class_letter = params[:class_letter]
  school_class.teacher_id = params[:teacher_id]
  school_class.save
  redirect '/classes'
end

# Deleting a Class Record
delete '/classes/:id' do 
  school_class = School_Class.find(params[:id])
  school_class.delete
  redirect '/classes'
end





# All Question Records
get '/questions' do 
  @questions = Latin_Question.all
  erb :questions
end

# New Question Record
get '/questions/new' do
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
  question.question = params[:question]
  question.question_type = params[:question_type]
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