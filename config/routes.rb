Flexite::Engine.routes.draw do
  resources :entries
  resources :hash_entries, controller: :entries
  resources :bool_entries, controller: :entries
  resources :int_entries, controller: :entries
  resources :str_entries, controller: :entries
  resources :sym_entries, controller: :entries
  resources :arr_entries, controller: :entries
  resources :configs
  resources :sections

  root to: 'sections#index'
end
