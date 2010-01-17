
class MechanizeService

  def search_google(query)
    agent = WWW::Mechanize.new
    agent.get("http://www.google.com") do |page|
      result = page.form_with(:name => 'f') do |search|
        search.q = query.search_string
      end.submit
      return result
    end    
  end

  def search_result_page(query)
    agent = WWW::Mechanize.new
    agent.get("http://www.google.com") do |page|
      result = page.form_with(:name => 'f') do |search|
        search.q = query.search_string
      end.submit
      return result.search('//a[@class="s"]').each do |div|
        content = div.inner_html
        content = content.gsub("<em>","").gsub("</em>","")

      end
    end
  end

  def follow_link(link)
    unless link['href'].match(/\.pdf/i)
      p "scanning #{link['href']}..."
      begin
      agent = WWW::Mechanize.new
      agent.get(link['href']) do |page|
        return page
      end
      rescue Exception => ex
        p ex.message
      end
    end
  end


end