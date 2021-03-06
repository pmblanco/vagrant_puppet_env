class roles::puppet_master {

  class { 'puppet::master':
    manifestdir     => '/vagrant/puppet/manifests',
    manifest        => '/vagrant/puppet/manifests/site.pp',
	modulepath      => '/vagrant/puppet/modules',
    dns_alt_names   => 'puppet.vag.ardemans.int',
	puppetdb_server => 'puppet1.vag.ardemans.int',
	reports         => 'store,puppetdb',
	storeconfigs    => 'true',
	storeconfigs_backend => 'puppetdb',
	autosign        => ['*','*.prueba.com'],
    report          => 'true',
    certname        => 'puppet1.vag.ardemans.int',
    masterserver    => 'puppet1.vag.ardemans.int',
	agent_status    => 'stopped',
	rundir          => '/var/run/puppet',
	ssldir          => '/var/lib/puppet/ssl',
  }
  
  puppet::environment { 'dev':
    manifestdir    => '/etc/puppet/environments/dev/manifests',
    manifest       => 'site.pp',
    modulepath     => '/etc/puppet/environments/dev/modules',
  }
  
  class { 'puppet::db':
    require   => Class['puppet::master'],
  }

}