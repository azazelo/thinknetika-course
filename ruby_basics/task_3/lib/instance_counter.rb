module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      self.instance_variable_get(:@instances_count)
    end
  end

  module InstanceMethods

    protected

    def register_instance
      old_value = self.class.instance_variable_get(:@instances_count) || 0
      self.class.instance_variable_set("@instances_count", old_value += 1)
    end
  end
end
