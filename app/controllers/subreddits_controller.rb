class SubredditsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def new
    @subreddit = Subreddit.new
  end

  def create
    @subreddit = Subreddit.new(subreddit_params)
    if @subreddit.save
      flash[:notice] = "Subreddit created!"
      redirect_to @subreddit
    else
      render 'new'
    end
  end

  def show
    @subreddit = Subreddit.find(params[:id])
  end

  def edit
    @subreddit = Subreddit.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    def subreddit_params
      params.require(:subreddit).permit(:title, :description)
    end
end
