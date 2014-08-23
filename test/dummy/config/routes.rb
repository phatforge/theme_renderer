Rails.application.routes.draw do

  get "notes/index"

  resources :site do
    resources :post
  end

  resources :notes

  get "post/show"

  mount ThemeRenderer::Engine => "/theme_renderer"
end
