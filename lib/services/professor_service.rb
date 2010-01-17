
class ProfessorService

  def get_professors_batch(count, offset)
    return Professor.all(:limit => count, :offset => offset)
  end

  def count
    return Professor.all.length
  end

  def save_matches(matches, professor)
    matches.each do |match|
      #assigning each match to the professor
      match.professor = professor
      professor.mailmatches << match
    end
    #saving the matches in DB
    professor.save
  end
end
