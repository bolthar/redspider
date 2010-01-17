
class BatchService

  def initialize
    @search = SearchService.new
    @professor = ProfessorService.new
  end
  
  def look_for_emails(professors)
    threads = []
    professors.each do |prof|
      threads << Thread.new do
        #building the query
        search_terms = []
        search_terms << prof.name
        search_terms << prof.surname
        search_terms << prof.affiliation.code if prof.affiliation
        query = Query.new(search_terms)
        #getting matches from google
        matches = @search.search(query)
        #giving scores to found matches
        matches.each { |m| m.evaluate(query.params)}
        matches.sort! { |a,b| a.score <=> b.score }.reverse!
        @professor.save_matches(matches, prof)
        print "#{prof.name} #{prof.surname} - #{matches.length} found, best : #{matches.first.email}\n"
      end
    end
    threads.map { |t| t.join }
  end
end