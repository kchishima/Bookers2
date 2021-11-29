class BooksController < ApplicationController
  before_action :authenticate_user!
    def new
    end
    
    def index
     @book = Book.new
     @user = current_user 
     @books = Book.all
    end
    
    def create
     @user = current_user
     @book = Book.new(book_params)
     @book.user_id = current_user.id
     if @book.save
       redirect_to book_path(@book), notice: 'You have created book successfully.'
     else
       @books = Book.all
       flash.now[:alert]
       render :index
     end
    end
    def show
     @book = Book.find(params[:id])
     @user = @book.user
     @book_new = Book.new
    end
    
     def edit
     @book = Book.find(params[:id])
      if @book.user != current_user
       redirect_to books_path
      end
     
     end
    
     def update
      @book = Book.find(params[:id])
      if @book.update(book_params)
      redirect_to book_path(@book), notice: 'You have created book successfully.'
      else
      render :edit
      end
     end
     
     def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
     end
     
  private
   def book_params
    params.require(:book).permit(:title, :body)
   end

 
end
