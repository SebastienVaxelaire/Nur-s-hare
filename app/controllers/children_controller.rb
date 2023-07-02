class ChildrenController < ApplicationController
  before_action :set_child, only: [:edit, :update, :destroy]
  before_action :set_family, only: [:new, :edit, :update]

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
    authorize @child
    if @child.save
      redirect_to family_path(@child.family), notice: 'Enfant ajouté avec succès !'
    else
      @family = Family.find(params[:family_id])
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(child_params)
      redirect_to family_path(@family), notice: 'Enfant mis à jour avec succès !'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @family = current_user.family
    @child.destroy
    redirect_to family_path(@family)
  end

  private

  def child_params
    params.require(:child).permit(:name, :gender, :birthday, :family_id, :photo)
  end

  def set_child
    @child = Child.find(params[:id])
    authorize @child
  end

  def set_family
    @family = Family.find(params[:family_id])
    authorize @family
  end
end
