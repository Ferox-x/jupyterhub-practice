FROM python:3.11.3-alpine as requirements-stage

WORKDIR /tmp

RUN apk add --no-cache gcc python3-dev linux-headers musl-dev

RUN pip wheel --no-cache-dir --no-deps --wheel-dir /tmp/wheels \
    jupyterhub jupyterlab jupyterhub-firstuseauthenticator jupyter-collaboration \
    dockerspawner ipykernel dockernel

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
    cargo rust docker

RUN npm install -g configurable-http-proxy

RUN pip install --no-cache /jupyter/wheels/*


COPY localhost.crt /jupyter/certificates/localhost.crt
COPY localhost.key /jupyter/certificates/localhost.key

COPY dockernels /jupyter/dockernels

RUN apk add openrc
RUN rc-update add docker boot

RUN mkdir -p /usr/local/share/jupyter/kernels/python_37_kernel

RUN mv /jupyter/dockernels/kernel.json /usr/local/share/jupyter/kernels/python_37_kernel

RUN adduser -D ferox -s /bin/bash
RUN echo "ferox:egor456852" | chpasswd
RUN echo "ferox ALL=(ALL) ALL" >> /etc/sudoers

RUN echo "guest ALL=(ALL) ALL" >> /etc/sudoers
