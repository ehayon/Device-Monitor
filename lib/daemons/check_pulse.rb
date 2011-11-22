#!/usr/bin/env ruby

require "pulse_script"

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

$running = true
Signal.trap("TERM") do 
  $running = false
end

while($running) do
  
  @devices = Device.to_be_checked
  if @devices
    requests = []
    @devices.each do |device|
      requests << device
    end
    check_pulse requests
  end
  sleep 10
  
end

