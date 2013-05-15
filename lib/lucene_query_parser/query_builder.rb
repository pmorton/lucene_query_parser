module LuceneQueryParser
  class QueryBuilder
    
    def initialize(query)
      @query_string = query
      @parsed_query = ParserWithProximity.new.parse(query)
    end

    def build
      build_group(@parsed_query)  
    end
    
    def build_group(group)

      group = [group] if group.is_a? Hash

      document = {}
      last_op = nil

      group.each do |element|
        puts element.inspect
        document[:bool] ||= {}
        document[:bool][:must]  ||= []

        op = element[:op] || 'AND'

        if last_op.nil? or op.eql? last_op
          if element[:term]
            document[:bool][:must] << term_element(element[:term])
          elsif element[:phrase]
            document[:bool][:must] << {text_phrase: { message:  element[:phrase]}}
          end
        end
      end
      return document
    end

    def term_element(term)
      {term: {'_all' => term}}
    end
  end
end