class PlayerController < ApplicationController
  before_action :restrict_access, only: %i[test]
    def create
        player = Player.create(name: params[:name], email: params[:email], password: params[:password],
                           password_confirmation: params[:password_confirmation])
        if player.valid?
          player.save
          render json: player.as_json(only: %i[id email name]), status: :created
        else
          render json: user.errors.messages, status: :conflict
        end
    end

    def test
        query = ActiveRecord::Base.sanitize_sql_array(["select * from players where name=? and email=?", params[:name], params[:email]])
        top_questions = ActiveRecord::Base.connection.execute(query)
        render json: top_questions, status: :ok
    end
end
