# SPDX-FileCopyrightText: 2022 2022-2023 SAP SE or an SAP affiliate company and Open Component Model contributors.
#
# SPDX-License-Identifier: Apache-2.0

source env.sh

# compile code and build images
docker buildx build --load -t ${TAG_PREFIX}/simpleserver:1.0.0-linux-amd64 --platform linux/amd64 .
docker buildx build --load -t ${TAG_PREFIX}/simpleserver:1.0.0-linux-arm64 --platform linux/arm64 .

# use a resources.yaml file
ocm create componentarchive ${COMPONENT} ${VERSION}  --provider ${PROVIDER} --file $CA_ARCHIVE
ocm add resources $CA_ARCHIVE resources.yaml
ocm transfer componentversion ${CA_ARCHIVE} ${CTF_ARCHIVE}

# create CTF archive
ocm transfer componentarchive ./ca-hello-world ${OCMREPO}