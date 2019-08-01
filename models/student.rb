class Student < ActiveRecord::Base
    has_secure_password
    has_many :student_answers
    belongs_to :school_class
end