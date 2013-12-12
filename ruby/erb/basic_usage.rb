#!/usr/bin/env ruby
#
#   How to use ERB Ruby templating
require 'json'
require 'erb'

ships       = JSON.parse    File.read('data.json') 
template    = ERB.new       File.read('test.erb')

ships.each do |ship|
    puts template.result(binding)
end
