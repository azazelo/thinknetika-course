module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :instances, :instances_count

    def instances
      @instances ||= []
    end
    def instances_count
      @instances_count ||= 0
    end
  end

  module InstanceMethods
    private
    def register_instance
      self.class.instances << self
      self.class.instances_count += 1
    end
  end
end
