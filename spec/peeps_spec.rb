require 'peep'
require 'database_helpers'

describe Peep do
    describe '.all' do
      it 'Gets a list of peeps' do
        
      Peep.create(message: "Hello testy")
      peep = Peep.create(message: "Hello")
      
      peeps = Peep.all

      expect(peeps.length).to eq 2
      expect(peeps.first).to be_a Peep
      expect(peeps.first.id).to eq peep.id
      expect(peeps.first.message).to eq "Hello"
      end 
    end 
  
    describe '.create' do
        it 'creates a new peep' do
          peep = Peep.create(message: "Hello")
          persisted_data = persisted_data(table: "peeps",id: peep.id)
          expect(peep).to be_a Peep
          expect(peep.id).to eq persisted_data.first['id']
          expect(peep.message).to eq 'Hello'
        end
    end

end 