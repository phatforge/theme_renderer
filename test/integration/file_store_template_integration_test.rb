require_relative '../test_helper'

describe 'File store templates integration', :capybara do

  describe 'No theme configured specified' do
    it 'render posts/show from default rails view_paths' do
      visit post_show_path
      assert page.has_content? 'app/views/post/show.html.erb'
    end
  end

  describe 'Using site with no configured current method' do
    it 'render posts/index from theme file store' do
      site = Site.create!(name: 'Dummy 1', theme_id: 'dummy_1')
      visit site_post_index_path(site)
      assert page.has_content? 'POST Index View Template - Dummy 1 Theme'
    end
  end

  describe 'Using site with a configured current method' do
    it 'render notes/index from theme file store' do
      Site.create!(name: 'Dummy 2', theme_id: 'dummy_2')
      visit notes_index_path
      assert page.has_content? 'Dummy 2 Theme'
    end
  end
end
