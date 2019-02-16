module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances_count
      self.instance_variable_get(:@instances_count)
    end
    def instances
      self.instance_variable_get(:@instances)
    end
  end

  module InstanceMethods

    protected

    def register_instance
      old_value = self.class.instance_variable_get(:@instances_count) || 0
      self.class.instance_variable_set("@instances_count", old_value += 1)
      old_value = self.class.instance_variable_get(:@instances) || []
      self.class.instance_variable_set("@instances", old_value << self)
    end
  end
end
