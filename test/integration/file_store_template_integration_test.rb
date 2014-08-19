require_relative '../test_helper'

describe 'File store templates integration', :capybara do

  describe 'No site specified' do
    it 'render posts/show from default view_paths' do
      visit post_show_path
      assert page.has_content? 'app/views/post/show.html.erb'
    end
  end

  describe 'Using site with no current_site method' do
    it 'render posts/show from file store' do
      site = Site.create!(name: 'Dummy 1', theme_id: 'dummy_1')
      visit site_post_index_path(site)
      assert page.has_content? 'POST Index View Template - Dummy 1 Theme'
    end
  end

  describe 'Using site with a current_site method' do
    it 'render posts/show from file store' do
      site = Site.create!(name: 'Dummy 1', theme_id: 'dummy_1')
      visit site_post_index_path(site)
      assert page.has_content? 'Dummy 1 Theme'
    end
  end
end
