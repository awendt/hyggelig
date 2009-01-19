require 'test/unit'
require 'test_helper'
require File.join(File.dirname(__FILE__), '../lib/i18n_with_scope')

class I18n_with_scopeTest < ActiveSupport::TestCase
  test "with_scope method" do
    assert_equal I18n.with_options(:scope => :foo) { |locale| locale.t(:bar) }, \
      I18n.with_scope(:foo) { |locale| locale.t(:bar) }
  end
end
