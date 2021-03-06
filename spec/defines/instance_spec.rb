require 'spec_helper'

describe 'lumberjack::instance', :type => 'define' do

  let(:title) { 'foo' }
  let(:facts) { { :operatingsystem => 'CentOS' } }
  let(:pre_condition) { 'class {"lumberjack":; }' }

  context "Setup a instance with the service" do

    let :params do {
      :config           => 'puppet:///path/to/config',
      :cpuprofile       => 'puppet:///path/to/write/cpuprofile',
      :idle_flush_time  => 5,
      :log_to_syslog    => false,
      :run_as_service => true
    } end

    it { should contain_file('/etc/init.d/lumberjack-foo') }
    it { should contain_file('/etc/lumberjack/foo') }
    it { should contain_file('/etc/lumberjack/foo/ca.crt') }

  end

  context "Setup a instance without a service" do

    let :params do {
      :config         => 'puppet:///path/to/config',
      :run_as_service => false
    } end

    it { should_not contain_file('/etc/init.d/lumberjack-foo') }
    it { should contain_file('/etc/lumberjack/foo') }
    it { should contain_file('/etc/lumberjack/foo/ca.crt') }

  end

end
