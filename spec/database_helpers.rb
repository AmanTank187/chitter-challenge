require "./lib/database_connection.rb"

def persisted_data(table:, id:)
    DatabaseConnection.query("SELECT * FROM #{table} WHERE id = #{id};")
end 