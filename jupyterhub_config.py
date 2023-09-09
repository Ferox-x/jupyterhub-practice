c = get_config()  #noqa

c.JupyterHub.bind_url = 'https://0.0.0.0:8000'

c.JupyterHub.ssl_cert = '/jupyter/certificates/localhost.crt'
c.JupyterHub.ssl_key = '/jupyter/certificates/localhost.key'

# c.JupyterHub.authenticator_class = 'firstuseauthenticator.FirstUseAuthenticator'
# c.FirstUseAuthenticator.first_login_message = "Добро пожаловать! Это ваш первый вход."
c.Authenticator.admin_users = {'admin', 'ferox'}
