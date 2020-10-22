require "application_system_test_case"

class UsuarisTest < ApplicationSystemTestCase
  setup do
    @usuari = usuaris(:one)
  end

  test "visiting the index" do
    visit usuaris_url
    assert_selector "h1", text: "Usuaris"
  end

  test "creating a Usuari" do
    visit usuaris_url
    click_on "New Usuari"

    click_on "Create Usuari"

    assert_text "Usuari was successfully created"
    click_on "Back"
  end

  test "updating a Usuari" do
    visit usuaris_url
    click_on "Edit", match: :first

    click_on "Update Usuari"

    assert_text "Usuari was successfully updated"
    click_on "Back"
  end

  test "destroying a Usuari" do
    visit usuaris_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Usuari was successfully destroyed"
  end
end
