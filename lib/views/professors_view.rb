#generated by ftrain

class ProfessorsView < FreightView
  
  signal :selected

  def on_professor_list_cursor_changed
    fire :selected, professor_list.selection.selected[0]
  end

end