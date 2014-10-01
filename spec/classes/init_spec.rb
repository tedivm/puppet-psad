require 'spec_helper'
describe 'psad' do

  context 'with defaults for all parameters' do
    it { should contain_class('psad') }
  end
end
