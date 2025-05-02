class Api::V1::FlashcardsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :authenticate_api_v1_user!
  def index
    flashcards = if params[:only_mine]
                   current_api_v1_user.flashcards
                 else
                   Flashcard.all
                 end
    render json: flashcards
  end

  def show
    render json: Flashcard.find(params[:id])
  end

  def create
    flashcard = Flashcard.new(flashcard_params)
    flashcard.user = current_api_v1_user
    if flashcard.save
      render json: flashcard
    else
      render json: { errors: flashcard.errors }, status: :unprocessable_entity
    end
  end

  def update
    flashcard = Flashcard.find(params[:id])
    if flashcard.update(flashcard_params)
      render json: flashcard
    else
      render json: { errors: flashcard.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    flashcard = Flashcard.find(params[:id])
    flashcard.destroy
    render json: { message: 'This flashcard was successfuly deleted!' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'flashcard was not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.errors }, status: :unprocessable_entity
  end

  def fetch_card_to_learn
    flashcard = Flashcard.find(params[:id])
    learning_mode = params[:learning_mode]
    card_to_learn = flashcard.select_card_by_interval(mode: learning_mode)
    render json: card_to_learn, status: :ok
    # if card_to_learn
    #   render json: card_to_learn, status: :ok
    # else
    #   render json: { message: '本日学習するカードはありません' }, status: :ok
    # end
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:user_id, :title, :description, :shared, :input_target, :output_target,
                                      :only_mine, :learning_mode)
  end
end
