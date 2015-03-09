require 'test_helper'

class Web::Admin::TicketCodesControllerTest < ActionController::TestCase
  setup do
    @distributor = create :distributor
    @user = create :admin
    sign_in @user
  end

  test "should get index" do
    get :index

    assert_response :success
  end

  test "should get new" do
    get :new

    assert_response :success
  end

  test "should post create" do
    params = {
      category: 'participant',
      kind: 'afterparty_ticket',
      count: 10,
      price: 1000,
      distributor_id: @distributor.id
    }
    count = TicketCode.count

    post :create, admin_ticket_code_create_type: params

    assert_response :redirect
    assert TicketCode.count - count == params[:count]
  end

  test "should delete destroy" do
    ticket_code = create :ticket_code

    delete :destroy, id: ticket_code.id

    assert !TicketCode.exists?(ticket_code.id)
    assert_response :redirect
  end

  test "should not delete if code activated" do
    ticket_code = create :ticket_code
    ticket_code.activate!

    delete :destroy, id: ticket_code.id

    assert TicketCode.exists?(ticket_code.id)
    assert_response :redirect
  end
end
