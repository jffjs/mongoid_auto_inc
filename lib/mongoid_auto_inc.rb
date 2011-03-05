require "mongoid_auto_inc/incrementor"

module MongoidAutoInc
  extend ActiveSupport::Concern

  module ClassMethods
    def auto_increment(name, options={})
      field name
      
      incrementor = MongoidAutoInc::Incrementor.new
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
