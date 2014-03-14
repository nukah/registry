class AnalyticsController < ApplicationController
  layout 'client_layout'
  before_filter :parse_query, only: [:index]
  def index
  end

  def fields

  end

  def search

  end

  private
  def parse_query
    @params = params
  end
end
