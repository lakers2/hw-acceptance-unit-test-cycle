Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get '/movies/same/:id', to: 'movies#same', as: 'same_directors'
end
