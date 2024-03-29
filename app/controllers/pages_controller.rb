class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @group_subscription = GroupSubscription.new
    @groups = current_user.groups if current_user
    @group = Group.new
    @game = Game.new
    @topics = Topic.all
    @user = current_user
  end
end
