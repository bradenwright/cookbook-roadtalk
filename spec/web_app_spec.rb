require 'spec_helper'

describe 'roadtalk::web_app' do
  let(:chef_run) {
    runner = ChefSpec::Runner.new(
      :platform => 'ubuntu', :version => '12.04')
    runner.converge described_recipe
  }

  it 'includes build-essential' do
    expect(chef_run).to include_recipe 'build-essential'
  end

  it 'includes git' do
    expect(chef_run).to include_recipe 'git'
  end

  it 'includes rbenv::default' do
    expect(chef_run).to include_recipe 'rbenv::default'
  end

  it 'includes rbenv::ruby_build' do
    expect(chef_run).to include_recipe 'rbenv::ruby_build'
  end

  it 'includes rbenv::rbenv_vars' do
    expect(chef_run).to include_recipe 'rbenv::rbenv_vars'
  end

end
