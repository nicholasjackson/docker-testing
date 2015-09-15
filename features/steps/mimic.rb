require 'rest_client'

Given(/^Mimic is configured with specification$/) do |specification|
  RestClient.send("post", "#{$MIMIC_SERVER_URI}/api/multi", "#{specification}") do |response, request|
    puts "#{response.body}"
  end
end
