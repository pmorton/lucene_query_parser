require "spec_helper"

describe LuceneQueryParser::ParserWithProximity do

  let(:parser) {LuceneQueryParser::ParserWithProximity.new} 

  it "parses proximity of two terms" do
    should parse('test ~5 test').as(
      [{:term=>"test"}, {:op=>"~", :distance=>"5", :term=>"test"}]
    )
  end

  it "parses proximity of two groups" do
    should parse('(test1 OR test2) ~5 (test3 OR test4)').as(
      [{:group=>[{:term=>"test1"}, {:op=>"OR", :term=>"test2"}]}, {:op=>"~", :distance=>"5", :group=>[{:term=>"test3"}, {:op=>"OR", :term=>"test4"}]}]
    )
  end

  it "parses proximity of two groups" do
    should parse('(test1 OR test2) ~5 (test3 OR test4)').as(
      [{:group=>[{:term=>"test1"}, {:op=>"OR", :term=>"test2"}]}, {:op=>"~", :distance=>"5", :group=>[{:term=>"test3"}, {:op=>"OR", :term=>"test4"}]}]
    )
  end

end
