#generated by ftrain

class DetailsView < FreightView

  signal :search
  signal :mail
  
  def on_search_clicked
    fire :search
  end

   def matches_on_mail(value)
    fire :mail, value
  end

end