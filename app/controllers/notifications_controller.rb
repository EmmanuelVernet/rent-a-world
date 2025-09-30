class NotificationsController < ApplicationController
	before_action :set_notification, only: [:mark_as_read, :mark_as_unread, :destroy]

	def index
		@notifications = current_user.notifications.all
		raise
	end

	def mark_as_read
		@notification.mark_as_read!
		redirect_to request.path 
	end

	def mark_as_unread
		@notification.mark_as_unread!
		redirect_to request.path
	end

	def destroy
		if @notification.destroy!
			redirect_to notifications_path, notice: "Notification deleted!"
		else
			redirect_to notifications_path, notice: "Impossible to delete Notification!"
		end
	end

	private

	def set_notification
		@notification = Notification.find(params[:id])
	end
end
