require 'rss'
require 'rss/maker'
require 'articles_factory'

describe ArticlesFactory do

  context "given a valid rss version 2.0 with two items" do

    rss_string = <<-eos
        <rss version="2.0">
          <channel>
            <title>The tile</title>
            <link>http://bla</link>
            <description>The description</description>
            <language>en-en</language>
            <copyright>Copyright 2014, Company</copyright>
            <item>
              <link>http://bla2</link>
              <title>Legal Justification For Snooping: Statement</title>
              <description>
                <![CDATA[
                  <p>any</p>
                ]]>
              </description>
              <enclosure url="http://www.w3c.org/sample.mp3" length="105000" type="audio/mpeg" />
            </item>
            <item>
              <link>http://bla3</link>
              <title>Marco Civil: A World First Digital Bill of Rights</title>
              <description>
                <![CDATA[
                  <p>any</p>
                ]]>
              </description>
              <enclosure url="http://www.w3c.org/sample.mp3" length="105000" type="audio/mpeg" />
            </item>
          </channel>
        </rss>
      eos

    rss = RSS::Parser.parse(rss_string)

    it "should create two articles from rss" do
      articlesFactory = ArticlesFactory.new
      articles = articlesFactory.create(rss)

      expect(articles.count).to eq(2)
    end

    it "should set header properties into articles" do
      articlesFactory = ArticlesFactory.new
      articles = articlesFactory.create(rss)
      expect(articles[0].publisher).to eq("http://bla")
    end

    it "should set language properties into articles" do
      articlesFactory = ArticlesFactory.new
      articles = articlesFactory.create(rss)
      expect(articles[0].language).to eq("en")
    end

    it "should set enclosure properties into articles" do
      articlesFactory = ArticlesFactory.new
      articles = articlesFactory.create(rss)
      expect(articles[0].enclosure.url).to eq("http://www.w3c.org/sample.mp3")
    end

    it "should set copyright properties into articles" do
      articlesFactory = ArticlesFactory.new
      articles = articlesFactory.create(rss)
      expect(articles[0].copyright).to eq("Copyright 2014, Company")
    end

  end

  context "given a valid rss version 2.0 with one item" do

    rss_string = <<-eos
        <rss xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" xmlns:slash="http://purl.org/rss/1.0/modules/slash/" version="2.0">
          <channel>
            <title>The tile</title>
            <link>http://bla</link>
            <description>The description</description>
            <language>en-gb</language>
            <item>
            <title>
                Open Contracting Data Standard Draft Released for Comment
            </title>
            <link>
            http://webfoundation.org/2014/06/opencontracting-datamodel/
            </link>
            <comments>
            http://webfoundation.org/2014/06/opencontracting-datamodel/#comments
            </comments>
            <pubDate>Thu, 26 Jun 2014 17:57:45 +0000</pubDate>
            <dc:creator>
            <![CDATA[ Michael Roberts ]]>
            </dc:creator>
            <category>
            <![CDATA[ Projects ]]>
            </category>
            <category>
            <![CDATA[ Open Government Data ]]>
            </category>
            <category>
            <![CDATA[ opencontracting ]]>
            </category>
            <guid isPermaLink="false">http://webfoundation.org/?p=10667</guid>
            <description>
            <![CDATA[
            <p>The World Wide Web Foundation is pleased to announce the <a href="http://ocds.open-contracting.org/standard/">first release of the Open Contracting Data Standard (OCDS)</a>, which aims to enhance and promote disclosure and participation in public contracting, for broad consultation. In this release, we present &#8230;</p>
            ]]>
            </description>
            <content:encoded>
            <![CDATA[ Um teste muito legal :D
            ]]>
            </content:encoded>
            <wfw:commentRss>
            http://webfoundation.org/2014/06/opencontracting-datamodel/feed/
            </wfw:commentRss>
            <slash:comments>0</slash:comments>
            </item>
          </channel>
        </rss>
      eos

    rss = RSS::Parser.parse(rss_string)

    context "when creating an article from rss" do

      articlesFactory = ArticlesFactory.new
      article = articlesFactory.create(rss)[0]

      it "should set the article title" do
        expect(article.title).to eq("Open Contracting Data Standard Draft Released for Comment")
      end

      it 'should set the article url' do
        expect(article.url).to eq("http://webfoundation.org/2014/06/opencontracting-datamodel/")
      end

      it 'should set the article author' do
        expect(article.author).to eq("Michael Roberts")
      end

      it 'should set the article description' do
        expect(article.description).to eq('The World Wide Web Foundation is pleased to announce the first release of the Open Contracting Data Standard (OCDS), which aims to enhance and promote disclosure and participation in public contracting, for broad consultation. In this release, we present …')
      end

      it 'should set the article articleBody' do
        expect(article.articleBody).to eq('Um teste muito legal :D')
      end

      it 'should set the article datePublished' do
        expect(article.datePublished).to eq(DateTime.new(2014,6,26,17,57,45,'+00:00'))
      end
      it 'should set the article language' do
        expect(article.language).to eq("en")
      end

    end

  end

  context "given a valid rss version 1.0 with one item" do
    rss_string = <<-eos
      <rdf:RDF xmlns="http://purl.org/rss/1.0/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <channel rdf:about="http://web.idrc.ca/en/ev-1-201-1-DO_TOPIC.html?from=rss">
        <title>International Development Research Centre</title>
        <link>http://web.idrc.ca/en/ev-1-201-1-DO_TOPIC.html?from=rss</link>
        <dc:language>en-ca</dc:language>
        <description>
          IDRC is a Canadian Crown corporation that works in close collaboration with researchers from the developing world in their search for the means to build healthier, more equitable, and more prosperous societies.
        </description>
          <items>
            <rdf:Seq>
              <rdf:li rdf:resource="http://www.idrc.ca/en/ev-149607-201-1-DO_TOPIC.html"/>
            </rdf:Seq>
          </items>
        </channel>
        <item rdf:about="http://www.idrc.ca/en/ev-149607-201-1-DO_TOPIC.html">
          <dc:date>2011-07-28T18:21:06+00:00</dc:date>
          <title>Lasting Impacts &#151; How IDRC-funded research has improved lives in the developing world</title>
          <link>http://web.idrc.ca/en/ev-149607-201-1-DO_TOPIC.html?from=rss</link>
          <description>IDRC marks its 40th anniversary with a look back at the lasting impacts of IDRC-supported research.</description>
        </item>
      </rdf:RDF>
    eos

    rss = RSS::Parser.parse(rss_string)

    context "when creating an article from rss" do

      articlesFactory = ArticlesFactory.new
      article = articlesFactory.create(rss)[0]

      it "should set the article title" do
        expect(article.title).to eq("Lasting Impacts  How IDRC-funded research has improved lives in the developing world")
      end

      it 'should set the article url' do
        expect(article.url).to eq("http://web.idrc.ca/en/ev-149607-201-1-DO_TOPIC.html?from=rss")
      end

      it 'should set the article description' do
        expect(article.description).to eq('IDRC marks its 40th anniversary with a look back at the lasting impacts of IDRC-supported research.')
      end

      it 'should set the article datePublished' do
        expect(article.datePublished).to eq(DateTime.new(2011,7,28,18,21,06,'+00:00'))
      end

      it 'should set the article language' do
        expect(article.language).to eq("en")
      end

    end

  end

  context "given a valid rss with invalid characters and a html encoded character" do

    rss_string = <<-eos
        <rss version="2.0">
          <channel>
            <title>The tile</title>
            <link>http://bla</link>
            <description>The description</description>
            <item>
              <link>http://bla2</link>
              <title>Lasting Impacts &amp;#151; How IDRC-funded research has improved lives in the developing world</title>
              <description>This is a string with an html encoded character &mdash; It should be decode</description>
            </item>
          </channel>
        </rss>
      eos

    rss = RSS::Parser.parse(rss_string)

    context "when creating an article from rss" do

      articlesFactory = ArticlesFactory.new
      article = articlesFactory.create(rss)[0]

      it 'should not have invalid characters' do
        expect(article.title).to eq('Lasting Impacts  How IDRC-funded research has improved lives in the developing world')
      end

      it 'should decode the html encoded character' do
        expect(article.description).to eq("This is a string with an html encoded character \u{2014} It should be decode")
      end

    end

  end

  context "given an rss item without description" do
    it "should not create an article" do
      articlesFactory = ArticlesFactory.new
      rss = RSS::Maker.make("2.0") do |m|
        m.channel.link  = "http://any.com/"
        m.channel.description = 'any'
        m.channel.title = 'any'
        m.items.new_item do |item|
          item.title = "any"
        end
      end
      articles = articlesFactory.create(rss)
      expect(articles.length).to be 0
    end
  end

  context "given an rss item without title" do
    it "should not create an article" do
      articlesFactory = ArticlesFactory.new
      rss = RSS::Maker.make("2.0") do |m|
        m.channel.link  = "http://any.com/"
        m.channel.description = 'any'
        m.channel.title = 'any'
        m.items.new_item do |item|
          item.description = "any"
        end
      end
      articles = articlesFactory.create(rss)
      expect(articles.length).to be 0
    end
  end

end
