class FavoritesController < ApplicationController
  def index
    if @current_user != nil
      matching_favorites = Favorite.where({ :user_id => @current_user.id })

      @list_of_favorites = matching_favorites.order({ :created_at => :desc })

      matching_pieces = Piece.all
      @list_of_pieces = matching_pieces
      render({ :template => "favorites/index.html.erb" })
    else

      redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end  
  end

  def show
    the_id = params.fetch("path_id")

    matching_favorites = Favorite.where({ :id => the_id })

    @the_favorite = matching_favorites.at(0)

    matching_pieces = Piece.all
    @list_of_pieces = matching_pieces

    if @current_user != nil
      render({ :template => "favorites/show.html.erb" })
    else
        redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end
  end

  def create
    the_favorite = Favorite.new
    the_favorite.piece_id = params.fetch("query_piece_id")
    the_favorite.user_id = @current_user.id

    if the_favorite.valid?
      the_favorite.save
      redirect_to("/favorites", { :notice => "Favorite created successfully." })
    else
      redirect_to("/favorites", { :notice => "Favorite failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_favorite = Favorite.where({ :id => the_id }).at(0)

    the_favorite.piece_id = params.fetch("query_piece_id")
    the_favorite.user_id = @current_user.id
    #the_favorite.user_id = params.fetch("query_user_id")

    if the_favorite.valid?
      the_favorite.save
      redirect_to("/favorites/#{the_favorite.id}", { :notice => "Favorite updated successfully."} )
    else
      redirect_to("/favorites/#{the_favorite.id}", { :alert => "Favorite failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_favorite = Favorite.where({ :id => the_id }).at(0)

    the_favorite.destroy

    redirect_to("/favorites", { :notice => "Favorite deleted successfully."} )
  end
end
