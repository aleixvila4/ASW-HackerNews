require 'test_helper'

class UsuarisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usuari = usuaris(:one)
  end

  test "should get index" do
    get usuaris_url
    assert_response :success
  end

  test "should get new" do
    get new_usuari_url
    assert_response :success
  end

  test "should create usuari" do
    assert_difference('Usuari.count') do
      post usuaris_url, params: { usuari: {  } }
    end

    assert_redirected_to usuari_url(Usuari.last)
  end

  test "should show usuari" do
    get usuari_url(@usuari)
    assert_response :success
  end

  test "should get edit" do
    get edit_usuari_url(@usuari)
    assert_response :success
  end

  test "should update usuari" do
    patch usuari_url(@usuari), params: { usuari: {  } }
    assert_redirected_to usuari_url(@usuari)
  end

  test "should destroy usuari" do
    assert_difference('Usuari.count', -1) do
      delete usuari_url(@usuari)
    end

    assert_redirected_to usuaris_url
  end
end
