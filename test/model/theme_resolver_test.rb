require 'test_helper'

describe ThemeRenderer::ThemeResolver do

  subject { ThemeRenderer::ThemeResolver }

  let(:config_base) { ThemeRenderer::Config.new }

  let(:config_json) { { stores: 'File',  theme_id: 'dummy_1' }.to_json }
  let(:config) { ThemeRenderer::Config.from_json(config_json) }

  describe "#find_templates" do
    before(:each) do
      @resolver = subject.new(config)
      @details  = { formats: [:html], locale: [:en], handlers: [:haml] }
    end

    it "must be empty when there is no template" do
      @resolver = subject.new(config_base)
      @resolver.find_all('edit', 'post', false, @details).must_be_empty
    end

    it "returns an ActionView::Template instance" do
      template = @resolver.find_all('show', 'post', false, @details).first
      template.must_be_kind_of ActionView::Template
    end

    it "returns a template with the correct details" do
      template = @resolver.find_all('show', 'post', false, @details).first
      template.source.must_match /POST SHOW View Template - Dummy 1 Theme/
      template.formats.must_equal [:html]
      template.virtual_path.must_equal 'post/show'
      template.handler.must_be_same_as Haml::Plugin
    end
  end
end
