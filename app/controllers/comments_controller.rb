class CommentsController < ApplicationController
  def index
    if @current_user != nil
      matching_comments = Comment.where({ :user_id => @current_user.id })
      @list_of_comments = matching_comments.order({ :updated_at => :desc })
      
      matching_pieces = Piece.all
      @list_of_pieces = matching_pieces
      render({ :template => "comments/index.html.erb" })
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end 
  end

  def show
    the_id = params.fetch("path_id")
    matching_comments = Comment.where({ :id => the_id })
    @the_comment = matching_comments.at(0)
    if @current_user != nil 
      if @the_comment.user_id != @current_user.id
        redirect_to("/user_sign_in", { :alert => "You must be logged in as the comment author to view this page."})
      else
        matching_pieces = Piece.all
        @list_of_pieces = matching_pieces
        render({ :template => "comments/show.html.erb" })
      end
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end
  end

  def create
    the_comment = Comment.new
    the_comment.piece_id = params.fetch("query_piece_id")
    the_comment.user_id = @current_user.id
    the_comment.comment_text = params.fetch("query_comment_text")

    if the_comment.valid?
      the_comment.save
      flash[:notice] = "Comment created successfully."
      redirect_back(fallback_location: "/comments/#{the_comment.id}")
      #redirect_to("/pieces/#{the_comment.piece_id}", { :notice => "Comment created successfully." })
    else
      flash[:alert] = "Comment failed to create successfully."
      redirect_back(fallback_location: "/comments")
      #redirect_to("/pieces/#{the_comment.piece_id}", { :notice => "Comment failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)

    the_comment.piece_id = the_comment.piece_id
    the_comment.user_id = @current_user.id
    the_comment.comment_text = params.fetch("query_comment_text")

    if the_comment.valid?
      the_comment.save
      flash[:notice] = "Comment updated successfully."
      redirect_back(fallback_location: "/comments/#{the_comment.id}")
      #redirect_to :back, notice: "Comment updated successfully."
      #redirect_to("/comments/#{the_comment.id}", { :notice => "Comment updated successfully."} )
    else
      flash[:alert] = "Comment failed to update successfully."
      redirect_back(fallback_location: "/comments/#{the_comment.id}")
      #redirect_to("/comments/#{the_comment.id}", { :alert => "Comment failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_comment = Comment.where({ :id => the_id }).at(0)

    if @current_user && the_comment.user_id == @current_user.id
      the_comment.destroy
      redirect_to("/comments", { :notice => "Comment deleted successfully."} )
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to perform this action."})
    end
  end
end
