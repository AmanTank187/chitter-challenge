require 'peep'
require 'database_helpers'

describe Peep do
    describe '.all' do
      it 'Gets a list of peeps' do
      user = User.create(email: 'test@example.com', password: 'password123')
      peep = Peep.create(user_id: user.id, message: "Hello")
      Peep.create(user_id: user.id, message: "Hello testy")
      
      
      peeps = Peep.all

      expect(peeps.length).to eq 2
      expect(peeps.first).to be_a Peep
      expect(peeps.first.id).to eq peep.id
      expect(peeps.first.message).to eq "Hello"
      end 
    end 
  
    describe '.create' do
        it 'creates a new peep' do
          user = User.create(email: 'test@example.com', password: 'password123')
          peep = Peep.create(user_id: user.id, message: "Hello")
          persisted_data = persisted_data(table: "peeps",id: peep.id)
          expect(peep).to be_a Peep
          expect(peep.id).to eq persisted_data.first['id']
          expect(peep.message).to eq 'Hello'
        end
    end

    describe '.where' do
      it ' Gets the relevant peeps from the database' do 
        user = User.create(email: 'test@example.com', password: 'password123')
        peep = Peep.create(user_id: user.id, message: "Hello")
        peep = Peep.create(user_id: user.id, message: "Yo yo yo")
    
        peeps = Peep.where(user_id: user.id)
        peep = peeps.first
        persisted_data = persisted_data(table: 'peeps', id: peep.id)
    
        expect(peeps.length).to eq 2
        expect(peep.id).to eq persisted_data.first['id']
        expect(peep.message).to eq 'Hello'
        expect(peep.user_id).to eq user.id
      end
    end 

end 