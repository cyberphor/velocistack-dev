#!/usr/bin/env sh

# Create a server config file if one does not exist
if [ ! -f server.config.yaml ]; then
  velociraptor config generate > server.config.yaml --merge '{"Frontend":{"public_path":"'$PUBLIC_PATH'", "hostname":"'$VELO_FRONTEND_HOSTNAME'", "default_server_monitoring_artifacts" : ["Custom.Elastic.Flows.Upload"]},"API":{"bind_address":"'$BIND_ADDRESS'"},"GUI":{"base_path": "'$BASE_PATH'", "bind_address":"'$BIND_ADDRESS'", "links": [{"text": "CyberChef", "url": "https://PRIMARY_IP/velocistack/cyberchef/#", "type": "context", "encode": "base64", "parameter": "input", "icon_url": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACACAYAAADDPmHLAAAXGUlEQVR4Ae1dBVRVWRceRVowaPiHkA67i7C7uyewu7t1RgU7x+5uBTspYeygyw6cFBRHOP93WPuu9aTeE99D7uOetb6J967B3d/Ze59d57titEoAJYFSgCagBWgTtABNggY9Ky01EboGCVYXKA2UA0wAc8CSYAGYAkaAIaAHaElkEL/gtQEDwBj4vlq1apXWrFkz4MiRIwsOHjy47cSJE0dPnjx5Cv+/f9euXSuXLl06vFmzZrXxrA1gRmTQIa1RIm+tkgMlvhFxpEUC0CLBmzs4OLjv2bNnyt27d8OePHmS/vz5c5acnPzv77//znJDRERE5uXLl6O2bt3q36hRo1r4PayAMkQmDRlyaZGmKE0wIJTOpkEKcUlLg1S9sZ2dnTN2+C+JiYlvudBlgc9SSeD54saNG2n79+/fXr9+/RqkEQxIIxjQ/9taWFi4Nm7cuGafPn28OWGaNm3Kn7Wj7/VJe0irEFR+Kdp9lrNnz+4SHR0dKwi8oAQQEBISkuLn5zdGEKyOjo7dpUuXQsPDwz/koUX+u3jxYgj5F7qSOfgqwQJ521gBmmSvrXfv3j1VUPV5ISEhIe1LCEDIPHDgwG49Pb3qgwcPHqDIr/nhhx8akfmQTEEBjmpatHv0c7Gx+vSdNqBDL9kmMDBwjSBkpROAcOzYsaAlS5ZsUuTZ5cuXT6AThyZQIjdHlUCklrx2LRJweTqmWQP2np6eVX/++Wdv7Cgva2trN/4ZfWdFatYB9n4pCVh1BCCEhoZ+UOQ5aKOt9HfUziZgDRlfwpAIrUVEKHZLOK4ZkuNUwd/fvw9s7OYHDx7chcf+d3YBJiUl/R0ZGRmFZ3bg2WHYkVOePXv2SaUEKABOnTp1jTuKdCooSdAUTiijRo1qimPo2oYNG7oR6bWLDwnIdtOON3V1dfXAy1gcFxf3hASlMhQWAa5cuZKEn80NKEfC1SVB223atGkhnMUsTXL16tXY1q1b1yNzQSQoHmf1soDtzp07x0MobwQBqQsBcEr4aG5u7kMmyxywqlGjRq2AgIAr2Z8FCRJatGjRgIJWak2CkmT/jCti4ax9UhCMuhGAjpB/IxC1q23btu3hx/S7du3as7yeBQnifXx8alNImvwG9RO+NmDSq1cvz5iYmDgSitoSQAYZXCPIew7xgwfu7u6VyWxoqpXNJ+Eb9ejRoyFs/VMSiMgIoHqcPXs2qEyZMnYyzqNaLE2gXNWqVStHRUVF5yEciQAEhKB/JR9JQ12OevqArWI2XyLAihUrRpAZoEyk+FW/6fr164fKF5BEAMQPrvJ4CB2RNdRh9xvyCJ58uy8RICgo6GX16tUb8A2jLicBLcAcNm0WCUAiQD5xgxEjRvzIi1fUxQEsSbbfHqHbaIkA+QMVSSvwrlyAsqK3/bRKAeUmTpzYQb5gJAL4+voOptyBvjrUI5YQ1D/StKslAsjHoUOHTvPMplCCJvZUcQlKftjcunUrVCKAfISFhb1HFNCHtIAJEaE0hc41iQyis/+O8fHxL4sSAZBOpnx+0QMyouEoSF3HS9AGDRrUysDAwAnv8H9AeSJCSTERwMDMzKwicvWZRYkAT58+LTpCl1+Y+h5p5XtIKM2kJJGmqM7/qJKtX3BhSQQQEBwc/JSqoERTZKoBlOnWrZuPRICvB8rQ/iUHUR8oKRoNYGNjU00igFIcxHcUIygtDgKQDwC4okz7vUSAr/YF0vi7pHdaUlSnAKR/k4onASQC6AK2SHAESARQig8gKgIIaWCLvXv3LpAI8NW1hX/iXToLPoCYcgHl0XLtiZf+USLAVxHgNdUI6IsqGESMtUeq86pEgAKliD+hkjgJRSIHqbScagTElRAyQ/fOICkXoFAzyQsMrziLkrAlKCPvY2RkVIuOf1aAgfiyhBQPAJxu3rwZIhEgX0//Q82aNTvhXXlQQsgCMKakkK5YawQEZ9B86NChnRAT+CgRIM9m0qN4T+6UCSxN701THdLCGvQD2e3bt2+xRIDc0bFjx/7k6BmIdbfL8wXKAS5IbJyTCJATyPgd4qZSZqhECXXsDDIpV65cJRxrLkgEyIFMDJWYSg6fLlBSXRtDTTkJECEMlAiQM+Tbr1+/luT8aalrg6guOTou6JOf+fjx43cSAQgABl88MDQ0zJb6VU9NUA6ogNEv7eEXXKLKIak1DEBZ2AyhNUzdJ4QY0Hm34o8//jgQI2FSn0sEYJhItorqAGnAlHrP99MlEtRA+1hKcSfAhQsX7vABlBRA0ygug6LKAu6oIH6jjgSAc/cfzNy/8p7DmNpE0fQGqqB6yEXdCIDY/vMNGzZsrF27dnug87lz5x7l9ez169dftmrVqgWNvhN1b6BEANr1pUqVakyTwqwBOwyNqolkz8lc5gM9adOmTSvqAVCH1jCJANjRr/AzVQFMZSaemgGuaPyYiULPVFL7cU2wSPil1SQMLBEAs37uUhWPAaBBEI6/Ni1btvTavn37L2gHq0JOsL4aCV8iwNGjRy9mr+LJNiCzPGBMDrCumql9iQAYLH2e2/0cDh1lSGWGYpdSQ4dPIsDx48fPZZsVnHMVsx0vEUBaEgGkJRFAWhIBpCURQFoSAaQlEUBaEgGkJfQQOqoTAXCT2Vlhro98AkgE0ANsIZzXqiYAupMyCoMAp0+fDqAkj7ZEAAWbSH/99Vdf1MPdQCEFUxVQcvVh9erVTJWYP3/+qWHDhnUURrtJIV/FZgmUAVzQGXsMAxOZqnD48OE03C/MVIm+ffuuFGb+S7v/y2YK2a1ateqw2AnQv3//pVTgoSPt/i8jgK1EgOK5NOgo6Lhy5cqjamACVnAyK97dIy0twHjt2rUDUUkTjno6pirgbr70devWMVVi0aJFARMmTOgsc/mDtBQYLf99YmJiYRwDMwvjGBiA9WVzfaRAkENh3CEMkr0vpNHvZzmp5Y95l4SvTeflSiBASiEQoLAigeekSKBi18eb0GSMJg8f3H8JAaXLQ1JS4ocvQXJS0vskQnRU1F8YUPFelcBkzzQ4m4E04bt07iZA2vXldXS+qzDGx2bqrx3dIvcMa5pxZnpndmxie3ZoXFt2cKzycGXvLnY7MDALN44fT0WwiQlYtmwZGzBgAPPy8lIaGjVqxDAgM6Nx48YJdevWnUIkkJbMbAATL7tyDVd2dL63sV8NFrGwN7u9uC8L/6U3C13QkwXP78mC5vVQCq7M682SQ0PY27t3s/A8IiIV83iYgF27djF47Az39ysNaPpg6PNjaPdiuDqe4eKMq7g9xRT4riihUP8wmTlBxp2qmLf+rZvbmw29qrCbi3qz+/792T2//uyuXz92d4lyEbR8PPv30SP2KSEhC+8iI1ORqmUEXr/PNm7cyAXFBaY8kPAFQBtcorhAMV10g7irpV61DV3dkkAAdm5KOy58leLR6UPsv/h4xpKTs5AWHZ2WPTiEK9u4GSBhqQ7169cfTXGBYhvqtfFv73xma08PtqlPNZULP2TlBPbXgwck/LwJwDUBJnSxdu3aqZQAMA/xlPoulrvfuH8Ny57benpkbu7hzvYM9lKp8CP8fFlS0FWu9uUSQNACuOVU5VqgYsWKLsB3RQGF84fA9hPrbZZ1cL62rZcH4wTY9mNdFji5LQuZ110lwo88c5Klx8WR4OUTAOd2hrsNGEbaqkQTwClMbd68OZ8AUrt4HQvpBrGqVgZ1t/by+MgJsBXYAB9gZScX5t/BmS3tWoUFTlKOPxC2dBiLOh/IPsTGktAVI4BAAn4yGDt2rNJIAMEzDIHeindQlTKEWjKxkJLkE2gSNNRV/ZuM97adxYUvQCDCFvgDa7u4slkt7NmRqX0gxAEFEvwdvx9YyMZf2NOwMGHnfzEBBBJgpjEbs3wMa9mrZcEETycKfiTs1asXw/yHXykqqC8jcG2KD5SjNvHywvfqFvHTAawWtnE8SILPQYKN3d2ZX3tndmD+WBaxbyML8x+qsOCvzevJpvbwYc29G7DfAwIEm18wAhAGhg1k1lHW7H+h/2MuK1yYV18vhQXPNUePHj1Yz549Wffu3RnG33ESBNEkcDPKEBrRLCAHT0/PXnh2F2oIzsmOiFG3gk87qPub+RFgKUxB4NLpLDUqigdr2P1Th1notmUsaPU0FrRiHAteNpoF+w1je8d3Zit8W7DJ3X1YW8+arF7duuz8+fP8bj3WFy89V9VPyEhMZH/ev8/DtPz8z3d7DuHPuTaH2STaAEC8DbN7ZMeOJRxjZ6+eZS0XQiMMaMtwISbr1KlTFrp27coFnXWMHD16NMPlGGznzp1s+PDhrE+fPuynn35iAwcOZB06dNimp6dXg88Mqly5cpsuXbpsBjle8O8IXGtMpwyimhSSkP0HXFd1domUR4Azy6YLgspS4/8ggPPHvXvs9a1b7BVwfMsWVqlSJYYXyKpUqcKqVq3Kpk6dyjIzMxkWz8Oz0zt25Cp8rhkgfBaLeoAFCxYwTO/iUzxyEMDrkRcRAAC8nnqxjIwMlp6eznY838EqhVZiO/BnYLyLAC7wLN8BBa389+TE4mSQJQAH/+8/MBmVhJ4T+D7F0tKymrrUEQhhX4sGFcq1+a2729+KEiAvbPb3Z/CiZcHDrjzHz169esVn7jP/2bNz3fmcSG+Cgtj7Gzf4y+bhX27rcxDAPsH+MwLYJdqxff/uY5Hpkazd83ZZnx0IOCC38ig7ARQFNMMWbjJFrQVkw74NbMt6r+/m+pQE/lUE2LFyJQk+b6zC7s7+697HxLDka9cYu32bvQsNzXrRQ4YM4bs3hxlwinci4ecO20Rbdvj0YZURAHcF/UNagIZLiTjs62GhV2Mdwr4k7K8mwMOLF+USIAS2PfvuT7lzh73ORgAOFKDmMANt7rXJlwAwEfSsaghAWsBPzMOihQJPu6Xtnc6ToL+eAIRxQ4fmKXzffv1YZlLSZ89/RB4gEcLPhPCzE2DOnDkMgxs/E9zq86tZhYQKue/+BFu25PIShQgwYsSI5717984sAAEykEruL+MHlBDjsc9ichPb2SRkpRIgNTo6VxIMxXEre9yfg3/29PJlxogA/4aECC+aB3y485bDDCy4soC5xbp9JnxuGmZcn6Fw9TF+/1UODg6jUSH8WFHh+/r6fkS0cCqVkomvopgYW9bFWK/6pu7uf6qCALLmYBdUOPcLbp85k6fn/wQ7Pj0iIlcCDB48OKcfQDhw+gCbeX0mGx42nE0Pms72Buyl7xQDyDUf76I27Hlb8vzl2f5UxARG8Ys26eSkKdbdbzW3pf0GErDKCKAIeEwhiXZ/DgIQeC8f+QFKxeTJk2dQqZsLqoSm5Cd8ECQFR9s+NFewrDiviyHbb6Sl5bqph/tf35oA3Bd4A4HD+cuXALNmzRL8AKUC8YlppMqtNDU1a/IYQB5q/xNiG/2z73zRpnwH1/t+CAn3mxKAF4E8hrAzbt3KlwBjxoyR9QOUhmnTpgk3gJkA7jgR3M2NAPg8ihJFJsLOF3XM/9e2joeLAgEQ82eJpP7zIwD5AaomgBsEfT83AsBJfITvK8teESPumH9nl7vfnADk/T++dCl/AhBQHUx+gNIJ8D1ggRxAdZiAd3k4f+nOzs7tiSx6gIaYS76cIMy/igIBKPijEAFmzpypdD9gypQp08muO+BoN1eOE/gYxTOtZMbGa4i1vctlSw+PtKJAgJc3b7I/g4MVIgCidkr3A8aPHz+X23YXF5dO2P1/KXAM/AvHwB8pTUwkECEBNvfwSC0KBODZw5Tr13MQgCKBOfwA3NWnVAIg17AM9wTNQZr47RcEgtKR3JooxpSwYAIc13d1e1IUCMCzf48vXpRPAAKqgpXqB4waNeqfguQCQIJMmIy+wrVxYrsS1haFn9e/OQEoCBR14QL7BFMghwAF8ANUngxaQqcCygWIJ/1rNa2p3YpvTgAKA/NCkocBAVk1AAIBUsPCcr50igegPoDMwLcjADRAmr29fX0KCpUSWyDIqKFD+ea89r8ohIJ5VRH3BR6cO5dFhPizZ1lsQMAnXq4lC2TueE9AkSAAysy2i3XCqIYw6GFZB5eQokAAigjyfsAsbfAEuz/y0qX3vBdQFps3b+ZlXYIPoDICwCF8gcBPLA//5lES9hbJo3pUJSzKZJAWYN6hkllWB1BRIICQF+AmgdcG/PXwYRoXdHZQkaiqCJDZunXrTbhIsiG/I9nGxqZ1+/btt+L8/0qWAGggnUjBI9r94i0GsV/Q2uFgUSFAtvKw/+QLULkEQBXxFbyTaoA1lYZbUJCoCs7+w1A2fgbVxZtouGSZ7M6fGLWAkbGeZrU1XVxjixwBUDZe2ARAY8g8susGgDahtNAfQLvenIRPCSE1qAauaV2myTrEBVRBgP+g0j/AyUuPj1cYqRD+n/AHeF8AgZdyp6HMO3nTpk3x2YHS8VjUDUZjdmEM8gVx6B18WxACoB5gKO18QbgcGjIdQnr0zmjnq087uFVdW8Pmqzu7RiubAHFw6I4cOcLv3s1qCrmJ8z7HrVu3csVtHAHvID/An/X29lYIEByDimb16tVjtWrVyti2bdvzghDA0dGxad5FntQjSMRQp5awUkQCS5iD6gtaORwlx1BpJuAWQr3h4eEsFjv76dOn7OXLl+z169fszZs3WUhJSfkMb9++5T0E+Y53QRQuCyjM5Kqb+fj4cCJ8hBaIKogJgKP3jqeDRRPZUwEJ9ABTwKlLJdN+aBG7oxQCkHd/79Chvy/4+T25sXp18v1Nm5Ji9+6NTThwIDrp0KGoJ0eOfIZnJ048jDly5BE8cpYdvIsXcXhOAlnhZ8A7fwAz8bqgPgAqg29mv0K2uJFAg+xcGcp5u7WvaNaLa4T13dxeKMMJ/BNFnxGo7bswfjy7PmkSC582jd1GaPceuoQeoPT74dy57BHhJkrAuLBJ4DmEjglfvMPoGULDtxAaflMgJ5DKwjt37nwXv/8M2gA5nLviqA10yRZaAA6AR20bw1Y/1LSa0q+GxfqTq36N/CoPH72E8TjL/w4yXJkxg10cN45dQQsYJ0Xw5MksBLiE/+eCJmFzfILAn48cOfKOv7//nf37979QxikAgyb4xPBash2/0nBIGoiQrTfejI5INc/v3r1bmUe+j2gJS0Hy5xmSQgkgRjyCPVFI+KxZteoRvPxohH6fYT7QR1UcAxFankWq31C6NSRv0yCQwQCwCT9xYoOq4wBpkZGFEgfA2PiJihV6Sqsk7ZDyv06a1BIt3DEqjgSmqlr4UGS30OtfV/08f9XXE5iZmppWCjp8eCOaOj+qggDChBBVgJsTXHy1XktLy4N2/xeOipdMgp4wPHrm6NF9kcGLFAsBsOtjMBqGV/I4AsbSlPCvPzJ+j46ayvvXrJn9LirqTVElADKJqQsXLlyN0u+qlOwpI90VqLwoojFgV71y5QZwEHcinZtaVAgAdf8JV9ycbNCgQQvK7JkA+sqP50vawIACKQ41K1b0vH7o0Kb02Nh334oAqBn49Ntvv11EIKkzr4KmmIYh/V01JOGrjgiGlDJ1qFWpUsMzO3f6o/I3vrAIAFWfhk7iY4gYduBDryiqWfbbZPEkjWBGQZaK/tOn+947e/YI/ITXSj0Gkle/ZcuWsOnTp8+nQk0nwJIErysJ/tsSoTSVTluR5115wYQJA2AiNiSHhNz4EBPzT24EwOfv8hF6JnL+iXynT5o0aaaHh4c37XZbMkOGwo6XnLyiQQRN2okGMtU1FUholft16dJm3fz5wwO3b18SduzYFlwZc+DeuXPHcbffaX5DKa6L2Y9z+1oIezqmdfaxtrbmu9yDCGUtM9lTH9CSbHxRJAKRgQSkQ8IqQ4QwIw1hQ8RwIOEKsAfsSNgW5MmXI0Lp0e9ZShK8yMhA0CQB6pIw9clsGAig/9en77WzCbykugv9/46UImUMsLf8AAAAAElFTkSuQmCC"}], "reverse_proxy": [{"route": "'$CYBERCHEF_ROUTE'","url": "'$CYBERCHEF_URL'","require_auth": true},{"route": "'$GRAFANA_ROUTE'","url": "'$GRAFANA_URL'", "require_auth": true}, {"route": "'$PROMETHEUS_ROUTE'","url": "'$PROMETHEUS_URL'", "require_auth": true}, {"route": "'$KIBANA_ROUTE'","url": "'$KIBANA_URL'", "require_auth": true}, {"route": "'$CLIENT_DOWNLOADS_ROUTE'","url": "'$CLIENT_DOWNLOADS_URL'", "require_auth": true}]},"Monitoring":{"bind_address":"'$BIND_ADDRESS'"},"Logging":{"output_directory":"'$LOG_DIR'","separate_logs_per_component":true},"Client":{"server_urls":["'$VELO_SERVER_URL'"],"use_self_signed_ssl":true}, "Datastore":{"location":"'$DATASTORE_LOCATION'", "filestore_directory":"'$FILESTORE_DIRECTORY'"}}'
  sed -i 's#/tmp/velociraptor#.#'g server.config.yaml
  velociraptor --config server.config.yaml user add $VELO_USER $VELO_PASSWORD --role $VELO_ROLE
fi

# Re-generate client config in case server config changed
velociraptor --config server.config.yaml config client > client.config.yaml

# Repack clients
#velociraptor config repack --exe binaries/linux/velociraptor client.config.yaml binaries/linux/velociraptor_repacked
#velociraptor config repack --exe binaries/mac/velociraptor client.config.yaml binaries/mac/velociraptor_repacked
#velociraptor config repack --exe binaries/windows/velociraptor.exe client.config.yaml binaries/windows/velociraptor_repacked.exe

# Update config file
velociraptor --config server.config.yaml config api_client --name dfir-iris-modules --role investigator,api api.config.yaml
sed -i 's|0.0.0.0|velociraptor|' api.config.yaml 