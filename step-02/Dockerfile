# SPDX-FileCopyrightText: 2022 2022-2023 SAP SE or an SAP affiliate company and Open Component Model contributors.
#
# SPDX-License-Identifier: Apache-2.0

FROM golang:1.19 AS builder

WORKDIR /app
COPY go.mod ./
COPY main.go ./
# RUN go mod download
RUN go build -o /helloserver main.go

# Create a new release build stage
FROM gcr.io/distroless/base-debian10

# Set the working directory to the root directory path
WORKDIR /
# Copy over the binary built from the previous stage
COPY --from=builder /helloserver /helloserver

ENTRYPOINT ["/helloserver"]