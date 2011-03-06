# This is a modified version of the code found on this blog post:
#   http://ihswebdesign.com/blog/autoincrement-in-mongodb-with-ruby/
module MongoidAutoInc
  class Incrementor
    class Sequence
      def initialize(sequence, collection_name)
        @sequence = sequence.to_s
        @collection = collection_name.to_s
        exists? || create
      end

      def inc
        update_number_with("$inc" => { "number" => 1 })
      end

      def set(number)
        update_number_with("$set" => { "number" => number })
      end
    
      private

      def exists?
        collection.find(query).count > 0
      end

      def create(number = 0)
        collection.insert(query.merge({ "number" => number }))
      end

      def collection
        Mongoid.database[@collection]
      end
      
      def query
        { "seq_name" => @sequence }
      end
        
      def current
        collection.find_one(query)["number"]
      end
      
      def update_number_with(mongo_func)
        opts = {
          "query"  => query,
          "update" => mongo_func,
          "new"    => true # return the modified document
        }
        collection.find_and_modify(opts)["number"]
      end
    end
    
    def initialize(options={})
      @collection = options[:collection] || "sequences"
    end

    def [](sequence)
      Sequence.new(sequence, @collection)
    end

    def []=(sequence, number)
      Sequence.new(sequence, @collection).set(number)
    end
  end
end
