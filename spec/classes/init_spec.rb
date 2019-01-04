require 'spec_helper'
describe 'trace9' do
  context 'with default values for all parameters' do
    it { should contain_class('trace9') }
  end
end
