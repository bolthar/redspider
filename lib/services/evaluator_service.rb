
class EvaluatorService

  def evaluate_matches(query, matches)
    matches.each do |match|
      match.evaluate(query.params)
    end    
  end

end