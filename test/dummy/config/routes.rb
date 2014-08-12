Rails.application.routes.draw do

  get "post/show"

  mount ThemeRenderer::Engine => "/theme_renderer"
end
