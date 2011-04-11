class ApplicationController < ActionController::Base
  protect_from_forgery
  include PrivatePub::ViewHelpers

  rescue_from ActiveRecord::RecordNotFound do
    render 'errors/404', :status => :not_found and return
  end
end
