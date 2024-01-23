# frozen_string_literal: true

require_relative '../../test_helper'
require 'pagy/extras/navs'

require_relative '../../mock_helpers/app'

describe 'pagy/extras/navs' do
  let(:app) { MockApp.new }
  include NavTests

  describe '#pagy_nav_js' do
    it 'renders first page' do
      pagy = Pagy.new(size: [1, 4, 4, 1], count: 1000, page: 1)
      nav_js_check(:pagy_nav_js, pagy)
    end
    it 'renders single page when used with Pagy::Countless' do
      require 'pagy/extras/countless'

      pagy, = Pagy::Countless.new(page: 1).finalize(0)
      nav_js_check(:pagy_nav_js, pagy)
    end
    it 'renders first page of multiple when used with Pagy::Countless' do
      require 'pagy/extras/countless'

      nav_js_check :pagy_nav_js, Pagy::Countless.new(page: 1).finalize(23)
    end
    it 'renders intermediate page' do
      nav_js_check :pagy_nav_js, Pagy.new(size: [1, 4, 4, 1], count: 1000, page: 20)
    end
    it 'renders last page' do
      nav_js_check :pagy_nav_js, Pagy.new(size: [1, 4, 4, 1], count: 1000, page: 50)
    end
    it 'renders with :steps' do
      nav_js_check :pagy_nav_js, Pagy.new(count: 1000, page: 20, steps: { 0 => [1, 2, 2, 1], 500 => [2, 3, 3, 2] })
    end
    it 'raises with missing step 0' do
      pagy = Pagy.new(count: 1000, page: 20, steps: { 0 => [1, 2, 2, 1], 600 => [1, 3, 3, 1] })
      _ { app.pagy_nav_js(pagy, steps: { 600 => [1, 3, 3, 1] }) }.must_raise Pagy::VariableError
    end
  end

  describe '#pagy_combo_nav_js' do
    it 'renders first page' do
      combo_nav_js_check :pagy_combo_nav_js, Pagy.new(count: 103, page: 1)
    end
    it 'renders intermediate page' do
      combo_nav_js_check :pagy_combo_nav_js, Pagy.new(count: 103, page: 3)
    end
    it 'renders last page' do
      combo_nav_js_check :pagy_combo_nav_js, Pagy.new(count: 103, page: 6)
    end
  end
end
