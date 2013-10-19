require 'test_helper'

class MusicSheetsControllerTest < ActionController::TestCase
  setup do
    @music_sheet = music_sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:music_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create music_sheet" do
    assert_difference('MusicSheet.count') do
      post :create, music_sheet: {  }
    end

    assert_redirected_to music_sheet_path(assigns(:music_sheet))
  end

  test "should show music_sheet" do
    get :show, id: @music_sheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @music_sheet
    assert_response :success
  end

  test "should update music_sheet" do
    patch :update, id: @music_sheet, music_sheet: {  }
    assert_redirected_to music_sheet_path(assigns(:music_sheet))
  end

  test "should destroy music_sheet" do
    assert_difference('MusicSheet.count', -1) do
      delete :destroy, id: @music_sheet
    end

    assert_redirected_to music_sheets_path
  end
end
