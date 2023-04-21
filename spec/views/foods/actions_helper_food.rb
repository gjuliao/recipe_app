module ActionsHelperFood
  def sign_up
    visit new_user_registration_path
    fill_in 'user_name', with: 'John', id: 'user_name'
    fill_in 'user_email', with: 'John@gmail.com', id: 'user_email'
    fill_in 'user_password', with: '123456', id: 'user_password'
    fill_in 'user_password_confirmation', with: '123456', id: 'user_password_confirmation'
    click_button 'Sign up'
  end

  def sign_in
    visit new_user_session_path
    fill_in 'user_email', with: 'John@gmail.com', id: 'user_email'
    fill_in 'user_password', with: '123456', id: 'user_password'
    click_button 'Log in'
  end

  def add_food
    visit new_food_path
    fill_in 'food_name', with: 'Eggs', id: 'food_name'
    fill_in 'food_measurement_unit', with: 'grams', id: 'food_measurement_unit'
    fill_in 'food_price', with: '10', id: 'food_price'
    fill_in 'food_quantity', with: '10', id: 'food_quantity'
    click_button 'Create Food'
  end

  def accept_alert
    alert = page.driver.browser.switch_to.alert
    alert.accept
  end
end
