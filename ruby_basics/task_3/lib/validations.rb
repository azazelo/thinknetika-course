module Validations
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
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
    rescue StandardError
      false
    end

    private

    def validate!
      validations.each do |attr, validators|
        # attr = :name
        # validators = {presence: true, format: regexp, inclusion: array}
        validators.each do |validator, value|
          unless respond_to?(validator, true)
            raise "Отсутствует определение валидатора <#{validator}>."
          end

          send validator.to_s, attr, value
        end
      end
    end

    def validations
      # #TODO fix getting validations from all tree
      if self.class.validations.empty?
        self.class.superclass.validations
      else
        begin
          self.class.validations.merge(self.class.superclass.validations)
        rescue StandardError
          self.class.validations
        end
      end
    end

    def presence(attr, _value)
      raise "#{attr}: Не может быть пустым!" if send(attr) == ''
    end

    def inclusion(attr, value)
      return true if value.include?(send(attr))

      raise "#{attr}: Должен быть один из #{value}"
    end

    def uniqueness(attr, _value)
      return true unless self.class.find(attr, send(attr))

      raise "#{attr}: Уже создан объект класса '#{self.class.name}'
               с атрибутом '#{attr}' = '#{send(attr)}'"
    end

    def format(attr, value)
      return true if send(attr) =~ value

      raise "#{attr}: Формат неверный! Должен быть такой <#{value.inspect}>"
    end

    def numeric(attr, _value)
      return true if send(attr).is_a?(Integer)

      raise "#{attr}: Должен быть числом. Значение: #{send(attr)}"
    end
  end
end
