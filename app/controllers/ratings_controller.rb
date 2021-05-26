class RatingsController < ApplicationController
  def index
    matching_ratings = Rating.all

    @list_of_ratings = matching_ratings.order({ :created_at => :desc })

    matching_pieces = Piece.all
    @list_of_pieces = matching_pieces

    if @current_user != nil
      render({ :template => "ratings/index.html.erb" })
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end  
  end

  def show
    the_id = params.fetch("path_id")

    matching_ratings = Rating.where({ :id => the_id })

    @the_rating = matching_ratings.at(0)

    if @current_user != nil
      render({ :template => "ratings/show.html.erb" })
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end  
  end

  def create
    the_rating = Rating.new
    the_rating.user_id = @current_user.id
    #the_rating.user_id = params.fetch("query_user_id")
    the_rating.score = params.fetch("query_score")
    #the_rating.piece_id = @the_piece.id
    the_rating.piece_id = params.fetch("query_piece_id")

    if the_rating.valid?
      the_rating.save
      redirect_to("/ratings", { :notice => "Rating created successfully." })
    else
      redirect_to("/ratings", { :notice => "Rating failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)

    #the_rating.user_id = params.fetch("query_user_id")
    the_rating.user_id = @current_user.id
    the_rating.score = params.fetch("query_score")
    the_rating.piece_id = params.fetch("query_piece_id")

    if the_rating.valid?
      the_rating.save
      redirect_to("/ratings/#{the_rating.id}", { :notice => "Rating updated successfully."} )
    else
      redirect_to("/ratings/#{the_rating.id}", { :alert => "Rating failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)

    the_rating.destroy

    redirect_to("/ratings", { :notice => "Rating deleted successfully."} )
  end
end
