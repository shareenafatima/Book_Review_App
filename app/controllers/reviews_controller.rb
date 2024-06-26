class ReviewsController < ApplicationController
  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

 def show
 end

  def create
    @review = Review.new(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  def edit
    @review = Review.find(params[:id])
    render 'edit'
  end

  def update
    if @review.update(review_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy
    @book = @review.book

    # Delete the review
    if @review.destroy
      # Delete all reviews associated with the book
      @book.reviews.destroy_all
      redirect_to book_path(@book), notice: "Review and associated reviews were successfully deleted."
    else
      redirect_to book_path(@book), alert: "Failed to delete review and associated reviews."
    end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
