FROM python:3.11.3-alpine as requirements-stage

WORKDIR /tmp

RUN apk add --no-cache gcc python3-dev linux-headers musl-dev rust cargo

RUN pip wheel --no-cache-dir --no-deps --wheel-dir /tmp/wheels \
    jupyterhub jupyterlab jupyterhub-firstuseauthenticator jupyter-collaboration \
    dockerspawner

FROM python:3.11.3-alpine

ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_ROOT_USER_ACTION=ignore


WORKDIR /jupyter

COPY --from=requirements-stage /tmp/wheels /jupyter/wheels

COPY jupyterhub_config.py .

RUN apk add --no-cache nodejs npm linux-pam linux-pam-dev gcc python3-dev linux-headers musl-dev \
    rust cargo docker openrc

RUN npm install -g configurable-http-proxy

RUN pip install --no-cache /jupyter/wheels/*


COPY localhost.crt /jupyter/certificates/localhost.crt
COPY localhost.key /jupyter/certificates/localhost.key

RUN adduser -D ferox -s /bin/bash
RUN echo "ferox:egor456852" | chpasswd
RUN echo "ferox ALL=(ALL) ALL" >> /etc/sudoers
