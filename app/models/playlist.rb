class Playlist < ActiveRecord::Base
  has_many :videos


  def self.search_for_video(query)
    formatted_query = query.split(" ").join("+")

    uri = open("https://www.youtube.com/results?search_query=#{formatted_query}")
    page = Nokogiri::HTML(uri)

    titles = page.css(".yt-lockup-title")

    @results = []

    titles.each do |title|
      link = title.at_css("a")['href'].match(/v=([^&]+)/)
      @results << {title: title.inner_text, link:link[1]}
    end

    @results
  end

end
