require 'database_connection'

describe DatabaseConnection do 
    describe '.setup' do
        it ' Sets up a connection to a database through PG' do
            expect(PG).to receive(:connect).with(dbname: 'chitter_app_test')

            DatabaseConnection.setup('chitter_app_test')
        end 

        it 'The connection is persistent' do
            initialconnection = DatabaseConnection.setup('chitter_app_test')

            expect(DatabaseConnection.connection).to eq initialconnection
        end 
    end 

    describe '.query' do
        it 'Executes a query via PG' do
            connection = DatabaseConnection.setup('chitter_app_test')
            expect(connection).to receive(:exec).with("SELECT * FROM peeps;")

            DatabaseConnection.query("SELECT * FROM peeps;")
        end 
    end 
end 