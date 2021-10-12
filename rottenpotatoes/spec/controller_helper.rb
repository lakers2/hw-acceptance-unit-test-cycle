require 'rails_helper'

# the idea comes from https://github.com/rails/rails/issues/34790#issuecomment-450502805
if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe MoviesController, type: :controller do 
  describe 'has director' do
    it "should find movies from the same director" do
      movie = Movie.create(:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000', :director => 'Hans')
      get :same, id: movie
      expect(Movie.with_title("Chicken Run")).to exist
      expect(Movie.with_title("Chicken")).not_to exist
      expect(response).to render_template :same
    end
  end
  describe 'no director' do
    it "should go to the home page" do
      movie = Movie.create(:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000', :director => '')
      get :same, id: movie
      expect(response).to redirect_to(movies_path)
    end
  end
end