require './rental'
require './person'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end
  def to_json
    {
      title: title,
      author: author
    }.to_json
  end
end
