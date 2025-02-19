# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    search_params = {
      text: params[:text],
      year: params[:year],
      bookmarked: params[:bookmarked]
    }

    @posts = current_user.posts
      .includes(:categories)
      .search(**search_params)
      .by_date
      .paginate(page: params[:page], per_page: 50)
  end

  def new
    @post = current_user.posts.new(
      date: Time.zone.today,
      post_type_id: params[:post_type_id]
    )
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_type_url(id: @post.post_type.id)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_type_url(id: @post.post_type.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    notice = "#{@post.date} #{@post.post_type_name} was successfully deleted."
    redirect_to post_type_url(id: @post.post_type.id), notice: notice
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
        :with_people,
        :image,
        :remove_attached_image,
        :url,
        category_ids: [])
  end
end
