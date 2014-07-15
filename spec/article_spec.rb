require "rspec/its"
require "article"

describe Article do

  describe "#to_resource" do
    context "given an article" do
      let(:article) { Article.new("http://the/link", {
        :title => "the title",
        :description => "The site of the/link",
        :language => "en-US",
        :author => "Yasodara Cordova",
        :datePublished  => DateTime.new(2014,6,30,18,20,25, "+01:00"),
        :articleBody => "Un conteudo mucho louco",
        :articleSection => "sports" })
      }

      context "when it is converted to a resource" do
        subject(:resource) {article.to_resource}
        its(:uri) {is_expected.to be == "http://the/link"}
        its(:url) {is_expected.to be == "http://the/link"}
        its(:type) {is_expected.to be == "Article"}
        its(:headline) {is_expected.to be == "the title"}
        its(:description) {is_expected.to be == "The site of the/link"}
        its(:inLanguage) {is_expected.to be == "en-US"}
        its(:author) {is_expected.to be == "Yasodara Cordova"}
        its(:datePublished) {is_expected.to be == "2014-06-30T18:20:25+01:00"}
        its(:articleBody) {is_expected.to be == "Un conteudo mucho louco"}
        its(:articleSection) {is_expected.to be == "sports"}
      end
    end

    context "given an article without datePublished" do
      let (:article) { Article.new("http://the/link", {
        :title => "the title",
        :description => "The site of the/link"})
      }

      context "when it is converted to a resource" do
        it { expect(article.to_resource).to_not respond_to :datePublished}
      end
    end
  end

end
