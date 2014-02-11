class Api::V1::BaseController < ApplicationController
  include Api::V1::UsersHelper
  include Api::V1::RackHelper

  before_filter :require_user
end
