Rails.application.routes.draw do

  mount ThemeRenderer::Engine => "/theme_renderer"
end
