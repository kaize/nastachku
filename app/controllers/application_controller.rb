class ApplicationController < ActionController::Base
  include AuthHelper
  include Mobylette::RespondToMobileRequests

  helper_method :current_user, :signed_in?, :signed_as_admin?

  before_filter :deny_banned_user!

  unless (Rails.env.development?)
    rescue_from ActionController::RoutingError, ActionView::MissingTemplate, ActiveRecord::RecordNotFound do |exception|
      redirect_to "/404"
    end
  end
end

