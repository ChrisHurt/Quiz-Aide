require 'sinatra'
require 'sinatra/reloader'
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

  def loggedIn?
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
  redirect '/login' unless session[:user_id]
  "placeholder text"
end

get '/home' do 
  if session[:user_type] == 'Teacher'
    @teacher = current_user
    erb :teacher_home
  elsif session[:user_type] == 'Student'
    @student = current_user
    erb :student_home
  end
end

require_relative 'routes/sessions'
require_relative 'routes/questions'

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

# Teacher's home page
get '/teachers/home' do
  # @teacher - once you have a teacher database
  # After authentication, consolidate the home page
  erb :teacher_home
end

require_relative 'routes/students'
require_relative 'routes/classes'





