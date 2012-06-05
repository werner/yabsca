class HomeController < ApplicationController
  skip_before_filter :authorize
end
