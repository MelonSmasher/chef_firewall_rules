# Firewall Rules

Configures firewall rules through attributes. Wraps the [firewall cookbook](https://supermarket.chef.io/cookbooks/firewall#berkshelf).

## Supports:

- amazon
- centos
- debian
- fedora
- oracle
- redhat
- scientific
- ubuntu
- windows

## Usage

### firewall_rules::default

Just include `firewall_rules` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[firewall_rules]"
  ]
}
```


## Attributes 

### Rules:

Define firewall rules.

Default Value: 

- `[]`

Ruby usage:

```ruby
node['firewall']['rules'] = [
    "http" => [
      "port" => 80,
      "protocol" => "tcp",
      "command" => "allow"
    ],
    "https" => [
      "port" => 443,
      "protocol" => "tcp",
      "command" => "allow"
    ],
    "nrpe" => [
      "port" => 5666,
      "protocol" => "tcp",
      "command" => "allow"
    ]
]
```

JSON usage:

```json
{
  "firewall": {
    "rules": {
        "http": {
          "port": 80,
          "protocol": "tcp",
          "command": "allow"
        },
        "https": {
          "port": 443,
          "protocol": "tcp",
          "command": "allow"
        },
        "nrpe": {
          "port": 5666,
          "protocol": "tcp",
          "command": "allow"
        }
    }
  }
}
```


### Allow VRRP:

Allow the VRRP protocol.

Default Value: 

- `false`

Ruby usage:

```ruby
node['firewall']['allow_vrrp'] = true
```

JSON usage:

```json
{
  "firewall": {
    "allow_vrrp": true
  }
}
```
