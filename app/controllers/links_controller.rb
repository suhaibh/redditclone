class LinksController < ApplicationController
  before_action :set_link,            only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,  except: [:index, :show]
  before_action :set_subreddit,       only: [:new, :create, :show, :edit, :update]
  before_action :correct_user,        only: [:edit, :update, :destroy]
  

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
    # initialize user to link to profile
    @user = @link.user.name
    @comment = Comment.new
  end

  # GET /links/new
  def new
    @link = current_user.links.build
    @link.subreddit_id = @subreddit.id
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = current_user.links.build(link_params)
    @link.subreddit_id = @subreddit.id

    respond_to do |format|
      if @link.save
        format.html { redirect_to subreddit_link_path(@subreddit, @link), notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to subreddit_link_path(@subreddit, @link), notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    def set_subreddit
      @subreddit = Subreddit.find(params[:subreddit_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url, :description)
    end

    def correct_user
      current_link = current_user.links.find_by(id: @link.id)
      redirect_to subreddit_links_path, notice: "Not authorized to edit this link" if current_link.nil?
    end

end
