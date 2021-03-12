feature 'Viewing peep' do
    scenario 'Visitng the index page' do 
        user = User.create(email: 'test@example.com', password: 'password123')
        Peep.create(user_id: user.id, message: "hello")
        Peep.create(user_id: user.id, message: "Today is a sunny day")
        visit '/sessions/new?'
        fill_in('email', with: 'test@example.com')
        fill_in('password', with: 'password123')
        click_button('Sign in')
        visit '/'
        expect(page).to have_content "hello"
        expect(page).to have_content "Today is a sunny "
    end 
end 