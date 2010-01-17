
require 'rubygems'
require 'mechanize'
require 'dm-core'

require File.dirname(__FILE__) + "/domain/mail_match.rb"
require File.dirname(__FILE__) + "/domain/query.rb"
require File.dirname(__FILE__) + "/services/mechanize_service.rb"
require File.dirname(__FILE__) + "/services/search_service.rb"

query = Query.new( ["ahlin", "kjell", "bth"])
searcher = SearchService.new
matches = searcher.search(query)
matches.each { |match| match.evaluate(query.params)}
max_score = matches.max { |a,b| a.score <=> b.score }.score
matches.sort { |a,b| a.score <=> b.score }.each do |m|
  p "#{m.email}"
end