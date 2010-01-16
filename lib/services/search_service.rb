
class SearchService

  def initialize
    @mechanize = MechanizeService.new
  end

  def search(query)
    matches = []
    threads = []
    links = @mechanize.search_google(query)
    links.each do |link|
      threads << Thread.new do
        @mechanize.follow_link(link).each do |match|
          matches << match
        end
      end
      threads.map {|t| t.join }
    end
    return matches
  end
end