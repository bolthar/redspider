
class MailmatchService

  def erase_all_matches
    matches = Mailmatch.all
    matches.each { |m| m.destroy }
  end

end