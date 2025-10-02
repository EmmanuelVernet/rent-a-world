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

	def mark_all_read
		current_user.notifications.unread.update_all(read_at: Time.current)
		redirect_to notifications_path, notice: "All notifications marked as read."
	end

	def mark_all_unread
		current_user.notifications.read.update_all(read_at: nil)
		redirect_to notifications_path, notice: "All notifications marked as unread."
	end

	def counter
  	render json: { count: current_user.notifications.unread.count }
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
