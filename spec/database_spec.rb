require 'spec_helper'

describe 'roadtalk::database' do
  let(:chef_run) {
    runner = ChefSpec::Runner.new(
      :platform => 'ubuntu', :version => '12.04')
    runner.converge described_recipe
  }

  it 'includes postrgresql server' do
    expect(chef_run).to include_recipe 'postgresql::server'
  end

end
