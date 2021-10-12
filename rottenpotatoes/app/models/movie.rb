class Movie < ActiveRecord::Base
    def self.with_director(director_name)
        return Movie.where(:director => director_name)
    end
    
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
    
    def self.with_ratings(which_to_check)
        return Movie.where(:rating => which_to_check)
    end
    
    def self.with_title(title)
        return Movie.where(:title => title)
    end
end
