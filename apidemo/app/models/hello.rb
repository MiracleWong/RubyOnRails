require 'json'

class Hello
  def to_json(text)
    return JSON.parse("{\"hello\": \"#{text}!\"}")
  end
  def login
  end
end