# -*- encoding : utf-8 -*-
require 'test_helper'

describe ThemeRenderer::Theme do
  subject { Theme }

  describe '#new theme' do

    let(:theme) { ThemeRenderer::Theme.new('My Theme') }

    it 'must start with no version' do
      theme.version.must_equal nil
    end

    it 'must have a no version_number' do
      theme.version_number.must_equal nil
    end

    it 'must be named' do
      theme.name.must_equal 'My Theme'
    end
  end

  describe '#publishing a theme' do
    let(:theme) { ThemeRenderer::Theme.new('woot') }

    it 'must increment #version' do
      # skip "cos we'er crap"
      theme.publish!
      theme.version_number.must_equal 1
      theme.publish!
      theme.version_number.must_equal 3
    end
  end
end
