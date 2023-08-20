## Troubleshooting

If you experience an error with `cadvisor` and `/var/lib/docker`, try replacing the volume with `/var/snap/docker/common/var-lib-docker/` (for Docker installs that have occurred via `snap`).