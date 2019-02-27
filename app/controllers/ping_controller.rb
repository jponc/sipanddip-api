class PingController < ApplicationController
  def index
    render json: { status: 'OK1' }
  end
end
