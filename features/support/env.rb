require 'cucumber/rest_api'
require 'cucumber/mailcatcher'

$SERVER_PATH = ENV['WEB_SERVER_URI']
$MIMIC_SERVER_URI = ENV['MIMIC_SERVER_URI']
$EMAIL_SERVER_URI = ENV['EMAIL_SERVER_URI']

Cucumber::Mailcatcher::HttpClient.server_url = $EMAIL_SERVER_URI
