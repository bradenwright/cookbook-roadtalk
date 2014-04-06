require 'spec_helper'

describe 'roadtalk default' do
  it 'creates user roadtalk' do
    expect(user('roadtalk')).to exist
  end

  it 'creates roadtalk home dir' do
    expect(file('/home/roadtalk')).to be_directory
  end

  it 'should respond to HTTPS request' do
    expect(command 'curl -k https://localhost').to return_stdout /Roadtalk/
  end
end

