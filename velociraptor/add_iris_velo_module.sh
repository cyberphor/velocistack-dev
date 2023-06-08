#!/usr/bin/env bash

# Get the user's API key from iris-db
api_key=$(docker exec -it iris-db /bin/bash -c "/usr/local/bin/psql -U postgres -d iris_db -c 'SELECT api_key FROM \"user\"';" | sed -n 3p | sed -e "s/^[[:space:]]*//" | sed 's/\r$//' )

# Create the module using Velociraptor
#sudo ./velociraptor_data/velociraptor -v --config.frontend-artifact-definitions-directory 
sudo ./velociraptor_data/velociraptor -c ./velociraptor_data/server.config.yaml  -v --config.frontend-artifact-definitions-directory=$(pwd)/velociraptor_data/artifact_definitions/Custom artifacts collect Custom.Server.IRIS.Module.Create --args "IrisURL=https://PRIMARY_IP" --args "IrisKey=$api_key" --args "ModuleName=iris_ioc_velo_module"
