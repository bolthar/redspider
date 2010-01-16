
class Professor
  include DataMapper::Resource

  property :id, Integer, :key => true
  property :name, String
  property :surname, String
  property :year_of_birth, Integer
  property :gender, String

  has n, :affiliations
  has n, :mailmatches


end