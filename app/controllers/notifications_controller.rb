class NotificationsController < ApplicationController
	before_action :set_notification, only: [:mark_as_read]

	def mark_as_read
		@notification.mark_as_read!
		redirect_to request.path 
	end

	def mark_as_unread
		@notification.mark_as_unread!
	end

	private

	def set_notification
		@notification = Notification.find(params[:id])
	end
end
