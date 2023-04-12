# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_sentry_context
  before_action :authenticate_user!

  # New Configs: https://docs.sentry.io/platforms/ruby/migration/
  def set_sentry_context
    Sentry.set_user(id: session[:current_user_id]) # or anything else in session
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end
end
