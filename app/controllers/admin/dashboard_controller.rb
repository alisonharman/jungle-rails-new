class Admin::DashboardController < ApplicationController
  def show
    @productCount = Product.count
    @categoryCount = Category.count
  end
end
