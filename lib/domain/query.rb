
class Query

  def initialize(query_params)
    @params = query_params
  end

  def search_string
    return @params.join(" ") + " email"
  end

end