class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment].permit!)
    respond_to do |format|
      if @comment.save
        format.html { render partial: "show" }
        format.json { render json: @comment, status: :created}
      else
        format.html { render partial: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
end
