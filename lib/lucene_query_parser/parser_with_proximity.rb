module LuceneQueryParser
  class ParserWithProximity < LuceneQueryParser::Parser

     def initialize
      @with_proximity = true
    end

    rule :operator do
      op = str('AND').as(:op) | str('OR').as(:op) 
      op = op.send("|",  str('~').as(:op) >> match['0-9'].repeat(1).as(:distance) ) if @with_proximity
      op
    end

  end
end