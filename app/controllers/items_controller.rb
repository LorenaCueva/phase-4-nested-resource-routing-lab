class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    if params[:user_id]
      user = find_user
      render json: user.items, status: :ok
    else
    items = Item.all
    render json: items, include: :user, status: :ok
    end
  end

  def show
    items = Item.find(params[:id])
    render json: items, status: :ok
  end

  def create
      item = Item.create(item_params)
      render json: item, status: :created
  end

  private

  def not_found_response
    render json: {errors: "Record Not Found"}, status: :not_found
  end

  def find_user
    return User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
