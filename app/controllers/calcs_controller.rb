class CalcsController < ApplicationController
  include CalcsHelper

  def show
    @drinks = drinks
  end
  
end
