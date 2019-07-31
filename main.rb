require 'sinatra'
require 'sinatra/reloader'
require_relative 'database_config'

require_relative 'models/latin_question'
require_relative 'models/school_class'
require_relative 'models/student'
require_relative 'models/student_answer'
require_relative 'models/teacher'

require 'bcrypt'

enable :sessions

after do
  ActiveRecord::Base.connection.close
end

helpers do

  def loggedIn?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def user_exists?
    !!(User.find_by(id: session[:user_id]))
  end

end

# Home Page
get '/' do
  redirect '/login' unless session[:user_id]
  "placeholder text"
end

get '/home' do 
  if session[:user_type] = 'Teacher'
    erb :teacher_home
  elsif session[:user_type] = 'Student'
    erb :student_home
  end
end

require_relative 'routes/sessions'
require_relative 'routes/students' # Routes accessible by students
require_relative 'routes/teachers' # Routes accessible by teachers
