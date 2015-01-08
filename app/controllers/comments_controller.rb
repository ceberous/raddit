class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html {redirect_to @link, notice: "comment was created"}
      else
        format.html {render action: "new"}
      end

    end
    
  end


  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
