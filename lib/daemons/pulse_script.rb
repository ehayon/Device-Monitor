require 'curb'

def check_pulse(requests)
  queue = []
  failures = []
  
  while requests.length > 0                         # are there any remaining requests to process?
   
    puts "#{ requests.length } requests remaining"
   
    if requests.length > 50                         # we can't process this many at once
      queue = requests.pop 50                       # break up the requests into a smaller queue
    else
      queue = requests.pop requests.length
    end
   
    m = Curl::Multi.new                             # create a curl-multi object
   
    queue.each do |item|
      url = "http://#{item.ip}:#{item.port}"
      c = Curl::Easy.new(url) do|curl|
        curl.follow_location = true
        # curl.username = "user"
        # curl.password = "pass"
        curl.timeout = 5
        curl.on_success {|easy| success(easy, item.id); }
        curl.on_failure {|easy| failure(easy, item.id); failures << item }
      end
      m.add(c)                                      # add curl-easy objects to the multi handle
    end
    m.perform
  end
  
  # retry the failed devices - curl may give inconsistent results
  
  t = Curl::Multi.new                         
  failures.each do |item|
    url = "http://#{item.ip}:#{item.port}"
    c = Curl::Easy.new(url) do |curl|
      # curl.username = "user"
      # curl.password = "pass"
      curl.timeout = 15
      curl.on_success { |easy| retry_success(easy, item.id); }
      curl.on_failure { |easy| retry_failure(easy, item.id); }
    end
    t.add(c)
  end
  t.perform

end
def success(easy,id)
  puts "Success: #{easy.url} #{easy.response_code}"
  @device = Device.find(id)
  @device.update_attributes(:last_checked => Time.now, :last_state => true)
  @device.increment! :times_up
  @device.save
end
def failure(easy,id)
  puts "Failure: #{easy.url} #{easy.response_code}"
end
def retry_failure(easy,id)
  puts "Retry Failure #{easy.url} #{easy.response_code}"
  @device = Device.find(id)
  @device.update_attributes(:last_checked => Time.now, :last_state => false)
  @device.increment! :times_down
  @device.save
end
def retry_success(easy,id)
  puts "Retry Success #{easy.url} #{easy.response_code}"
  @device = Device.find(id)
  @device.update_attributes(:last_checked => Time.now, :last_state => true)
  @device.increment! :times_up
  @device.save
end

