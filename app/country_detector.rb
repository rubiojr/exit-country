class CountryDetector

  LocationRetrievedNotification = 'LocationRetrievedNotification'

  def initialize
    @client = HttpClient.new("https://freegeoip.net")
  end

  def start
    Dispatch::Queue.concurrent.async do
      loop do
        @client.get "/csv" do |response|
          if response.success?
            Dispatch::Queue.main.sync { NSNotificationCenter.defaultCenter.postNotificationName(LocationRetrievedNotification, object: response.data) }
          end
        end
        sleep 5
      end
    end
  end

end
