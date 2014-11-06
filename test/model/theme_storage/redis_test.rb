require 'test_helper'
require 'redis' # turn into redis_helper/redis support file

describe ThemeRenderer::ThemeStorage::Redis do

  subject { ThemeRenderer::ThemeStorage::Redis }

  let(:config_json) do
    { theme: { stores: ['ThemeRenderer::ThemeStorage::Redis'] },
      theme_id: 'dummy_1' }.to_json
  end
  let(:config) { ThemeRenderer::Config.from_json(config_json) }

  describe '#initialize_template' do
    let(:resolver) { ThemeRenderer::ThemeResolver.new(config) }

    before do
      @details  = { formats: [:html], locale: [:en], handlers: [:haml] }
      Redis.new(db: 5).set('/dummy_1/views/post/show.haml.html', 'poi')
    end

    it 'should return a template object' do
      template = resolver.find_templates('show', 'post', false, @details).first
      template.must_be_kind_of ActionView::Template
      template.source.must_match(/poi/)
      template.formats.must_equal [:html]
      template.virtual_path.must_equal 'post/show'
      template.handler.must_be_same_as Haml::Plugin
    end
  end
end
