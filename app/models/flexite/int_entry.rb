class Flexite::IntEntry < Flexite::Entry
  def value
    self[:value].to_i
  end

  def view_type
    :integer
  end
end