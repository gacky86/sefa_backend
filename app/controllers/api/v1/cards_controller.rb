class Api::V1::CardsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :set_flashcard
  before_action :set_card, only: %i[show update destroy]

  def index
    @cards = @flashcard.cards
    render json: @cards
  end

  def show
    render json: @card
  end

  def create
    @card = @flashcard.cards.build(card_params)
    if @card.save
      learning_factor = LearningFactor.new(card: @card)
      if learning_factor.save
        render json: { card: @card, learning_factor: learning_factor }, status: :ok
      else
        @card.destroy
        render json: { errors: learning_factor.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: @card.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: { errors: @card.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @card.destroy
    render json: { message: 'This card was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'card was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  def update_learning_factor
    card = Card.find(params[:id])
    difficulty = params[:difficulty]
    learning_mode = params[:learning_mode]

    begin
      card.learning_factor.update_by(difficulty: difficulty, mode: learning_mode)
      render json: { success: true, learning_factor: card.learning_factor }, status: :ok
    rescue StandardError
      render json: { success: false, errors: card.learning_factor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def fetch_review_interval
    card = Card.find(params[:id])
    learning_mode = params[:learning_mode]
    again_interval, hard_interval, good_interval, easy_interval = card.calc_review_intervals(mode: learning_mode)
    render json: { success: true,
                   intervals: { again_interval: again_interval, hard_interval: hard_interval, good_interval: good_interval,
                                easy_interval: easy_interval } }
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find(params[:flashcard_id])
  end

  def set_card
    @card = @flashcard.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:input_proficiency, :output_proficiency, :english, :japanese,
                                 :source_video_url, :reviewed_date, :source_video_timestamp, :difficulty, :learning_mode)
  end
end
