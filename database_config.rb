require 'active_record'

options  = {
    adapter: 'postgresql',
    database: 'latin_qa'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)