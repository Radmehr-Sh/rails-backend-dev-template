# frozen_string_literal: true

class UtilitiesController < ApplicationController
  def health
    render json: { status: 'Healthy' }
  end

  def not_found
    render json: { status: 'Not Found' }, status: :not_found
  end
end
