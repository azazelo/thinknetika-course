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
      # arg_name = :name
      # validators = {presence: true, format: regexp, inclusion: array}
      validations.each do |attr, validators|
        validators.each do |validator, value|
          raise "Ошибка! Отсутствует определение валидатора <#{validator}>." unless self.respond_to?(validator, true)
          send "#{validator}", attr, value
        end
      end

    end

    def validations
      self.class.validations.empty? ? self.class.superclass.validations : self.class.validations
    end

    def presence(attr, value)
      raise "Ошибка! <#{attr}>: Не может быть пустым!" if self.send(attr) == ""
    end

    def format(attr, value)
      raise "Ошибка! <#{attr}>: Формат неверный! Должен быть такой <#{value}>" unless self.send(attr) =~ value
    end

    def inclusion(attr, value)
      raise "Ошибка! <#{attr}>: Должен быть один из #{value}" unless value.include?(self.send(attr))
    end

    def uniquieness(attr, value)
      raise "Ошибка! <#{attr}>: Уже создан объект с атрибутом '#{attr}' = #{self.send(attr)}" if self.class.instances.detect { |o| o.send(attr) == self.send(attr) }
    end

  end
end
