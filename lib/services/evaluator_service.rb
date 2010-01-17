
class EvaluatorService

  def evaluate_matches!(matches, query)
    matches.each do |match|
      match.evaluate(query.params)
    end
    matches.sort! { |a,b| a.score <=> b.score }.reverse!
  end

end