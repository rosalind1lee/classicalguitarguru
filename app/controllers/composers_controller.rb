class ComposersController < ApplicationController
  def index
    matching_composers = Composer.all

    @list_of_composers = matching_composers.order({ :created_at => :desc })

    render({ :template => "composers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_composers = Composer.where({ :id => the_id })

    @the_composer = matching_composers.at(0)

    render({ :template => "composers/show.html.erb" })
  end

  def create
    the_composer = Composer.new
    the_composer.name = params.fetch("query_name")
    the_composer.era = params.fetch("query_era")
    the_composer.pieces_count = params.fetch("query_pieces_count")

    if the_composer.valid?
      the_composer.save
      redirect_to("/composers", { :notice => "Composer created successfully." })
    else
      redirect_to("/composers", { :notice => "Composer failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_composer = Composer.where({ :id => the_id }).at(0)

    the_composer.name = params.fetch("query_name")
    the_composer.era = params.fetch("query_era")
    the_composer.pieces_count = params.fetch("query_pieces_count")

    if the_composer.valid?
      the_composer.save
      redirect_to("/composers/#{the_composer.id}", { :notice => "Composer updated successfully."} )
    else
      redirect_to("/composers/#{the_composer.id}", { :alert => "Composer failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_composer = Composer.where({ :id => the_id }).at(0)

    the_composer.destroy

    redirect_to("/composers", { :notice => "Composer deleted successfully."} )
  end
end
