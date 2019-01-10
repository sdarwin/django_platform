# frozen_string_literal: true

tcb = 'account_site'

template_file = File.join(path_to_app_repo, 'app/shared_app/conf/config.ini')

var_map = {
  domain_user: node[tcb]['domain_user'],
  domain_password: vault_secret('passwords', 'seadmin', 'password'),
  email_user: node[tcb]['email_user'],
  email_password: vault_secret('passwords', 'calsev', 'password'),
  local_user: node[tcb]['local_user'],
  local_password: vault_secret('passwords', 'cjsevern', 'password'),
  local_email: node[tcb]['local_email']
}

template template_file do
  source 'config.ini.erb'
  variables var_map
  owner 'django'
  group 'django'
  mode '440'
  sensitive true
end
