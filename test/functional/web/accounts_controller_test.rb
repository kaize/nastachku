require 'test_helper'

class Web::AccountsControllerTest < ActionController::TestCase
  setup do
    @user = create :user
    sign_in @user
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should update user" do
    attrs = attributes_for :user
    attrs.delete(:password)
    attrs[:show_as_participant] = 1

    put :update, id: @user.id, user: attrs

    @user.reload
    assert_response :redirect
    assert @user.position == attrs[:position]
    assert @user.show_as_participant
    assert @user.email == attrs[:email]
  end

  test "should update password" do
    old_password_digest = @user.password_digest
    attrs = { old_password: "ashQDR123!@#", password: "123456", password_confirmation: "123456" }

    put :update, id: @user.id, user: attrs

    @user.reload
    assert old_password_digest != @user.password_digest
    assert @user.try(:authenticate, attrs[:password])
  end

end
