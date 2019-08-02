# Admin|Teacher:  View Teacher Class Options
get '/classes' do 
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  erb :teacher_classes
end

# Admin|Teacher:  View All Class Records
get '/teachers/classes' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @classes = SchoolClass.all
  erb :classes
end

# Admin|Teacher:  View A Single Class Record
get '/teachers/:id/classes' do 
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @classes = SchoolClass.where(teacher_id: params[:id])
  erb :classes
end

# Admin: View New Class Page
get '/classes/new' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  erb :add_class
end
    
# Admin|Teacher: Individual Class Record
get '/classes/:id' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Teacher' || session[:user_type] == 'Administrator'
  @class = SchoolClass.find(params[:id])
  erb :class
end
    
# Admin: Creating a New Class
post '/classes' do 
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  school_class = SchoolClass.new
  school_class.year = params[:year]
  school_class.class_letter = params[:class_letter]
  school_class.teacher_id = params[:teacher_id]
  school_class.save
  
  redirect '/classes'
end
  
# Admin: Updating a Class Record
put '/classes/:id' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  school_class = SchoolClass.find(params[:id])
  school_class.year = params[:year]
  school_class.class_letter = params[:class_letter]
  school_class.teacher_id = params[:teacher_id]
  school_class.save
  redirect '/classes'
end
  
# Admin: Deleting a Class Record
delete '/classes/:id' do
  redirect '/login' unless logged_in?
  erb :page_not_found unless session[:user_type] == 'Administrator'
  school_class = SchoolClass.find(params[:id])
  school_class.delete
  redirect '/classes'
end
  