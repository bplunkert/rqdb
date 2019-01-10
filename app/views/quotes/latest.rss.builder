xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'RQDB'
    xml.description 'Rash Quote Database'
    xml.link root_url
    xml.language 'en'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => './latest.rss'
    for quote in @quotes
      xml.item do
        xml.id quote.id
        xml.score quote.score
        xml.link quote_url(quote)
        xml.pubDate(quote.created_at.rfc2822)
        xml.text quote.text        
      end
    end
  end
end
