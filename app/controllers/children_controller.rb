class ChildrenController < ApplicationController
  before_action :set_child, only: [:edit, :update, :destroy]
  before_action :set_family, only: [:new, :edit, :update, :destroy]

  # def index
  #   @family = Family.find(params[:family_id])
  #   @children = Child.where(family: @family)
  # end

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(child_params)
    @child.family = Family.find(params[:family_id])
    if @child.save
      redirect_to family_path(@child.family)
    else
      @family = Family.find(params[:family_id])
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(child_params)
      redirect_to family_path(@family)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @child.destroy
    redirect_to family_path(@family)
  end

  private

  def child_params
    params.require(:child).permit(:name, :gender, :birthday, :family_id)
  end

  def set_child
    @child = Child.find(params[:id])
  end

  def set_family
    @family = Family.find(params[:family_id])
  end
end
