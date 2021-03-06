class ExamplesController < ApplicationController
  before_action :set_phrase!, only: [:create, :destroy, :vote]
  before_action :set_example!, only: [:destroy, :vote, except: :index]
  def index
  end

  def show
    @example = Example.find(params[:id])
  end

  def create
    @example = @phrase.examples.new(example_params)
    if @example.save
      flash[:notice] = 'Example has been created'
    else
      flash[:danger] = @phrase.errors.full_messages.to_sentence
    end
      redirect_to phrase_path(@phrase)
  end

  def destroy
    @example.destroy
    flash[:notice] = 'Example has been deleted!'
    redirect_back(fallback_location: phrase_path(@phrase.id))
  end

  def vote
    @example = @phrase.examples.find_by(id: params[:example_id])
    shared_vote(@example)
    redirect_back fallback_location: phrase_path(@phrase.id)
  end

  private

  def example_params
    params.require(:example).permit(:example, :user_id, :phrase_id)
  end

  def set_phrase!
    @phrase = Phrase.friendly.find(params[:phrase_id])
  end

  def set_example!
    @example = @phrase.examples.find_by(id: params[:id])
  end

end
