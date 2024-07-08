class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find(params[:id])

    @game.update(status: true)

    @users = @game.users
    @set_dials = @game.set_dials
    @answer = SetDial.find_by(game: @game)
    @answers = SetDial.where(game: @game)
    @user = current_user
    @group = @game.group
    @message = Message.new
    @my_set_dial = @user.set_dials.order(created_at: :desc).last
  end


  def create
    @game = Game.find_by(group_id: params[:group_id])
    if @game
      @game.update(topic_id: params[:topic_id])
      redirect_to @game, allow_other_host: true, notice: "topic changed"
    else
      @game = Game.new(group_id: params[:group_id], topic_id: params[:topic_id])
      if @game.save
        # redirect_to new_topic_set_dial_path(params[:topic_id])
        redirect_to @game, allow_other_host: true
      else
        flash[:alert] = "Failed to create game"
        redirect_to @game, allow_other_host: true
      end
    end
  end

end
