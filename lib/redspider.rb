
require 'rubygems'
require 'mechanize'

require File.dirname(__FILE__) + "/domain/mail_match.rb"
require File.dirname(__FILE__) + "/domain/query.rb"
require File.dirname(__FILE__) + "/services/mechanize_service.rb"
require File.dirname(__FILE__) + "/services/search_service.rb"
require File.dirname(__FILE__) + "/services/evaluator_service.rb"

query = Query.new(ARGV)
searcher = SearchService.new
matches = searcher.search(query)
evaluator = EvaluatorService.new
evaluator.evaluate_matches(matches, query)
max_score = matches.max { |a,b| a.score <=> b.score }.score
matches.sort { |a,b| a.score <=> b.score }.select { |m| m.score == max_score }.each do |m|
  p "#{m.email}" if m.score == max_score
end