class AuthorsController < ApplicationController
  before_action -> { set_author({ id: params[:id] }) }, only: [:show]

  # POST /authors/webhook
  def webhook
    begin
      send(payload["action"])
    rescue NoMethodError
      render json: { error: I18n.t('errors.action.not_found', action: payload["action"]) }, status: :not_found && return
    end
  end

  # GET /authors
  def index
    @authors = Author.all

    render json: @authors
  end

  # GET /authors/1
  def show
    render json: @author, include: ['books']
  end

  private
    def current_name
      begin
        @current_name ||= payload["changes"]["title"]["from"]
      rescue NoMethodError
        @current_name ||= payload["issue"]["title"]
      end
    end

    # Use callbacks to share common setup or constraints between actions.
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

    def opened
      @author = Author.new(name: payload["issue"]["title"], bio: payload["issue"]["body"])

      if @author.save
        render json: @author, status: :created, location: @author
      else
        render json: @author.errors, status: :unprocessable_entity
      end
    end

    def edited
      set_author({ name: current_name })

      if @author.update(name: payload["issue"]["title"], bio: payload["issue"]["body"])
        render json: @author, status: :ok, location: @author
      else
        render json: @author.errors, status: :unprocessable_entity
      end
    end

    def deleted
      set_author({ name: current_name })

      @author.destroy
    end
end
