#generated by ftrain

class DetailsViewModel < FreightViewModel

  signal :message

  attr_reader :current
  attr_reader :selected

  service :search
  service :professor

  def professor_selected(professor)
    @current = professor
    @view.update
  end

  def mailmatches
    return @current.mailmatches.to_a
  end

  def on_search
    fire :message, "Searching matches for #{@current.name} #{@current.surname}"
    Thread.new do
      query = Query.new([@current.name, @current.surname, @current.affiliation.code])
      @professor.clear_matches(@current)
      matches = @search.search(query)
      matches.each { |match| match.evaluate(query.params)}
      p matches
      @professor.save_matches(matches, @current)
      fire :message, "#{matches.length} match(es) found."
      @view.update
    end
  end

  def on_selected(value)
    @selected = value
    @view.update
  end

  def on_mail
    p "mail"
  end

 


end