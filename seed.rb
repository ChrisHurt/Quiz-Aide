# require  'pry'
require_relative 'database_config'
require 'bcrypt'
require_relative 'models/latin_question'
require_relative 'models/school_class'
require_relative 'models/student'
require_relative 'models/student_answer'
require_relative 'models/teacher'
require_relative 'models/administrator'

first_names = ['Carla','Chris','John', "Sally", 'Sven', 'Georgia']
middle_names = ['William', "Sally", 'Sven', 'Elizabeth']
last_names = ['Hurt','Schodde','Herald', "Simmons", 'James', 'Smith']

a = Administrator.new
a.first_name = first_names.sample
a.middle_name = middle_names.sample
a.last_name = last_names.sample
a.user_name = (a.first_name[0] + a.last_name[0..2]).downcase
a.email = 'a'
a.password = 'a'
a.save

4.times do |index|
    attempts = 0
    t = Teacher.new
    t.first_name = first_names.sample
    t.middle_name = middle_names.sample
    t.last_name = last_names.sample
    t.user_name = (t.first_name[0] + t.last_name[0..2]).downcase
    while (Teacher.where(user_name: t.user_name).length > 0 || Student.where(user_name: t.user_name).length > 0 || Administrator.where(user_name: t.user_name).length > 0) && attempts < 10 
        t.user_name += rand(0..9).to_s
        attempts += 1
    end
    if attempts < 10
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
                s.first_name = first_names.sample
                s.middle_name = middle_names.sample
                s.last_name = last_names.sample
                s.user_name = (s.first_name[0] + s.last_name[0..2]).downcase
                attempts = 0
                while (Teacher.where(user_name: s.user_name).length > 0 || Student.where(user_name: s.user_name).length > 0 || Administrator.where(user_name: s.user_name).length > 0) && attempts < 10 
                    s.user_name += rand(0..9).to_s
                    attempts += 1
                end
                if attempts < 10
                    s.email = 's' + index3.to_s
                    s.password  = 's'  + index3.to_s
                    s.save
                    puts "    Student Added: " + s.first_name
                    20.times do |index5|
                        a = StudentAnswer.new
                        a.student_id = s.id
                        a.latin_question_id = q.id
                        a.answer = ((index5+1) * (index+1)).to_s
                        case rand(1..2)
                        when 1
                            a.reviewed = true
                        when 2
                            a.reviewed = false
                        else 
                            a.reviewed = true
                        end
                        case rand(1..3)
                        when 1
                            a.outcome = 'Unsure'
                        when 2
                            a.outcome = 'Correct'
                        when 3
                            a.outcome = 'Incorrect'
                        else 
                            a.outcome = 'Unsure'
                        end
                        a.save
                        puts "       Question Answered: " + a.answer
                    end
                end
            end
            puts "  School Class Added: " + sc.year.to_s + sc.class_letter
        end
    end
end

# binding.pry