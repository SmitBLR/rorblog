xml.instruct!
xml.rss :version => "2.0", "xmlns:media" => "http://search.yahoo.com/mrss" do
  xml.channel do
    xml.title "Blog"
    xml.description "Test task for PowerMeMobile job"
    xml.pubDate @articles.first.created_at.to_s(:rfc1123)
    @articles.each do |article|
      xml.item do
        xml.title h(article.title)
        xml.description h(article.content)
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url article
        xml.guid article_url article
      end
    end
  end
end