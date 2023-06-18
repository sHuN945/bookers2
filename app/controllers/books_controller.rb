class BooksController < ApplicationController
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path
    else
      @books = Book.all
      render :index
    end
  end
  
  def index
    flash[:notice] = "Welcome! You have signed up successfully."
    @book = Book.new
    @books = Book.all
    @user = current_user
  end 
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def show
    @book = Book.find(params[:id])
    @user = current_user
  end 
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "本当に消しますか？"
    redirect_to '/books'
  end 
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end 
end
