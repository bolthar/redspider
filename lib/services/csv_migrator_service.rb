

class CsvMigratorService

  def load_professors(filepath)
    File.open(filepath).lines.each do |line|
      data = line.split("\t")
      professor               = Professor.new
      professor.id            = data[0].gsub("\"","").to_i
      professor.name          = data[1].gsub("\"","")
      professor.surname       = data[2].gsub("\"","")
      professor.year_of_birth = data[3].gsub("\"","").to_i
      professor.gender        = data[4].gsub("\"","").gsub("\n","")
      professor.save
    end
  end

  def load_affiliations(filepath)
    File.open(filepath).lines.each do |line|
      data = line.split("\t")
      affiliation = Affiliation.new
      professor   = Professor.get(data[0].gsub("\"","").to_i)
      if professor
        affiliation.code       = data[1].gsub("\"","")
        affiliation.role       = data[2].gsub("\"","")
        affiliation.professor  = professor
        professor.affiliations << affiliation
        professor.save
      end
    end
  end

end