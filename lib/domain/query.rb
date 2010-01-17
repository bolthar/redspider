
class Query

  attr_reader :params
  
  def initialize(query_params)
    @params = query_params
  end

  def search_string
    return @params.join(" ")
  end

end