class DialGuessesController < ApplicationController

  def new
    @dial_guess = DialGuess.new
    @user = current_user
    @set_dial = SetDial.find(params[:set_dial_id])
    @setter = @set_dial.user.name
    @topic = @set_dial.dial.topic
    @setter_word = @set_dial.setter_word
    @left = @set_dial.dial.left
    @right = @set_dial.dial.right
  end

  def create
    @user = current_user
    @set_dial = SetDial.find(params[:set_dial_id])
    @dial_guess = DialGuess.new(dial_guess_params)
    @dial_guess.user = @user
    @dial_guess.set_dial = @set_dial
    @game = @set_dial.game
    @dial_guess.points = calculate_points
    @dial_guess.save
    redirect_to game_path(@game)
  end


  private

  def dial_guess_params
    params.require(:dial_guess).permit(:guessed_value, :points)
  end


  def calculate_points
    @guessed_value = @dial_guess.guessed_value
    @setter_value = @set_dial.setter_value
    @guessed_value - @setter_value
  end


end
