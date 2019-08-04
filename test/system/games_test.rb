require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the new page" do
    visit new_url

    assert_selector "h1", text: "Game"
  end


   test "Trying to enter a word" do
    visit new_url
    fill_in "user_letters", with: "Hello"
    click_on "play"

    assert_text "Congratulations, Hello is a valid english word"
  end
end
