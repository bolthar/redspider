
require 'rubygems'
require 'mechanize'
require 'dm-core'
require 'highline/import'


require File.dirname(__FILE__) + "/domain/mail_match.rb"
require File.dirname(__FILE__) + "/domain/professor.rb"
require File.dirname(__FILE__) + "/domain/affiliation.rb"
require File.dirname(__FILE__) + "/domain/query.rb"
require File.dirname(__FILE__) + "/services/mechanize_service.rb"
require File.dirname(__FILE__) + "/services/search_service.rb"
require File.dirname(__FILE__) + "/services/evaluator_service.rb"
require File.dirname(__FILE__) + "/services/csv_migrator_service.rb"

pass = ask("Enter password :") { |q| q.echo = false}
begin
  DataMapper.setup(:default, "mysql://root:#{pass}@localhost/redspider")
  DataMapper.auto_upgrade!
  prof = Professor.all.first
  p prof
  p prof.affiliation
rescue Exception
  print "wrong password!\n"
end

