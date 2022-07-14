Rails.application.routes.draw do
  get 'line_item_dates/new'
  get 'line_item_dates/create'
  get 'line_item_date/new'
  get 'line_item_date/create'
  root to: "pages#home"
  devise_for :users
  resources :quotes do
    resources :line_item_dates, except: [:index, :show] do
      resources :line_items, except: [:index, :show]
    end
  end
end
