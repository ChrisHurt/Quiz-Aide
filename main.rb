require 'sinatra'
# require 'sinatra/reloader'
require_relative 'database_config'

require_relative 'models/latin_question'
require_relative 'models/school_class'
require_relative 'models/student'
require_relative 'models/student_answer'
require_relative 'models/teacher'
require 'pry'
require 'bcrypt'

enable :sessions

after do
  ActiveRecord::Base.connection.close
end

helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    if session[:user_id] != nil && session[:user_type] != nil
      case session[:user_type]
      when 'Administrator'
        # Administrator.find_by(session[:user_id])
      when 'Teacher'
        return Teacher.find_by(id: session[:user_id])
      when 'Student'
        return Student.find_by(id: session[:user_id])
      end
    else
      nil
    end
  end

end

# Home Page
get '/' do
  redirect '/home' unless logged_in?
  redirect '/login'
end

get '/home' do 
  if logged_in? && session[:user_type] == 'Teacher'
    @teacher = current_user
    erb :teacher_home
  elsif session[:user_type] == 'Student'
    @student = current_user
    erb :student_home
  else
    redirect '/login'
  end
end

require_relative 'routes/sessions'
require_relative 'routes/questions'
require_relative 'routes/students'
require_relative 'routes/classes'
require_relative 'routes/answers'
require_relative 'routes/metrics'

get '/:route_not_found' do
  erb :page_not_found
end
