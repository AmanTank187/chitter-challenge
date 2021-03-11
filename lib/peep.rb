require_relative 'database_connection'


class Peep 
    attr_reader :id, :message , :created_at, :user_id, :email

    def initialize(id:,message:,created_at:, user_id:, email:)
        @message = message
        @id = id
        @created_at = created_at
        @user_id = user_id
        @email = email
    end 

    def self.all
        result = DatabaseConnection.query("SELECT * FROM peeps JOIN users ON peeps.user_id = users.id")
        result.map do |peep|
          Peep.new(
            message: peep['message'],
            created_at: peep['created_at'],
            id: peep['id'],
            user_id: peep['user_id'],
            email: peep['email']
          )
        end
      end

    def self.create(user_id:, message:)
        result = DatabaseConnection.query("INSERT INTO peeps (user_id, message) VALUES('#{user_id}','#{message}') RETURNING id, message, created_at, user_id;")
        Peep.new(
          id: result[0]['id'], 
          message: result[0]['message'],
          created_at: result[0]['created_at'],
          user_id: result[0]['user_id'],
         )
     end
end