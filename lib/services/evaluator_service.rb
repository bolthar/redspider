
class EvaluatorService

  def evaluate_matches(matches, query)
    matches.each do |match|
      match.evaluate(query.params)
    end    
  end

end