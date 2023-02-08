class AuctionsController < ApplicationController
  before_action :set_auction, only: %i[show update destroy]

  def index
    @auctions = Auction.all
    render json: @auctions
  end

  def show
    render json: @auction
  end

  def create
    @auction = Auction.new(auction_params)
    # CleanOldAuctionsJob.perform_later @auction
    # CleanOldAuctionsJob.set(wait_until: Date.tomorrow.noon).perform_later @auction
    # CleanOldAuctionsJob.set(wait: 1.minute).perform_later(@auction)

    if @auction.save
      render json: @auction, status: :created
    else
      render json: @auction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @auction.update(auction_params)
      render json: @auction, status: :ok
    else
      render json: @auction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @auction.destroy
  end

  private

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(
      :id,
      :title,
      :description,
      :start_date,
      :end_date,
      :reserved_price,
      :created_at,
      :updated_at
    )
  end
end