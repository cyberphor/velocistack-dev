#!/usr/bin/env bash

set -e

# Invoke a shell if one was passed as an argument via the Dockerfile CMD field
if [ "$1" == "sh" ] || [ "$1" == "bash" ]; then
  "$@"
  exit
else
  # Create a server config file if one does not exist
  if [ ! -f server.config.yaml ]; then
    echo "Creating a server config file"
    velociraptor config generate --merge_file server.config.json > server.config.yaml
  fi

  # Create an API config file if one does not exist
  if [ ! -f api.config.yaml ]; then
    velociraptor config api_client --config server.config.yaml --name dfir-iris-modules --role investigator,api api.config.yaml 
  fi

  # Create a client config file if one does not exist
  if [ ! -f client.config.yaml ]; then
    echo "Creating a client config file"
    velociraptor config client --config server.config.yaml > client.config.yaml
  fi

  # Create a repacked client if it does not exist
  if [ ! -f binaries/linux/velociraptor_repacked ]; then
    echo "Creating a repacked Linux client"
    velociraptor config repack --nobanner --exe binaries/linux/velociraptor client.config.yaml binaries/linux/velociraptor_repacked
  fi

  # Create a repacked Mac client if it does not exist
  if [ ! -f binaries/mac/velociraptor_repacked ]; then
    echo "Creating a repacked Mac client"
    velociraptor config repack --nobanner --exe binaries/mac/velociraptor client.config.yaml binaries/mac/velociraptor_repacked
  fi

  # Create a repacked Windows (.exe) client if it does not exist
  if [ ! -f binaries/windows/velociraptor_repacked.exe ]; then
    echo "Creating a repacked Windows (.exe) client"
    velociraptor config repack --nobanner --exe binaries/windows/velociraptor.exe client.config.yaml binaries/windows/velociraptor_repacked.exe
  fi

  # Create the specified administrator account if it does not exist
  if ! velociraptor user show $VELO_USER --config server.config.yaml > /dev/null 2>&1; then
    velociraptor user add $VELO_USER $VELO_PASSWORD --role $VELO_ROLE --config server.config.yaml > /dev/null 2>&1; 
  fi
fi

# Execute whatever passed as an argument via the Docker CMD field (should be Velociraptor)
"$@"

# Get an IRIS API key from iris-db and create the module using Velociraptor
# api_key=$(docker exec -it iris-db /bin/bash -c "/usr/local/bin/psql -U postgres -d iris_db -c 'SELECT api_key FROM \"user\"';" | sed -n 3p | sed -e "s/^[[:space:]]*//" | sed 's/\r$//' )
# sudo ./velociraptor_data/velociraptor -v --config.frontend-artifact-definitions-directory 
# sudo ./velociraptor_data/velociraptor -c ./velociraptor_data/server.config.yaml  -v --config.frontend-artifact-definitions-directory=$(pwd)/velociraptor_data/artifact_definitions/Custom artifacts collect Custom.Server.IRIS.Module.Create --args "IrisURL=https://PRIMARY_IP" --args "IrisKey=$api_key" --args "ModuleName=iris_ioc_velo_module"