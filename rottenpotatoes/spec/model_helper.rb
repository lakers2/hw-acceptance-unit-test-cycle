require 'rails_helper'

describe Movie do 
    describe 'has matched director' do
        it "should find movies from the same director" do
            Movie.create(:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000', :director => 'Hans')
            Movie.create({:title => 'Raiders of the Lost Ark', :rating => 'PG', :release_date => '12-Jun-1981', :director => 'Hans'})
            expect(Movie.with_title("123")).not_to exist
            expect(Movie.with_title("Chicken Run")).to exist
            expect(Movie.with_title("Raiders of the Lost Ark")).to exist
            expect(Movie.with_director("Hans")).to exist
        end
    end
    describe 'no matched director' do
        it "should redirect to home page" do
            Movie.create(:title => 'Chicken Run', :rating => 'G', :release_date => '21-Jun-2000', :director => 'Hans')
            expect(Movie.with_director("Bob")).not_to exist
        end
    end
end