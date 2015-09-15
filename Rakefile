require 'docker'
require_relative 'rake-modules/docker'

def get_docker_ip_address
	if !ENV['DOCKER_HOST']
		return "127.0.0.1"
	else
		# dockerhost set
		host = ENV['DOCKER_HOST'].dup
		host.gsub!(/tcp:\/\//, '')
		host.gsub!(/:2376/,'')

		return host
	end
end

task :e2e do
	feature = ARGV.last
	if feature != "e2e"
		feature = "--tags #{feature}"
	else
		feature = ""
	end

	host = get_docker_ip_address

	puts "Running Tests for #{host}"

	ENV['WEB_SERVER_URI'] = "http://#{host}:8001"
	ENV['MIMIC_SERVER_URI'] = "http://#{host}:11988"
	ENV['EMAIL_SERVER_URI'] = "http://#{host}:1080"

	begin
		pid = Process.fork do
	    exec 'docker-compose -f ./dockercompose/spot-gps-cache/docker-compose.yml up > serverlog.txt'
		end

		sleep 5

		sh "cucumber #{feature}"
	ensure
		# remove stop running application
		sh 'docker-compose -f ./dockercompose/spot-gps-cache/docker-compose.yml stop'
		# remove stopped containers
		sh 'echo y | docker-compose -f ./dockercompose/spot-gps-cache/docker-compose.yml rm'
	end
end
