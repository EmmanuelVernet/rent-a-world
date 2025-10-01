class PagesController < ApplicationController
  # before_action :set_notifications, only: [:home]
  def home
    @worlds = World.includes(:user, :tags)
  end

  private

  # def set_notifications
  #   @notifications = current_user.notifications.includes(:event)
  # end
end
