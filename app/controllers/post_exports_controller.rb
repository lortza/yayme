# frozen_string_literal: true

class PostExportsController < ApplicationController
  def index
    filter_params = {
      timeframe: params[:timeframe],
      text: params[:text],
      with_people: params[:with_people],
      post_type_ids: params[:post_type_id]&.compact_blank,
      category_ids: params[:category_ids]&.compact_blank,
      bookmarked: params[:bookmarked] == '1'
    }

    filtered_posts = current_user.posts
                                 .includes(:categories)
                                 .filter_for_export(**filter_params)

    respond_to do |format|
      format.csv { send_data filtered_posts.to_csv }
    end
  end

  def new
  end

  def all
    respond_to do |format|
      format.html
      format.csv { send_data current_user.posts.to_csv }
    end
  end
end
