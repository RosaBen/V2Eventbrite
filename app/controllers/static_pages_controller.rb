class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  def Home
  end
end
