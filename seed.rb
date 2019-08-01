require  'pry'
require_relative 'database_config'
require 'bcrypt'
require_relative 'models/latin_question'
require_relative 'models/school_class'
require_relative 'models/student'
require_relative 'models/student_answer'
require_relative 'models/teacher'

first_names = ['Carla','Chris','John', "Sally", 'Sven', 'Georgia']
middle_names = ['William', "Sally", 'Sven', 'Elizabeth']
last_names = ['Hurt','Schodde','Herald', "Simmons", 'James', 'Smith']


4.times do |index|
    t = Teacher.new
    t.first_name = first_names.sample + index.to_s
    t.middle_name = middle_names.sample + index.to_s
    t.last_name = last_names.sample + index.to_s
    t.user_name = 't' + index.to_s
    t.email = 't' + index.to_s
    t.password  = 't' + index.to_s
    t.save
    puts "Teacher Added: " + t.first_name
    q = LatinQuestion.new
    10.times do |index4|
        q = LatinQuestion.new
        q.body = "#{index4 + index} * #{index4 - index + 2}"
        q.answer_key = "#{(index4 + index) * (index4 - index + 2)}"
        q.teacher_id = t.id
        q.assessment_type = 'Maths'
        q.save
        puts "  Question Added: " + q.body
    end
    2.times do |index2|
        sc = SchoolClass.new
        sc.year = index2 + 1
        sc.class_letter = (65 + rand(26)).chr
        sc.teacher_id = t.id
        sc.save
        15.times do |index3|
            s = Student.new
            s.school_class_id = sc.id
            s.first_name = first_names.sample + index3.to_s
            s.middle_name = middle_names.sample + index3.to_s
            s.last_name = last_names.sample + index3.to_s
            s.user_name = 's' + index3.to_s
            s.email = 's' + index3.to_s
            s.password  = 's' + index3.to_s
            s.save
            puts "    Student Added: " + s.first_name
            2.times do |index5|
                a = StudentAnswer.new
                a.student_id = s.id
                a.latin_question_id = q.id
                a.answer = ((index5+1) * (index+1)).to_s
                a.reviewed = false
                a.outcome = 'Unsure'
                a.save
                puts "       Question Answered: " + a.answer
            end
        end
        puts "  School Class Added: " + sc.year.to_s + sc.class_letter
    end
end

binding.pry