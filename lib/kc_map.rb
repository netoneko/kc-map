module KcMap
  def self.hello
    puts "Hello!"
  end

  class DataSource
    attr_reader :data, :posts_by_region

    def initialize(url)
      @url = url
    end

    def parse
      request = HTTP.get(@url) do |response|
        if response.ok?
          puts "successful!"

          process_data response.json["data"]
          visualize_data
        else
          puts "request failed :("
        end
      end
    end

    def process_data(json)
      # ["us","-79.3960","36.1943","/images/balls/us.png",1]
      @data = json.inject({}) do |hash, stats|
        country, long, lat, ball, _ = stats

        hash[country] = [] unless hash.include? country

        hash[country] << [long, lat]
        hash
      end

      puts @data.inspect

      @posts_by_region = @data.inject({}) do |hash, country, list|
        hash[country] = list.size
        hash
      end

      puts @posts_by_region
    end

    def visualize_data
      stats_array = @posts_by_region.collect do |country, size|
        {country: country, size: size}
      end.to_json.to_s

      `slice(JSON.parse(#{stats_array}))`
    end
  end

end

KcMap.hello

@datasource = KcMap::DataSource.new('http://krautchan.net/ajax/geoip/lasthour')
@datasource.parse