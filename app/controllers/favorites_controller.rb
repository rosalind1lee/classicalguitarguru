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
      if @the_favorite == nil or @the_favorite.user_id != @current_user.id
        redirect_to("/user_sign_in", { :alert => "You must be logged in as the favorite owner to view this page."})
      else
        render({ :template => "favorites/show.html.erb" })
      end
    else
        redirect_to("/user_sign_in", { :alert => "You must be logged in to view this page."})
    end
  end

  def create
    
    the_piece_id = params.fetch("query_piece_id")
    piece_title = the_piece_id.split("-")[0].strip
    composer_name = the_piece_id.split("-")[1].strip

    the_composer = Composer.where({ :name => composer_name }).at(0)
    the_piece = Piece.where({ :title => piece_title }).where({ :composer_id => the_composer.id }).at(0)
    the_user_id = @current_user.id

    if the_piece == nil
      redirect_to("/favorites", { :alert => "Piece has not been added to our collection yet." })
    else
      fav = Favorite.where({ :user_id => the_user_id }).where({ :piece_id => the_piece.id}).at(0)

      if fav == nil
        the_favorite = Favorite.new
        the_favorite.user_id = the_user_id
        the_favorite.piece_id = the_piece.id
        if the_favorite.valid?
          the_favorite.save
          redirect_to("/favorites", { :notice => "Favorite created successfully." })
        else
          redirect_to("/favorites", { :alert => "Favorite failed to create successfully." })
        end
      else
        redirect_to("/favorites", { :alert => "Piece is already in your favorites." })
      end
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_favorite = Favorite.where({ :id => the_id }).at(0)

    the_piece_id = params.fetch("query_piece_id")
    piece_title = the_piece_id.split("-")[0].strip
    composer_name = the_piece_id.split("-")[1].strip
    the_user_id = @current_user.id

    the_composer = Composer.where({ :name => composer_name }).at(0)
    the_piece = Piece.where({ :title => piece_title }).where({ :composer_id => the_composer.id }).at(0)
    the_user_id = @current_user.id

    if the_piece == nil
      redirect_to("/favorites", { :alert => "Piece has not been added to our collection yet." })
    else
      fav = Favorite.where({ :user_id => the_user_id }).where({ :piece_id => the_piece.id}).at(0)

      if fav == nil
        the_favorite.piece_id = the_piece.id
        the_favorite.user_id = the_user_id
        if the_favorite.valid?
          the_favorite.save
          redirect_to("/favorites/#{the_favorite.id}", { :notice => "Favorite updated successfully."} )
        else
          redirect_to("/favorites/#{the_favorite.id}", { :alert => "Favorite failed to update successfully." })      
        end
      else
        redirect_to("/favorites/#{the_favorite.id}", { :alert => "Piece is already in your favorites." })
      end
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_favorite = Favorite.where({ :id => the_id }).at(0)

    if @current_user && the_favorite.user_id == @current_user.id
      the_favorite.destroy
      redirect_to("/favorites", { :notice => "Favorite deleted successfully."} )
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to perform this action."})
    end
  end
end
