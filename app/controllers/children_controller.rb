class ChildrenController < ApplicationController
  # def index
  #   @family = Family.find(params[:family_id])
  #   @children = Child.where(family: @family)
  # end

  def new
    @family = Family.find(params[:family_id])
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    @child.family = Family.find(params[:family_id])
    if @child.save
      redirect_to family_path(@child.family)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def child_params
    params.require(:child).permit(:name, :gender, :birthday)
  end
end
