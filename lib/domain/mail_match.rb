
class MailMatch

  attr_reader :email
  attr_reader :score

  def initialize(email)
    @email = email
    @score = 0
  end

  def evaluate(person_data)
    @score = 0
    person_data.each do |data|
      @score += 1 if @email.match(/#{data}/i)
    end
  end

end