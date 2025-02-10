module Searchable
    extend ActiveSupport::Concern

    included do
        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks

        def self.search(query)
            raise "DEFINE SEARCH"
        end

        # Define a class method for mapping
        def self.mapping(&block)
            if block_given?
                @mapping_block = block
            else
                raise NotImplementedError, "You must implement the mapping block in your model"
            end
        end

        def self.inherited(subclass)
            super
            subclass.mapping do
                raise NotImplementedError, "You must implement the mapping block in #{subclass}"
            end

            subclass.search(query) do
                raise NotImplementedError, "You must implement the search method in #{subclass}"
            end
        end

        def self.search(query)
            raise NotImplementedError, "You must implement the search method in your model" unless @search_block
        end
    end
end
