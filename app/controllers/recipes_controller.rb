class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id)
    @user = User.find(current_user.id)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @user = User.find(current_user.id)
    @recipe = Recipe.find(params[:id])
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @user = User.find(current_user.id)
  end

  def public
    @recipes = Recipe.includes([:user]).where(public: true).order(created_at: :desc)
    @user = User.find(current_user.id)
  end

  # GET /recipes/1/edit
  def edit
    @user = User.find(current_user.id)
    @recipe = Recipe.find(params[:id])
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    @user = current_user
    @recipe = Recipe.find(params[:id])
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to user_recipe_path(current_user, @recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @user = current_user
    @recipe = Recipe.find(params[:id])
    authorize! :destroy, @recipe
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_recipes_path, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
