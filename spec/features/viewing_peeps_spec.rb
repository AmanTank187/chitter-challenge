feature 'Viewing peep' do
    scenario 'Visitng the index page' do 
        visit '/'
        expect(page).to have_content "Welcome to Chitter"
    end 
end 