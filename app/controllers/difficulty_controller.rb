class DifficultyController < ApplicationController
  def get
    render json: Difficulty.all, status: :ok
  end
end
