
class Mailmatch
  include DataMapper::Resource

  property :id,    Serial
  property :email, String
  property :score, Integer

  belongs_to :professor

  def initialize(email)
    attribute_set(:email, email)
    attribute_set(:score, 0)
  end

  def evaluate(person_data)
    person_data.each do |data|
      score += 1 if @email.match(/#{data}/i)
    end
  end

end