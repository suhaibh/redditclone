class SubredditsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:destroy, :edit]

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
    @subreddit = Subreddit.find(params[:id])
    if @subreddit.update(subreddit_params)
      flash[:notice] = "Subreddit updated!"
      redirect_to @subreddit
    else
      render 'edit'
    end
  end

  def destroy
    @subreddit = Subreddit.find(params[:id])
    @subreddit.destroy
    redirect_to root_path
  end

  private
    def subreddit_params
      params.require(:subreddit).permit(:title, :description)
    end

    def correct_user
      @subreddit = Subreddit.find(params[:id])
      current_subreddit = current_user.subreddits.find_by(id: params[:id])
      redirect_to subreddit_path(@subreddit), notice: "Not authorized to edit this subreddit" if current_subreddit.nil?
    end
end
