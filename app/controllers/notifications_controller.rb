class NotificationsController < ApplicationController
  def index
    @activities = PublicActivity::Activity.where(trackable_type: "Like", key: "like.create", recipient: current_user)
  end


end
