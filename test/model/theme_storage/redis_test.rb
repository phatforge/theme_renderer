require 'test_helper'

describe ThemeRenderer::ThemeStorage::Redis do

  subject { ThemeRenderer::ThemeStorage::Redis }

  let(:config_json) { { theme: {stores: ['Redis']},  theme_id: 'dummy_1' }.to_json }
  let(:config) { ThemeRenderer::Config.from_json(config_json) }

  describe '#initialize_template' do
    before(:each) do
      @details  = { formats: [:html], locale: [:en], handlers: [:haml] }
    end

    it 'should return a template object' do
      puts config
      record = ThemeRenderer::ThemeResolver.new(config).
        find_templates('show', 'post', false, @details).first
      subject.new(config).initialize_template(record).must_be_kind_of ActionView::Template
    end
  end
end
