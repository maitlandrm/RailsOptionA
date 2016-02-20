Rails.application.routes.draw do
  root 'notsessions#index'

  get '/notsessions/new' => 'notsessions#new'
  post '/notsessions' => 'notsessions#create'
  delete '/notsessions' => 'notsessions#destroy'

  get '/lenders/:id' => 'lenders#show'
  post '/lenders' => 'lenders#create'

  get '/borrowers/:id' => 'borrowers#show'
  post '/borrowers' => 'borrowers#create'

  post '/histories' => 'histories#create'
end
