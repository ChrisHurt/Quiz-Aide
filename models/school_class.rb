class SchoolClass < ActiveRecord::Base # Change to SchoolClass
    has_many :students   # plural
    belongs_to :teacher # singular
end