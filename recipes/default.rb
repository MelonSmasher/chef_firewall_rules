#
# Cookbook:: firewall_rules
# Recipe:: default
#

def apply_rule (service_opt, port_opt, protocols, command_opt)
  protocols.each do |protocol_opt|
    firewall_rule service_opt do
      if port_opt
        port port_opt
      end
      protocol protocol_opt
      command command_opt
    end
  end
end

if node['firewall']['allow_vrrp']
  if node['platform_family'] == 'rhel'
    firewall_rule 'vrrp' do
      protocol 112
      command :allow
    end
  elsif node['platform_family'] == 'debian'
    firewall_rule 'vrrp' do
      provider    Chef::Provider::FirewallRuleIptables
      protocol    112
      command      :allow
    end
  end
end

node['firewall']['rules'].each do |service, fw_options|

  port_opt = false
  if fw_options['port']
    port_opt = fw_options['port']
  end

  protocol_opt = false
  if fw_options['protocol']
    protocol_opt = fw_options['protocol']
  else
    log 'Missing Protocol' do
      message "Missing protocol for service: #{service}, skipping..."
      level :warn
    end
    next
  end

  command_opt = false
  if fw_options['command']
    command_opt = fw_options['command'].to_s.to_sym
  else
    log 'Missing Command' do
      message "Missing command for service: #{service}, skipping..."
      level :warn
    end
    next
  end

  protocols = []

  if protocol_opt.to_sym == :both
    protocols.push(:tcp)
    protocols.push(:udp)
  elsif protocol_opt.to_sym == :all
    protocols.push(:tcp)
    protocols.push(:udp)
    protocols.push(:icmp)
  elsif protocol_opt.to_sym == :tcp
    protocols.push(:tcp)
  elsif protocol_opt.to_sym == :udp
    protocols.push(:udp)
  elsif protocol_opt.to_sym == :icmp
    protocols.push(:icmp)
  elsif protocol_opt.to_sym == :none
    protocols.push(:none)
  else
    log 'Unsupported Protocol' do
      message "The protocol: #{protocol_opt.to_s} defined for service: #{service} is an unsupported protocol, skipping..."
      level :warn
    end
    next
  end

  case command_opt
    when :allow
      apply_rule(service, port_opt, protocols, command_opt)
    when :deny
      apply_rule(service, port_opt, protocols, command_opt)
    when :reject
      apply_rule(service, port_opt, protocols, command_opt)
    when :masqerade
      apply_rule(service, port_opt, protocols, command_opt)
    when :redirect
      apply_rule(service, port_opt, protocols, command_opt)
    when :log
      apply_rule(service, port_opt, protocols, command_opt)
    else
      log 'Unsupported Command' do
        message "The command: #{command_opt.to_s} defined for service: #{service} is an unsupported command, skipping..."
        level :warn
      end
      next
  end

end