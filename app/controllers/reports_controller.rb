# frozen_string_literal: true

class ReportsController < ApplicationController
  def word_cloud
    search_params = {
      text: params[:text],
      year: params[:year],
      bookmarked: params[:bookmarked]
    }

    posts = current_user.posts.search(search_params)

    @words = Report.generate_word_cloud(posts: posts, minimum_count: 5)
  end

  def new_years_eve
    search_params = {
      year: Report.this_year
    }

    @celebrations = current_user.posts
                                .in_chronological_order
                                .search(search_params)
                                .for_gratitude_and_praise
                                .paginate(page: params[:page], per_page: 1)
  end
end
