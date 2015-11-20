class Api::OrdersController < ApplicationController

  before_action :check_key

  def index
    today = Date.today
    @orders = Order.where(created_at: today..(today + 1.day))
  end

  private

  def check_key
    render json: {
      error: 'Unauthorized, check the key',
      status: 401
    }, status: :unauthorized unless Rails.application.secrets.orders_api_key == params[:key]
  end

end
