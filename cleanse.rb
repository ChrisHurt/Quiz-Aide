require 'active_record'
require_relative 'database_config'
require_relative 'models/latin_question'
require_relative 'models/school_class'
require_relative 'models/student'
require_relative 'models/student_answer'
require_relative 'models/teacher'

Teacher.destroy_all
Student.destroy_all
StudentAnswer.destroy_all
SchoolClass.destroy_all
LatinQuestion.destroy_all
