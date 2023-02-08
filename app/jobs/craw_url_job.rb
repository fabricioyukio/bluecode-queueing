class CrawUrlJob < ApplicationJob
  include HTTParty
  require "Mechanize"

  queue_as :default

  def perform(url)
    # Do something later
    @url = url
    if check_url
      @url.checked_at = Time.now if @url.status == "checked"
      @url.save
    end    
  end

  def check_url
    urls_in = crawl
    
    urls_in.each do |url|
      check_url = Url.find_or_create_by(url: url)
      check_url.status = "pending"
      if check_url.valid?
        check_url.save
        CrawUrlJob.set(wait: 10.seconds).perform_later(check_url)
        @url.status = "checked"
      end
    end
    return true
  end

  def crawl
    agent = Mechanize.new
    body = agent.get(@url.url)
    urls_in_text = []
    body.links_with(:href => /^https?/).map{ |link| link.href}
  end
end
