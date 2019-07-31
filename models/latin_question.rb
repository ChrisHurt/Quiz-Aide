class Latin_Question < ActiveRecord::Base
    belongs_to :teacher
    has_many :student_answer
end