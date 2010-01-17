
class ShellView < FreightView

  signal :quit
  
  def on_shell_destroy
    fire :quit
  end
  
end