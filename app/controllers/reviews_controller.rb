require 'pry'

class ReviewsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if (current_user && current_user.id != @restaurant.user.id)
      @review = Review.new
    elsif (current_user && current_user.id == @restaurant.user.id)
      redirect_to "/restaurants/#{params[:restaurant_id]}", alert: "Sorry, you cannot review your own restaurant"
    else
      redirect_to user_session_path, alert: "Please log in to add a review"
    end
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.create(review_params)
    @review.user = current_user

    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      if @review.errors[:user]
        redirect_to restaurant_path(@restaurant), alert: "You have already reviewed this restaurant"
      else
      render "new"
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@restaurant)
  end

  def show
    @review = Review.find(params[:id])
  end

  def index
    @reviews = Review.where(restaurant_id: params[:restaurant_id])
  end

  private

  def review_params
    params.require(:review).permit(:review, :rating)
  end

end
