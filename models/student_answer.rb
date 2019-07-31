class Student_Answer < ActiveRecord::Base
    belongs_to :student
    belongs_to :latin_question
end