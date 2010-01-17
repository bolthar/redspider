
class SearchService

  def initialize
    @mechanize = MechanizeService.new
    @email_regexp = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i
  end

  def search(query)
    matches = []
#    threads = []
    google_results = @mechanize.search_google(query)
    google_results.search('//div[@class="s"]').each do |div|
      content = div.inner_html.gsub("<em>","").gsub("</em>","")
      content.scan(@email_regexp).each do |match|
        count = matches.select { |m| m.email == match }.length
        matches << Mailmatch.new(match) if count == 0
      end
    end
    return matches
#    links = google_results.search('//a[@class="l"]')
#    links.each do |link|
#      threads << Thread.new do
#        page = @mechanize.follow_link(link)
#        if page
#        page.body.scan(@email_regexp).each do |match|
#          count = matches.select { |m| m.email == match }.length
#          matches << Mailmatch.new(match) if count == 0
#        end
#        end
#      end
#      end
#      threads.map {|t| t.join }
#      return matches
    end
    
end