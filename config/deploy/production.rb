# config/deploy/production.rb

server 'server ip', user: 'ubuntu', roles: %w{app db web}

set :branch, :master
set :rvm_ruby_version, '3.1.0' # Ensure this matches your installed Ruby version

# Specify SSH options
set :ssh_options, {
  keys: ['penfile-selected-in-aws-instance.pem'],
  forward_agent: true,  # Set to true if using a .pem file
  auth_methods: %w(publickey)
}
