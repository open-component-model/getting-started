# SPDX-FileCopyrightText: 2022 2022-2023 SAP SE or an SAP affiliate company and Open Component Model contributors.
#
# SPDX-License-Identifier: Apache-2.0

source env.sh
echo "VERSION: ${VERSION}"
# Build using direct commands
ocm create componentarchive ${COMPONENT} ${VERSION}  --provider ${PROVIDER} --file $CA_ARCHIVE
ocm add resource $CA_ARCHIVE --type helmChart --name mychart --version ${VERSION} --inputType helm --inputPath ./helmchart
ocm add resource $CA_ARCHIVE --type ociImage --name image --version ${VERSION} --accessType ociArtifact --reference gcr.io/google_containers/echoserver:1.10

# clean generated files
rm -rf $CA_ARCHIVE

# use a resources.yaml file
ocm create componentarchive ${COMPONENT} ${VERSION}  --provider ${PROVIDER} --file $CA_ARCHIVE
ocm add resources $CA_ARCHIVE resources.yaml
ocm transfer componentarchive ./ca-hello-world ${OCMREPO}

# create CTF archive
CTF_ARCHIVE=ctf-hello-world
ocm transfer componentversion ${CA_ARCHIVE} ${CTF_ARCHIVE}