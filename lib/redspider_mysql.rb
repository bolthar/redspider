
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
require File.dirname(__FILE__) + "/services/professor_service.rb"
require File.dirname(__FILE__) + "/services/mailmatch_service.rb"
require File.dirname(__FILE__) + "/services/batch_service.rb"

pass = ask("Enter mysql password :") { |q| q.echo = false}
begin
  DataMapper.setup(:default, "mysql://root:#{pass}@localhost/redspider")
  DataMapper.auto_upgrade!
rescue
  print "wrong password!\n"
  exit
end
begin
  #erases all previously found matches
  mailmatch = MailmatchService.new
  mailmatch.erase_all_matches
  #starts with new search
  print "Loading professors...\n"
  batch = BatchService.new
  professor = ProfessorService.new
  professors_count = professor.count
  print "#{professors_count} professors found in database\n"
  batch_dimension = 50
  offset = 0
  batches = (professors_count / batch_dimension) + 1
  batches.times do
    begin
      prof_batch = professor.get_professors_batch(batch_dimension, offset)
      batch.look_for_emails(prof_batch)
    rescue Exception => ex
      print ex.message + "\n"
    end
  end
rescue Exception => ex  
  print ex.message + "\n"
end

