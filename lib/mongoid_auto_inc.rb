require "incrementor"

module MongoidAutoInc
  extend ActiveSupport::Concern

  module ClassMethods
    def auto_increment(name, options={})
      field name
      
      class_eval { 
        before_create { self.send("#{name}=", MongoidAutoInc::Incrementor[self.class.name].inc) } 
      }
    end
  end
end

module Mongoid
  module Document
    include MongoidAutoInc
  end
end
