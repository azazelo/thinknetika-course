module Validations
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validates(arg_name, validators)
      @validations ||= {}
      @validations[arg_name] = validators
    end

    def validations
      @validations ||= {}
    end

  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def validate!
      validations.each do |attr, validators|
        # attr = :name
        # validators = {presence: true, format: regexp, inclusion: array}
        validators.each do |validator, value|
          raise "Отсутствует определение валидатора <#{validator}>." unless self.respond_to?(validator, true)
          send "#{validator}", attr, value
        end
      end

    end

    def validations
      ##TODO fix getting validations from all tree
      self.class.validations.empty? ? self.class.superclass.validations : (self.class.validations.merge(self.class.superclass.validations) rescue self.class.validations)
    end

    def presence(attr, value)
      raise "<#{attr}>: Не может быть пустым!" if self.send(attr) == ""
    end

    def format(attr, value)
      raise "<#{attr}>: Формат неверный! Должен быть такой <#{value.inspect}>" unless self.send(attr) =~ value
    end

    def inclusion(attr, value)
      raise "<#{attr}>: Должен быть один из #{value}" unless value.include?(self.send(attr))
    end

    def uniqueness(attr, value)
      raise "<#{attr}>: Уже создан объект класса '#{self.class.name}' с атрибутом '#{attr}' = '#{self.send(attr)}'" if self.class.instances.detect { |o| o.send(attr) == self.send(attr) }
    end

    def numeric(attr, value)
      raise "<#{attr}>: Должен быть числом. Значение: #{self.send(attr)}" unless self.send(attr).is_a?(Fixnum)
    end

  end
end
