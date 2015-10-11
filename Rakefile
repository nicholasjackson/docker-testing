require 'consul/client'

def setConsulVariables host, port

  puts "Setting key values for server: #{host}:#{port}"

  kvs = Consul::Client::KeyValue.new :api_host => host, :api_port => port, :logger => Logger.new("/dev/null")

  kvs.put('api/mail/HelloWorldServer/server','helloworldserver')
  kvs.put('api/mail/HelloWorldServer/port','11988')

  kvs.put('api/mail/SMTPServer/server','mailserver')
  kvs.put('api/mail/SMTPServer/port','1025')
  kvs.put('api/mail/SMTPServer/user','')
  kvs.put('api/mail/SMTPServer/password','')
  kvs.put('api/mail/SMTPServer/auth',false)
end

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

def self.wait_until_server_running server
    begin
      response = RestClient.send("get", "#{server}/health")
    rescue

    end

    if response == nil || !response.to_str.include?('OK')
      puts "Waiting for server to start"
      sleep 1
      self.wait_until_server_running server
    end
  end

task :run do
	host = get_docker_ip_address

	begin
	  p `docker-compose -f ./dockercompose/docker-testing/docker-compose.yml up`
    sleep 2
		setConsulVariables host, 8500
		Process.wait pid
	rescue SystemExit, Interrupt
		p 'Shutting down application'
	ensure
		p `docker-compose -f ./dockercompose/docker-testing/docker-compose.yml stop`
		# remove stopped containers
		p `echo y | docker-compose -f ./dockercompose/docker-testing/docker-compose.yml rm`
	end
end

task :e2e do
	host = get_docker_ip_address

	puts "Running Tests for #{host}"

	ENV['WEB_SERVER_URI'] = "http://#{host}:8001"
	ENV['MIMIC_SERVER_URI'] = "http://#{host}:11988"
	ENV['EMAIL_SERVER_URI'] = "http://#{host}:1080"

	feature = ARGV.last
	if feature != "e2e"
		feature = "--tags #{feature}"
	else
		feature = ""
	end

	puts "Running Tests"
	begin
	  puts `exec docker-compose -f ./dockercompose/docker-testing/docker-compose.yml up -d`
    sleep 2
		setConsulVariables host, 8500
		self.wait_until_server_running ENV['WEB_SERVER_URI']

		p 'Running Tests'
		puts `cucumber --color #{feature}`
	ensure
    p 'Stopping Application'
		# remove stop running application
		puts `docker-compose -f ./dockercompose/docker-testing/docker-compose.yml stop`
		# remove stopped containers
		puts `echo y | docker-compose -f ./dockercompose/docker-testing/docker-compose.yml rm`
	end
end
