# Admin|Teacher: All Student Records
get '/students' do 
  redirect '/login' unless logged_in?
  case session[:user_type]
  when 'Teacher', 'Administrator'
    @students = Student.all
    erb :students
  else
    erb :page_not_found
  end

end

# Admin: New Student Record
get '/students/new' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  erb :add_student
end

# Admin|Teacher: Individual Student Record
get '/students/:id' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @student = Student.find(params[:id])
  erb :student
end
    
# Admin: Creating a New Student
post '/students' do 
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  student = Student.new
  student.first_name = params[:first_name]
  student.middle_name = params[:middle_name]
  student.last_name = params[:last_name]
  student.school_class_id = params[:school_class_id]
  student.email = params[:email]
  student.password = params[:password]
  student.save
  
  redirect '/students'
end
    
# Admin: Updating a Student Record
put '/students/:id' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  student = Student.find(params[:id])
  student.first_name = params[:first_name]
  student.middle_name = params[:middle_name]
  student.last_name = params[:last_name]
  student.school_class_id = params[:school_class_id]
  student.email = params[:email]
  if !(params[:password] == nil || params[:password] == "")
    student.password = params[:password]
  end
  student.save
  redirect '/students'
end
    
# Admin: Deleting a Student Record
delete '/students/:id' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  student = Student.find(params[:id])
  student.delete
  redirect '/students'
end

# Admin|Teacher: List of students by class
get '/classes/:id/students' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @students = Student.where(school_class_id: params[:id])
  erb :students
end