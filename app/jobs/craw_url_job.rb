class CrawUrlJob < ApplicationJob
  include HTTParty
  require "Mechanize"

  queue_as :default

  def perform(url)
    # Do something later
    puts "--- CrawUrlJob ---"
    binding.pry
    @url = Url.find_or_create_by(url: url.url)
    puts @url.inspect()
    @url.status = check_url
    @url.checked_at = Time.now if @url.status == "checked"
    @url.save
  
    # CrawUrlJob.set(wait: 1.minute).perform_later(@url)
    # CrawUrlJob.set(wait_until: Date.tomorrow.noon).perform_later(@url)
    
  end

  def check_url
    puts "--- check_url ---"
    urls_in = crawl
    binding.pry
    urls_in.each do |url|
      check_url = Url.find_or_create_by(url: url)
      check_url.status = "pending"
      check_url.save
      CrawUrlJob.set(wait: 10.seconds).perform_later(check_url)
    end
    return "checked"
  end

  def crawl
    puts "--- crawl ---"
    agent = Mechanize.new
    text = agent.get(@url.url)
    urls_in_text = []
    text.links_with(:href => /^https?/).each do |link|
      urls_in_text << link.href
    end
    binding.pry
    urls_in_text
  end
end
