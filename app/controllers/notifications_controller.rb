class NotificationsController < ApplicationController
	before_action :set_notification, only: [:mark_as_read, :mark_as_unread, :destroy]

	def index
		@notifications = current_user.notifications.includes(event: { record: [:user, :world] })
	end

	def mark_as_read
		@notification.mark_as_read!
		redirect_to notifications_path, notice: "Notification marked as read."
	end

	def mark_as_unread
		@notification.mark_as_unread!
		redirect_to notifications_path, notice: "Notification marked as unread."
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
		@notification = Noticed::Notification.find(params[:id])
	end
end
