
class Affiliation
  include DataMapper::Resource
  
  property :id,   Serial
  property :code, String
  property :role, String, :length => 200

  belongs_to :professor

end