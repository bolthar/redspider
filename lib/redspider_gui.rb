
require 'rubygems'
require 'freightrain'
require 'dm-core'
require 'mechanize'

include Freightrain

Freightrain.app_path = File.dirname(__FILE__)

Freightrain.toolkit = :gtk
Freightrain.start(:shell) do
  DataMapper.setup(:default, "mysql://root:kaserngatan4@localhost/redspider")
  DataMapper.auto_upgrade!
end

