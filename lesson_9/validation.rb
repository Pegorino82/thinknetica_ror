module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :data

    def validate(name, type, *args)
      @data ||= []
      @data.push([name, type, args])
    end
  end

  module InstanceMethods
    def valid?
      !validate!
    rescue StandardError
      false
    end

    def validate!
      self.class.data.each do |name, type, args|
        errors = []
        case type
        when :presence
          raise "Variable <#{self.class}><#{name}> presence error." if instance_variable_get("@#{name}".to_sym).nil?
        when :format
          unless instance_variable_get("@#{name}".to_sym) =~ args[0]
            errors << "Variable <#{self.class}><#{name}> type error."
          end
        when :type
          errors << validate_type(name, type, args)
        end
        errors.flatten!
        raise errors.join(' ') unless errors.empty?
      end
    end

    protected

    def validate_type(name, type, args)
      errors = []
      if instance_variable_get("@#{name}".to_sym).instance_of? Array
        instance_variable_get("@#{name}".to_sym).each_with_index do |var, index|
          errors << "Variable <#{self.class}><#{name}><#{index}> #{type} error." unless var.instance_of? args[0]
        end
      else
        unless instance_variable_get("@#{name}".to_sym).instance_of? args[0]
          errors << "Variable <#{self.class}><#{name}> type error."
        end
      end
      errors
    end
  end
end
