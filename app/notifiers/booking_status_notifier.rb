# To deliver this notification:
#
# BookingStatusNotifier.with(record: @post, message: "New post").deliver(User.all)

class BookingStatusNotifier < ApplicationNotifier
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message

  # Compute recipients without having to pass them in
  #
  # recipients do
  #   params[:record].thread.all_authors
  # end

  notification_methods do
    def message
      # :record is a default param coming from the gem. References Booking in this case
        "#{record.user.first_name} #{record.user.last_name} your booking request ##{record.id} for #{record.world.title} is #{record.status}."
    end
  end
  # Compute recipients without having to pass them in
  recipients do
    # params[:record].world.user
    record.user # booking requester
  end
end
