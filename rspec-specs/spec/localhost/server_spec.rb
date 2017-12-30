require 'spec_helper'
require 'serverspec'

describe group('confluence') do
  it { should exist }
end

describe user('confluence') do
  it { should exist }
  it { should belong_to_group 'confluence' }
  it { should have_home_directory '/home/confluence' }
  it { should have_login_shell '/bin/false' }
end

describe file('/opt/jdk') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/home/confluence') do
  it { should be_directory }
  it { should be_owned_by 'confluence' }
  it { should be_grouped_into 'confluence' }
end

describe file('/opt/atlassian/confluence') do
  it { should be_directory }
  it { should be_owned_by 'confluence' }
  it { should be_grouped_into 'confluence' }
end

describe file('/var/opt/atlassian/application-data/confluence') do
  it { should be_directory }
  it { should be_owned_by 'confluence' }
  it { should be_grouped_into 'confluence' }
end

describe file('/opt/atlassian/confluence/bin/setenv.sh') do
  it { should contain '-Xms2g' }
  it { should contain '-Xmx4g' }
  it { should contain '-server' }
end

describe file('/opt/atlassian/confluence/conf/server.xml') do
  it { should contain 'proxyName="www.example.com"' }
  it { should contain 'proxyPort="443"' }
  it { should contain 'scheme="https"' }
  it { should contain 'secure="true"' }
end

describe file('/opt/atlassian/confluence/confluence/WEB-INF/classes/confluence-init.properties') do
  it { should contain '/var/opt/atlassian/application-data/confluence' }
end