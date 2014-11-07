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

    let(:details) do
      { formats: [:html], locale: [:en], handlers: [:haml] }
    end
    let(:partial_templ) do
      { source: 'ioppoi', updated_at: Time.now.utc,
                format: :html, path: 'post/partial',
                handler: :erb, locale: :en }
    end
    let(:templ) do
      { source: 'poi', updated_at: Time.now.utc,
                format: :html, path: 'post/show',
                handler: :haml, locale: :en }
    end

    before do
    end

    it 'should return a template object' do
      redis_record = templ.merge(details)
      redis_key = '/dummy_1/views/post/show.haml.html'
      redis_record_hash = *(redis_record.map { |k, v| [k, v] }.flatten)

      Redis.new(db: 5).del(redis_key)
      Redis.new(db: 5).hmset(redis_key, redis_record_hash)

      template = resolver.find_templates('show', 'post', false, details).first
      template.must_be_kind_of ActionView::Template
      template.source.must_equal 'poi'
      template.formats.must_equal [:html]
      template.virtual_path.must_equal 'post/show'
      template.handler.must_be_same_as Haml::Plugin
      template.updated_at.to_s.must_equal templ[:updated_at].to_s
    end

    it 'should return a partial template object' do
      redis_record = partial_templ.merge(details)
      redis_key = '/dummy_1/views/post/_partial.haml.html'
      redis_record_hash = *(redis_record.map { |k, v| [k, v] }.flatten)

      Redis.new(db: 5).del(redis_key)
      Redis.new(db: 5).hmset(redis_key, redis_record_hash)

      template = resolver.find_templates('partial', 'post', true, details).first
      template.must_be_kind_of ActionView::Template
      template.source.must_equal 'ioppoi'
      template.formats.must_equal [:html]
      template.virtual_path.must_equal 'post/partial'
      template.handler.must_be_instance_of ActionView::Template::Handlers::ERB
      template.updated_at.to_s.must_equal templ[:updated_at].to_s
    end
  end
end
