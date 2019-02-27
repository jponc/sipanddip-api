class PingController < ApplicationController
  def index
    render json: { status: 'Hello World' }
  end
end
