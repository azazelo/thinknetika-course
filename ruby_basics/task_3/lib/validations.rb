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
      validations.each do |arg_name, validators|
        validators.each do |validator, value|
          send "#{validator}", arg_name, value
        end
      end
      true
    rescue
      false
    end

    private

    def validate!
      # arg_name = :name
      # validators = {presence: true, format: regexp, uniqueness: true, inclusion: list}
      validations.each do |arg_name, validators|
        validators.each do |validator, value|
          raise "Ошибка! Отсутствует определение валидатора <#{validator}>." unless self.respond_to?(validator, true)
          send "#{validator}", arg_name, value
        end
      end

    end

    def validations
      self.class.validations.empty? ? self.class.superclass.validations : self.class.validations
    end

    def presence(arg_name, value)
      raise "Ошибка! <#{arg_name}>: Не может быть пустым!" if self.send(arg_name) == ""
    end

    def format(arg_name, value)
      raise "Ошибка! <#{arg_name}>: Формат неверный! Должен быть такой <#{value}>" unless self.send(arg_name) =~ value
    end

    def inclusion(arg_name, value)
      raise "Ошибка! <#{arg_name}>: Должен быть один из #{value}" unless value.include?(self.send(arg_name))
    end

  end
end
