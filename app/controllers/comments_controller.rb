class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # POST /comments
  # POST /comments.json
  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.build(comment_params)
    @comment.user = current_user
    @subreddit = Subreddit.find(params[:subreddit_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@subreddit, @link], notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to(subreddit_link_path(@subreddit, @link), {flash: {error: "Comment failed to post"}}) }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
