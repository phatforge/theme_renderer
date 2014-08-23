class NotesController < ApplicationController
  def index
  end

  def current_theme
    Site.where(theme_id: 'dummy_2').last
  end
end
