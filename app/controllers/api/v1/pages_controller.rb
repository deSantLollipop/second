module Api
  module V1
    class PagesController < ApplicationController
      def about
        @text = 'We are Legion (c) Regular Daily Anonymous'
      end
      end
  end
end
