class ReporterController < ApplicationController
  before_action :decode_query, only: [:index]
  def index
  end

  private
  def decode_query
    params[:q]
  end
end
