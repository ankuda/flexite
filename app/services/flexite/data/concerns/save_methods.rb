module SaveMethods
  private

  def save_root(root, configs)
    @result[root] = {}
    begin
      Flexite::Config.skip_callback(:save, :after, :save_history)
      Flexite::Entry.skip_callback(:save, :after, :save_history)
      Flexite::Config.create!(name: root) do |record|
        begin
          save_hash_value(record, configs)
        rescue => exc
          @errors[record] << [exc.message, exc.backtrace]
        end
      end
    ensure
      Flexite::Config.set_callback(:save, :after, :save_history)
      Flexite::Entry.set_callback(:save, :after, :save_history)
    end
  end

  def save_entry(parent, entry)
    send("save_#{entry.class.name.underscore}_value", parent, entry)
  rescue => exc
    @errors[parent] << [exc.message, exc.backtrace]
  end

  def save_hash_value(parent, hash)
    parent.selectable = false

    hash.each do |name, value|
      entry = Flexite::Config.new(name: name)
      save_entry(entry, value)
      parent.configs << entry
    end
  end

  def save_array_value(parent, array)
    entry = Flexite::ArrEntry.new

    array.each do |value|
      save_entry(entry, value)
    end

    parent.entry = entry
  end

  def save_symbol_value(parent, symbol)
    parent.entry = Flexite::SymEntry.new(value: symbol)
  end

  def save_string_value(parent, string)
    parent.entry = Flexite::StrEntry.new(value: string)
  end

  def save_true_class_value(parent, _)
    parent.entry = Flexite::BoolEntry.new(value: 1)
  end

  def save_false_class_value(parent, _)
    parent.entry = Flexite::BoolEntry.new(value: 0)
  end

  def save_fixnum_value(parent, fixnum)
    parent.entry = Flexite::IntEntry.new(value: fixnum)
  end

  def save_nil_class_value(parent, nil_val)
    parent.entry = Flexite::Entry.new(value: nil_val)
  end
end