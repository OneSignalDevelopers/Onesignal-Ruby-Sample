require 'dotenv/load'
require 'time'
require 'onesignal'

rest_api_key = ENV['ONESIGNAL_REST_API_KEY']
app_id = ENV['ONESIGNAL_APP_ID']

# setup authorization
OneSignal.configure do |config|
  # Configure Bearer authorization: app_key
  config.app_key = rest_api_key
end

api_instance = OneSignal::DefaultApi.new

begin
  # Create notification
  notification = OneSignal::Notification.new({ app_id: app_id })
  notification.contents = OneSignal::StringMap.new({ "en": 'English Message' })
  notification.is_chrome_web = true
  notification.is_any_web = true
  notification.included_segments = ['Subscribed Users']
  p notification

  # Submit notification to API
  notification_response = api_instance.create_notification(notification)
  notification_id = notification_response.id
  p notification_response
rescue OneSignal::ApiError => e
  puts "Error when calling DefaultApi->create_notification: #{e}"
end
