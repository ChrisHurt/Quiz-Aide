class Teacher < ActiveRecord::Base
    has_secure_password
    has_many :school_classes #school_classes
    has_many :latin_questions
end
