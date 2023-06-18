class HomeController < ApplicationController
  include PaymentHelper
  def index
    @courses = Course.all
  end
end
