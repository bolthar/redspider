
require 'rubygems'
require 'mechanize'

class MailMatch

  attr_reader :email
  attr_reader :score

  def initialize(email)
    @email = email
  end

  def evaluate(person_data)
    @score = 0
    person_data.each do |data|
      @score += 1 if @email.match(/#{data}/i)
    end
  end

end

matches = []
search_string = "adahl kerstin bth blekinge email"
agent = WWW::Mechanize.new
agent.get("http://www.google.com") do |page|
  result = page.form_with(:name => 'f') do |search|
    search.q = search_string
  end.submit
  result.search('//a[@class="l"]').each do |link|
    unless link['href'].match(/pdf/i)
      p "scanning #{link['href']}..."
      begin
      agent.get(link['href']) do |new_page|
        new_page.body.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).each do |match|
           matches << MailMatch.new(match)
        end
      end
      rescue Exception => ex
        p ex.message
      end
    end
  end
end

matches.each do |match|
  match.evaluate(search_string.split)
end
matches.sort { |a,b| a.score <=> b.score}.reverse.each do |match|
  p "#{match.email}, score : #{match.score}"
end