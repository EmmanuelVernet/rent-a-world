RubberDuck.configure do |config|
	# Get your API key from https://platform.openai.com
	config.openai_api_key = ENV["OPENAI_API_KEY"]

	# Model to use
	config.model = "gpt-5-nano"

	# Enable/disable the helper
	config.enabled = true

	# Number of log lines to send to AI for context
	config.log_lines = 50
end
