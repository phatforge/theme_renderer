Rails.application.routes.draw do

  resources :site do
    resources :post
  end

  get "post/show"

  mount ThemeRenderer::Engine => "/theme_renderer"
end
