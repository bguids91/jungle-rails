class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user

    p current_user

    if @review.save
      flash[:notice] = 'Review was successfully created.'
      redirect_to product_path(@product)
    else
      flash[:notice] = "Error creating review: #{@review.errors}"
      redirect_to product_path(@product)
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description,
    )
  end

end
