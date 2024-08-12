class NotificationsController < ApplicationController
  def index
    like_activities = PublicActivity::Activity.where(trackable_type: 'Like', key: 'like.create', recipient: current_user)
    comment_activities = PublicActivity::Activity.where(trackable_type: 'Comment', key: 'comment.create', recipient: current_user)
    @activities = like_activities.or(comment_activities)
  end
end
