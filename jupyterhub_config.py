c = get_config()  #noqa

c.JupyterHub.bind_url = 'https://0.0.0.0:8000'

c.JupyterHub.ssl_cert = '/jupyter/certificates/localhost.crt'
c.JupyterHub.ssl_key = '/jupyter/certificates/localhost.key'

c.Authenticator.admin_users = {'admin', 'ferox'}
