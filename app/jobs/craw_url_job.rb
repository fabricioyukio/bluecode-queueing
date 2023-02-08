class CrawUrlJob < ApplicationJob
  include HTTParty
  queue_as :default

  def perform(url)
    # Do something later
    puts "CrawUrlJob"
    puts url.inspect()
    @url = Url.find_or_create_by(url: url.url)
    @url.status = check_url
    @url.checked_at = Time.now if @url.status == "checked"
    @url.save
  
    # CrawUrlJob.set(wait: 1.minute).perform_later(@url)
    # CrawUrlJob.set(wait_until: Date.tomorrow.noon).perform_later(@url)
    
  end

  def check_url
    urls_in = crawl
    urls_in.each do |url|
      CrawUrlJob.perform_later @url
    end
    return "checked"
  end

  def crawl
    text = self.class.get(@url)
    text.scan(/(https?:\/\/([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)/)
  end
end
