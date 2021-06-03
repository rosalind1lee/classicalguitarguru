class PiecesController < ApplicationController
  def index
    matching_pieces = Piece.all

    @list_of_pieces = Piece.order(:title).page params[:page]
    #@list_of_pieces = matching_pieces.order({ :created_at => :desc })


    @list_of_composers = Composer.all
    @list_of_arrangers = Arranger.all

    render({ :template => "pieces/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_pieces = Piece.where({ :id => the_id })

    @the_piece = matching_pieces.at(0)

    @list_of_composers = Composer.all
    @list_of_arrangers = Arranger.all
    @list_of_comments = Comment.where({ :piece_id => the_id}).order({ :updated_at => :desc })
    
    if @current_user
      @rating_exists = Rating.where({ :piece_id => the_id }).where({ :user_id => @current_user.id }).at(0)
      @fav = Favorite.where({ :user_id => @current_user.id }).where({ :piece_id => the_id}).at(0)
    end

    render({ :template => "pieces/show.html.erb" })
  end

  def create
    composer_name = params.fetch("query_composer_id")
    the_composer = Composer.where({ :name => composer_name }).at(0)

    if the_composer == nil
      redirect_to("/composers", { :alert => "Composer has not been added to our collection yet." })
    else
      the_piece = Piece.new
      the_piece.title = params.fetch("query_title")
      the_piece.composer_id = the_composer.id
      the_piece.arranger_id = params.fetch("query_arranger_id")
      #the_piece.ratings_count = params.fetch("query_ratings_count")
      #the_piece.favorites_count = params.fetch("query_favorites_count")
      #the_piece.comments_count = params.fetch("query_comments_count")

      if the_piece.valid?
        the_piece.save
        redirect_to("/pieces", { :notice => "Piece created successfully." })
      else
        redirect_to("/pieces", { :notice => "Piece failed to create successfully." })
      end
    end
  end

  def update
    composer_name = params.fetch("query_composer_id")
    the_composer = Composer.where({ :name => composer_name }).at(0)

    if the_composer == nil
      redirect_to("/composers", { :alert => "Composer has not been added to our collection yet." })
    else

      the_id = params.fetch("path_id")
      the_piece = Piece.where({ :id => the_id }).at(0)

      the_piece.title = params.fetch("query_title")
      the_piece.composer_id = the_composer.id
      the_piece.arranger_id = params.fetch("query_arranger_id")
      #the_piece.ratings_count = params.fetch("query_ratings_count")
      #the_piece.favorites_count = params.fetch("query_favorites_count")
      #the_piece.comments_count = params.fetch("query_comments_count")

      if the_piece.valid?
        the_piece.save
        redirect_to("/pieces/#{the_piece.id}", { :notice => "Piece updated successfully."} )
      else
        redirect_to("/pieces/#{the_piece.id}", { :alert => "Piece failed to update successfully." })
      end
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_piece = Piece.where({ :id => the_id }).at(0)

    if @current_user
      the_piece.destroy
      redirect_to("/pieces", { :notice => "Piece deleted successfully."} )
    else
      redirect_to("/user_sign_in", { :alert => "You must be logged in to perform this action."})
    end
  end
end
