class Web::AccountsController < Web::ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = AccountEditType.find current_user.id
    @order = Order.new
  end

  def update
    @user = AccountEditType.find current_user.id
    @order = Order.new

    @user.changed_by = current_user
    if @user.update_attributes params[:user]
      flash_success
      redirect_to edit_account_path
    else
      render :edit
    end
  end

end
