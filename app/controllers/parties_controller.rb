class PartiesController < ApplicationController
    def index
        if params[:category_id] && Category.exists?(params[:category_id])
            @category = Category.find_by(id: params[:category_id])
            @parties = @category.parties
        else
            @parties = Party.all
        end

    end

    def new
        @party = Party.new(name: 'Halloween')
        @party.build_category

        3.times { @party.supplies.build } 
    end

    def create
        @party = Party.new(party_params)
        if @party.save 
            redirect_to party_path(@party)
        else
            render :new
        end
    end

    def show
        @party = Party.find(params[:id])
    end
    
    private
    
    def party_params
        params.require(:party).permit(:date, :budget, :name, :category_id, category_attributes: [:name], supplies_attributes: [:name]) 
    end
end
