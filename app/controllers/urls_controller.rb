class UrlsController < ApplicationController

  def index
    @urls = Url.order(checked_at: :desc).last(100)
    render json: @urls
  end

  # def show
  #   render json: @auction
  # end

  def create
    @url = Url.find_or_create_by(url: url_params[:url])
    if @url.status==nil
      @url.status = "pending"
      @url.save
    end
    CrawUrlJob.perform_later @url
    return render json: @url, status: :created
    # CleanOldAuctionsJob.perform_later @auction
    # CleanOldAuctionsJob.set(wait_until: Date.tomorrow.noon).perform_later @auction
    # CleanOldAuctionsJob.set(wait: 1.minute).perform_later(@auction)

    # if @auction.save
    #   render json: @auction, status: :created
    # else
    #   render json: @auction.errors, status: :unprocessable_entity
    # end
  end

  # def update
  #   if @auction.update(auction_params)
  #     render json: @auction, status: :ok
  #   else
  #     render json: @auction.errors, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @auction.destroy
  # end

  private

  def set_url
    @url = Url.find(params[:id])
  end

  def url_params
    params.require(:url).permit(
      :id,
      :url,
      :checked_at,
      :status,
      :created_at,
      :updated_at
    )
  end
end
