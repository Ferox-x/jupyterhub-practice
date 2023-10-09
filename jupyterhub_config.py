import os

c = get_config()  #noqa

c.JupyterHub.bind_url = 'https://localhost:8000'

c.JupyterHub.ssl_cert = './localhost.crt'
c.JupyterHub.ssl_key = './localhost.key'

c.Authenticator.admin_users = {'admin', 'ferox'}
c.ConfigurableHTTPProxy.command = '/home/ferox/.nvm/versions/node/v14.21.3/lib/node_modules/configurable-http-proxy/bin/configurable-http-proxy'
