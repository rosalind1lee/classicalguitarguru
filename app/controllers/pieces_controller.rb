class PiecesController < ApplicationController
  def index
    matching_pieces = Piece.all

    @list_of_pieces = matching_pieces.order({ :created_at => :desc })


    @list_of_composers = Composer.all
    @list_of_arrangers = Arranger.all

    render({ :template => "pieces/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_pieces = Piece.where({ :id => the_id })

    @the_piece = matching_pieces.at(0)

    render({ :template => "pieces/show.html.erb" })
  end

  def create
    the_piece = Piece.new
    the_piece.title = params.fetch("query_title")
    the_piece.composer_id = params.fetch("query_composer_id")
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

  def update
    the_id = params.fetch("path_id")
    the_piece = Piece.where({ :id => the_id }).at(0)

    the_piece.title = params.fetch("query_title")
    the_piece.composer_id = params.fetch("query_composer_id")
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

  def destroy
    the_id = params.fetch("path_id")
    the_piece = Piece.where({ :id => the_id }).at(0)

    the_piece.destroy

    redirect_to("/pieces", { :notice => "Piece deleted successfully."} )
  end
end
