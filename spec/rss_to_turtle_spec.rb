require "rspec/its"
require "rss_to_turtle"
require 'pry'

describe RSSToTurtle do
    let(:rss_string){
        '<rss version="2.0">
          <channel>
            <title>The tile</title>
            <link>http://bla</link>
            <description>The description</description>
            <item>
              <link>http://bla2</link>
              <title>Legal Justification For Snooping: Statement</title>
              <description>
                <![CDATA[
                  <p>any</p>
                ]]>
              </description>
            </item>
            <item>
              <link>http://bla3</link>
              <title>Marco Civil: A World First Digital Bill of Rights</title>
              <description>
                <![CDATA[
                  <p>any</p>
                ]]>
              </description>
            </item>
          </channel>
        </rss>'}
      turtle_string =  <<-eos
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .\n@prefix schema: <http://schema.org/> .\n\n<http://bla2> a schema:Article;\n   schema:description \"any\";\n   schema:headline \"Legal Justification For Snooping: Statement\";\n   schema:publisher <http://bla>;\n   schema:url <http://bla2> .\n\n<http://bla3> a schema:Article;\n   schema:description \"any\";\n   schema:headline \"Marco Civil: A World First Digital Bill of Rights\";\n   schema:publisher <http://bla>;\n   schema:url <http://bla3> .
      eos

    it "should convert rss to turtle" do
        expect(RSSToTurtle.convert(rss_string)).to be == turtle_string
    end

    let(:url) {'http://webfoundation.org/feed/'}
    it "should convert a feed from webfoundation to turtle" do 
        expect{RSSToTurtle.convert_from_url(url)}.not_to raise_error
        expect(RSSToTurtle.convert_from_url(url)).not_to be_empty
    end
end
