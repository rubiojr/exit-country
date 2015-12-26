class CountryDetector

  LocationRetrievedNotification = 'LocationRetrievedNotification'
  attr_reader :result

  def initialize
    @result = nil
    @client = HttpClient.new("https://freegeoip.net")
  end

  def start
    Dispatch::Queue.concurrent.async do
      loop do
        @client.get "/csv" do |response|
          if response.success?
            @result = response.data
            Dispatch::Queue.main.async { NSNotificationCenter.defaultCenter.postNotificationName(LocationRetrievedNotification, object:self) }
          end
        end
        sleep 5
      end
    end
  end

end
