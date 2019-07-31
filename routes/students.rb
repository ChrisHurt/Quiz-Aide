
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