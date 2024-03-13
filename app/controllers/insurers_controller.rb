class InsurersController < ApplicationController

  def index
    @insurers = Insurer.all
  end
end
