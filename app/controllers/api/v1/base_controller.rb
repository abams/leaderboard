class Api::V1::BaseController < ApplicationController
  include Api::V1::UsersHelper
  include Api::V1::RackHelper

  protect_from_forgery with: :null_session
  before_filter :require_user
end
