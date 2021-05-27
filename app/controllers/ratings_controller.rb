class RatingsController < ApplicationController
  def index
    if @current_user != nil

      matching_ratings = Rating.where({ :user_id => @current_user.id })

      @list_of_ratings = matching_ratings.order({ :created_at => :desc })

      matching_pieces = Piece.all
      @list_of_pieces = matching_pieces

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
      if @the_rating.user_id != @current_user.id
        redirect_to("/user_sign_in", { :alert => "You must be logged in as the rating owner to view this page."})
      else
        render({ :template => "ratings/show.html.erb" })
      end
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end  
  end

  def create
    the_piece_id = params.fetch("query_piece_id")
    the_user_id = @current_user.id
    rate = Rating.where({ :user_id => the_user_id }).where({ :piece_id => the_piece_id}).at(0)

    if rate == nil
      the_rate = Rating.new
      the_rate.user_id = the_user_id
      the_rate.piece_id = the_piece_id
      the_rate.score = params.fetch("query_score")
      if the_rate.valid?
        the_rate.save
        redirect_to("/ratings", { :notice => "Rating created successfully." })
      else
        redirect_to("/ratings", { :alert => "Rating failed to create successfully." })
      end
    else
      redirect_to("/ratings", { :alert => "You have already rated this piece." })
    end


  end

  def update
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)

    the_piece_id = params.fetch("query_piece_id")
    the_user_id = @current_user.id

    rate = Rating.where({ :user_id => the_user_id }).where({ :piece_id => the_piece_id}).at(0)

    if rate == nil
      the_rating.user_id = the_user_id
      the_rating.piece_id = the_piece_id
      the_rating.score = params.fetch("query_score")
      if the_rate.valid?
        the_rate.save
        redirect_to("/ratings", { :notice => "Rating created successfully." })
      else
        redirect_to("/ratings", { :alert => "Rating failed to create successfully." })
      end
    else
      redirect_to("/ratings", { :alert => "You have already rated this piece." })
    end

  end

  def destroy
    the_id = params.fetch("path_id")
    the_rating = Rating.where({ :id => the_id }).at(0)

    if @current_user && the_rating.user_id == @current_user.id
      the_rating.destroy
      redirect_to("/ratings", { :notice => "Rating deleted successfully."} )
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to perform this action."})
    end
  end
end
