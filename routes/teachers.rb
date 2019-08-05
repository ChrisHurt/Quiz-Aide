# Admin: View all teachers
get '/teachers' do
    redirect '/login' unless logged_in?
    if session[:user_type] != 'Administrator'
        erb :page_not_found
    else
        @teachers = Teacher.all
        erb :teachers
    end
end

# Admin: View form to create new a teacher
get '/teachers/new' do 
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Administrator'
    erb :add_teacher
end

# Admin: View a teachers' profile & allow updates
get '/teachers/:id' do
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Administrator'
    @teacher = Teacher.find_by(id: params[:id])
    erb :teacher
end
 
# Admin: Create a new teacher
post '/teachers' do
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Administrator'
    teacher = Teacher.new
    teacher.first_name = params[:first_name]
    teacher.middle_name = params[:middle_name]
    teacher.last_name = params[:last_name]
    teacher.email = params[:email]
    teacher.password = params[:password]
    teacher.save
    redirect '/teachers'
end

# Admin: Update a teacher
put '/teachers/:id' do
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Administrator'
    teacher = Teacher.find_by(id: params[:id])
    teacher.first_name = params[:first_name]
    teacher.middle_name = params[:middle_name]
    teacher.last_name = params[:last_name]
    teacher.email = params[:email]
    if !(params[:password] == nil || params[:password] == "")
        teacher.password = params[:password]
    end
    teacher.save
    redirect '/teachers'
end

# Admin: Delete a teachers profile
delete '/teachers/:id' do
    redirect '/login' unless logged_in?
    erb :page_not_found unless session[:user_type] == 'Administrator'
    teacher = Teacher.find_by(id: params[:id])
    teacher.delete
    redirect '/teachers'
end