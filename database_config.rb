require 'active_record'

options  = {
    adapter: 'postgresql',
    database: 'latin_qa'
}

ActiveRecord::Base.establish_connection(options)