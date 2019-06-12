class CalcController < ApplicationController
  include CalcHelper

  def show
    @drinks = drinks
  end
  
end
