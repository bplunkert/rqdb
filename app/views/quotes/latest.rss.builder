xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'RQDB'
    xml.description 'Rash Quote Database'
    xml.link root_url
    xml.language 'en'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => "#{root_url}/latest.rss"
    @quotes.each do |quote|
      xml.item do
        xml.link quote_url(quote)
        xml.guid({:isPermaLink => false}, quote.id)
        xml.pubDate(quote.created_at.rfc2822)
        xml.description quote.text        
      end
    end
  end
end
