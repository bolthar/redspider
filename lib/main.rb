
require 'rubygems'
require 'mechanize'

require File.dirname(__FILE__) + "/domain/mail_match.rb"
require File.dirname(__FILE__) + "/domain/query.rb"
require File.dirname(__FILE__) + "/services/mechanize_service.rb"
require File.dirname(__FILE__) + "/services/search_service.rb"

query = Query.new(["Francesco", "Lissoni", "unibs"])
searcher = SearchService.new
matches = searcher.search(query)
p matches
matches.sort { |a,b| a.score <=> b.score }.reverse.each do |m|
  p "#{m.score} - #{m.email}"
end