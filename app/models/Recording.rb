# frozen_string_literal: true

class Recording
  def initialize(id, url, name)
    @id = id
    @url = url
    @name = name
  end

  attr_reader :id

  attr_reader :url

  attr_reader :name
end
