class CleanOldAuctionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    @auction.destroy
  end
end
