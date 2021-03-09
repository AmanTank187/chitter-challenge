feature 'Adding a peep' do
    scenario 'Adding a your own peep then being able to view it' do 
        visit ('/peeps/new')
        fill_in('message', :with => "Today is a sunny day")
        click_button('Submit')
        expect(page).to have_content "Today is a sunny day"
    end 
end 