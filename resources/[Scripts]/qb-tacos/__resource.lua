resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description "Taco Job"

client_scripts {
  'client/*.lua',
  'config.lua',
}

server_scripts {
  'server/*.lua',
  'config.lua',
}