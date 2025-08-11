require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "div.bg-primary-subtle", count: 10
  end

  test "should test written word" do
    visit new_url

    fill_in "word", with: "Hello"
    click_on "play"

    assert_text "Word not matches given letters"
  end

  test "should check if word is not a valid english word" do
    visit new_url

    fill_in "word", with: "adsdsadsa"
    click_on "play"

    assert_text "Word not found"
  end

  test "should check if word is ok" do
    visit new_url

    fill_in "word", with: "B"
    click_on "play"

    assert_text "Congratulation!"
  end
end
