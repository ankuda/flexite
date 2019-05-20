module Flexite
  module WithHistory
    extend ActiveSupport::Concern

    included do
      after_save :save_history

      def self.history_attributes(*attributes)
        define_method :history_attributes do
          attributes
        end
      end
    end

    def restore(history)
      history.history_attributes.each do |attr|
        if attr.name.end_with?('_was')
          self[attr.name.gsub('_was', '')] = attr.value
        else
          self[attr.name] = attr.value
        end
      end

      self.class.skip_callback(:save, :after, :save_history)

      begin
        save!
      ensure
        self.class.set_callback(:save, :after, :save_history)
      end
      self.tv_node if self.is_a?(Config)
    end

    private

    def save_history
      return unless changed?

      history = histories.build

      History.transaction do
        history_attributes.each do |attr|
          history.history_attributes.build(name: attr, value: send(attr))
        end

        history.save
      end

      if history.invalid?
        errors.set(:history, history.full_messages)
      end
    end
  end
end
