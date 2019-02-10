class PingController < ApplicationController
  def index
    render json: { status: 'Status OK' }
  end
end
