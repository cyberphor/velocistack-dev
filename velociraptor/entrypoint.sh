#!/usr/bin/env sh

# Create a server config file if one does not exist
if [ ! -f server.config.yaml ]; then
  velociraptor config generate --merge_file=config.json > server.config.yaml
  velociraptor --config server.config.yaml user add $VELO_USER $VELO_PASSWORD --role $VELO_ROLE
fi

# Re-generate client config in case server config changed
velociraptor --config server.config.yaml config client > client.config.yaml

# Repack clients
velociraptor config repack --exe binaries/linux/velociraptor client.config.yaml binaries/linux/velociraptor_repacked
velociraptor config repack --exe binaries/mac/velociraptor client.config.yaml binaries/mac/velociraptor_repacked
velociraptor config repack --exe binaries/windows/velociraptor.exe client.config.yaml binaries/windows/velociraptor_repacked.exe

# Update config file
velociraptor --config server.config.yaml config api_client --name dfir-iris-modules --role investigator,api api.config.yaml
sed -i 's|0.0.0.0|velociraptor|' api.config.yaml 

# Get the user's API key from iris-db
# api_key=$(docker exec -it iris-db /bin/bash -c "/usr/local/bin/psql -U postgres -d iris_db -c 'SELECT api_key FROM \"user\"';" | sed -n 3p | sed -e "s/^[[:space:]]*//" | sed 's/\r$//' )

# Create the module using Velociraptor
# sudo ./velociraptor_data/velociraptor -v --config.frontend-artifact-definitions-directory 
# sudo ./velociraptor_data/velociraptor -c ./velociraptor_data/server.config.yaml  -v --config.frontend-artifact-definitions-directory=$(pwd)/velociraptor_data/artifact_definitions/Custom artifacts collect Custom.Server.IRIS.Module.Create --args "IrisURL=https://PRIMARY_IP" --args "IrisKey=$api_key" --args "ModuleName=iris_ioc_velo_module"
