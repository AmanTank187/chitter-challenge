feature 'Viewing peep' do
    scenario 'Visitng the index page' do 
        Peep.create(message: "hello")
        Peep.create(message: "Today is a sunny day")
        visit '/'
        expect(page).to have_content "hello"
        expect(page).to have_content "Today is a sunny "
    end 
end 