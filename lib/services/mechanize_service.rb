
class MechanizeService

  def search_google(query)
    agent = WWW::Mechanize.new
    agent.get("http://www.google.com") do |page|
      result = page.form_with(:name => 'f') do |search|
        search.q = query.search_string
      end.submit
      return result.search('//a[@class="l"]')
    end    
  end

  def follow_link(link)
    matches = []
    unless link['href'].match(/pdf/i)
      p "scanning #{link['href']}..."
      begin
      agent = WWW::Mechanize.new
      agent.get(link['href']) do |new_page|
        new_page.body.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).each do |match|
          matches << MailMatch.new(match)
        end
      end
      rescue Exception => ex
        p ex.message
      end
    end
    return matches
  end

end