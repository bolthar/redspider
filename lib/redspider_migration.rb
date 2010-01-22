
require 'rubygems'
require 'mechanize'
require 'dm-core'
require 'highline/import'

require File.dirname(__FILE__) + "/domain/mail_match.rb"
require File.dirname(__FILE__) + "/domain/professor.rb"
require File.dirname(__FILE__) + "/domain/affiliation.rb"
require File.dirname(__FILE__) + "/domain/query.rb"
require File.dirname(__FILE__) + "/services/csv_migrator_service.rb"

pass = ask("Enter mysql password :") { |q| q.echo = false}
begin
  DataMapper.setup(:default, "mysql://andrea:#{pass}@db3/andrea")
  DataMapper.auto_upgrade!
rescue Exception => ex
  print "wrong password!\n" 
  print ex.message + "\n"
  exit
end

migrator = CsvMigratorService.new
p "loading professors"
migrator.load_professors(File.join(File.dirname(__FILE__),"services", 
"prof_anag.csv"))
p "loading affiliations"
migrator.load_affiliations(File.join(File.dirname(__FILE__),"services",
"prof_aff.csv"))
p "work complete"
