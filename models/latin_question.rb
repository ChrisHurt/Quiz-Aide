class LatinQuestion < ActiveRecord::Base
    belongs_to :teacher
    has_many :student_answers
end