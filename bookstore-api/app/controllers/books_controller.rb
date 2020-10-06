class BooksController < ApplicationController
  before_action -> { set_book({ id: params[:id] }) }, only: [:show]
  before_action -> { set_author({ name: payload["issue"]["title"] }) }, only: [:webhook]

  # POST /books/webhook
  def webhook    
    begin
      send(payload["action"])
    rescue NoMethodError
      render json: { error: I18n.t('errors.action.not_found', action: payload["action"]) }, status: :not_found && return
    end
  end

  # GET /books
  def index
    @books = Book.limit(params[:limit])

    render json: @books, include: ['author'], meta: { total: Book.count }
  end

  # GET /books/1
  def show
    render json: @book, include: ['publisher']
  end

  private
    def current_title
      begin
        @current_title ||= payload["changes"]["body"]["from"]
      rescue NoMethodError
        @current_title ||= payload["comment"]["body"]
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_book(args)
      begin
        @book ||= Book.find_by!(args)
      rescue ActiveRecord::RecordNotFound => execption
        render json: { error: execption }, status: :not_found
      end
    end

    def set_author(args)
      begin
        @author ||= Author.find_by!(args)
      rescue ActiveRecord::RecordNotFound => execption
        render json: { error: execption }, status: :not_found
      end
    end

    def payload
      @payload ||= JSON.parse(params[:payload])
    end

    def created
      @book = Book.new(title: current_title, author: @author, publisher: @author)

      if @book.save
        render json: @book, status: :created, location: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def edited
      set_book({ title: current_title, author_id: @author.id })

      if @book.update(title: payload["comment"]["body"])
        render json: @book, status: :ok, location: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def deleted
      set_book({ title: current_title, author_id: @author.id })

      @book.destroy
    end
end
