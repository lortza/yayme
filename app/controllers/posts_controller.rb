# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    search_terms = params[:search]
    given_year = params[:given_year]

    @posts = current_user.posts
                         .includes(:categories)
                         .search(given_year: given_year, search_terms: search_terms)
                         .by_date
                         .paginate(page: params[:page], per_page: 50)
  end

  def new
    @post = current_user.posts.new(date: Time.zone.today)
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_url
      # redirect_back(fallback_location: posts_url,
      #               notice: "#{@post.date} #{@post.post_type_name} was successfully created.")
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_url
      # redirect_back(fallback_location: posts_url,
      #               notice: "#{@post.date} #{@post.post_type_name} was successfully updated.")
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "#{@post.date} #{@post.post_type_name} was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post)
          .permit(:post_type_id,
                  :bookmarked,
                  :date,
                  :description,
                  :given_by,
                  :image_url,
                  :url,
                  category_ids: [])
  end
end