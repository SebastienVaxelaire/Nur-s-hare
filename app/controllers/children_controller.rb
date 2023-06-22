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

  def edit
    @family = Family.find(params[:family_id])
    @child = Child.find(params[:id])
  end

  def update
    @family = Family.find(params[:family_id])
    @child = Child.find(params[:id])
    if @child.update(child_params)
      redirect_to family_path(@family)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @family =current_user.family
    @child = Child.find(params[:id])
    @child.destroy
    redirect_to family_path(@family)
  end

  private

  def child_params
    params.require(:child).permit(:name, :gender, :birthday)
  end
end
