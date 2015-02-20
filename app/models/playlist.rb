class Playlist < ActiveRecord::Base
  has_many :videos#, -> { joins(:votes).select("videos.*, count(votes.id) vote_count").group("videos.id").order("vote_count DESC") }


  def self.search_for_video(query)
    formatted_query = query.split(" ").join("+")

    uri = open("https://www.youtube.com/results?search_query=#{formatted_query}")
    page = Nokogiri::HTML(uri)

    titles = page.css(".yt-lockup-title")

    @results = []

    titles.each do |title|
      link = title.at_css("a")['href'].match(/v=([^&]+)/)
      if link
        @results << {title: title.inner_text, link: link[1], duration: get_duration(title)}
      end
    end

    @results
  end

  def self.get_duration(noko_bullshit)
    duration = noko_bullshit.inner_text.match(/Duration: (\d+):(\d+)/)
    if duration
      return duration[1].to_i*60 + duration[2].to_i
    end
  end

  def sorted_videos
    self.videos.sort{|a,b| b.votes.count <=> a.votes.count}
  end

end
