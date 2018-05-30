class Flexite::BaseFactory
  include Singleton

  def get(name,  *args)
    "Flexite::#{@store[name]}".constantize.new(*args)
  rescue NameError
    raise 'No instance for the given key'
  end
end
