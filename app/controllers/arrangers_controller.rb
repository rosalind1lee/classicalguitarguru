class ArrangersController < ApplicationController
  def index
    matching_arrangers = Arranger.all

    @list_of_arrangers = matching_arrangers.order({ :created_at => :desc })

    render({ :template => "arrangers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_arrangers = Arranger.where({ :id => the_id })

    @the_arranger = matching_arrangers.at(0)

    render({ :template => "arrangers/show.html.erb" })
  end

  def create
    the_arranger = Arranger.new
    the_arranger.name = params.fetch("query_name")
    #the_arranger.pieces_count = params.fetch("query_pieces_count")

    if the_arranger.valid?
      the_arranger.save
      redirect_to("/arrangers", { :notice => "Arranger created successfully." })
    else
      redirect_to("/arrangers", { :notice => "Arranger failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_arranger = Arranger.where({ :id => the_id }).at(0)

    the_arranger.name = params.fetch("query_name")
    #the_arranger.pieces_count = params.fetch("query_pieces_count")

    if the_arranger.valid?
      the_arranger.save
      redirect_to("/arrangers/#{the_arranger.id}", { :notice => "Arranger updated successfully."} )
    else
      redirect_to("/arrangers/#{the_arranger.id}", { :alert => "Arranger failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_arranger = Arranger.where({ :id => the_id }).at(0)

    the_arranger.destroy

    redirect_to("/arrangers", { :notice => "Arranger deleted successfully."} )
  end
end
