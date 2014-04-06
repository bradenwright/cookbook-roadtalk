require 'spec_helper'

describe 'roadtalk::default' do
  let(:chef_run) {
    runner = ChefSpec::Runner.new(
      :platform => 'ubuntu', :version => '12.04')
    runner.converge described_recipe
  }

  it 'includes roadtalk database' do
    expect(chef_run).to include_recipe 'roadtalk::database'
  end

  it 'includes roadtalk web app' do
    expect(chef_run).to include_recipe 'roadtalk::web_app'
  end

  it 'includes roadtalk firewall' do
    expect(chef_run).to include_recipe 'roadtalk::firewall'
  end

end
