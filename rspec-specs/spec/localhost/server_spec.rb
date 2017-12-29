require 'spec_helper'
require 'serverspec'

describe file('/home/confluence') do
  it { should be_directory }
  it { should be_owned_by 'confluence' }
  it { should be_grouped_into 'confluence' }
end