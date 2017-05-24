name 'firewall_rules'
maintainer 'Alex Markessinis'
maintainer_email 'markea125@gmail.com'
license 'MIT'
description 'Configures firewall rules through attributes.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version '0.2.0'

supports 'amazon'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'
supports 'windows'

depends 'firewall', '>= 2.6.1'
chef_version '>= 12.1' if respond_to?(:chef_version)

issues_url 'https://github.com/MelonSmasher/chef_firewall_rules/issues' if respond_to?(:issues_url)
source_url 'https://github.com/MelonSmasher/chef_firewall_rules' if respond_to?(:source_url)
