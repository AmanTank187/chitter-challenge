require_relative 'database_connection'
require 'time'
class Peep 
    attr_reader :id, :message , :created_at

    def initialize(id:,message:,created_at:)
        @message = message
        @id = id
        @created_at = created_at
    end 

    def self.all
        result = DatabaseConnection.query("SELECT * FROM peeps ORDER BY id DESC;")
        result.map do |peep|
          Peep.new(
            message: peep['message'],
            created_at: peep['created_at'],
            id: peep['id']
          )
        end
      end

    def self.create(message:)
        result = DatabaseConnection.query("INSERT INTO peeps (message) VALUES('#{message}') RETURNING id, message, created_at")
        Peep.new(
          id: result[0]['id'], 
          message: result[0]['message'],
          created_at: result[0]['created_at'],
         )
     end 

     
end