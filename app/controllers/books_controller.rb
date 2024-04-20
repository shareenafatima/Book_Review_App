class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[index show]
  # GET /books or /books.json
  def index
    if params[:search].present?
      @books = Book.includes(:reviews)
                   .where("title LIKE ? OR category LIKE ? OR author LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
                   .order(reviews_count: :desc)
    else
      if params[:category].present?
        @category = Category.find_by(name: params[:category])
        @books = @category.books.includes(:reviews)
                     .order(reviews_count: :desc)
      else
        @books = Book.includes(:reviews).order(reviews_count: :desc)
      end
    end
  end



  def show
    @book = Book.find(params[:id])
    @review = @book.reviews.find_by(id: params[:review_id])
    @average_rating = @book.reviews.average(:rating)

  end
  # GET /books/1 or /books/1.json
  # def show
  # end

  # GET /books/new
  def new
    @book = current_user.books.build
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  # GET /books/1/edit
  def edit
    @categories = Category.all.map{|c| [c.name, c.id]}
  end

  # POST /books or /books.json
  def create
    @book = current_user.books.build(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :description, :author, :publication_year, :category_id, :image)
    end
end
