class Api::V1::CardsController < ApplicationController
  # skip_before_action :authenticate_user!
  def index
    render json: Card.order(updated_at: :desc)
  end

  def show
    render json: Card.find(params[:id])
  end

  def create
    card = Card.new(card_params)
    if card.save
      render json: card
    else
      render json: { errors: card.errors }, status: :unprocessable_entity
    end
  end

  def update
    card = Card.find(params[:id])
    if card.update(card_params)
      render json: card
    else
      render json: { errors: card.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    card = Card.find(params[:id])
    card.destroy
    render json: { message: 'This card was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'card was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  private

  def card_params
    params.require(:card).permit(:flashcard_id, :input_proficiency, :output_proficiency, :english, :japanese,
                                 :source_video_url, :reviewed_date, :source_video_timestamp)
  end
end
