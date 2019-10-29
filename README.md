# nominatim-docker
[![](https://images.microbadger.com/badges/image/peterevans/nominatim.svg)](https://microbadger.com/images/peterevans/nominatim)
[![CircleCI](https://circleci.com/gh/peter-evans/nominatim-docker/tree/master.svg?style=svg)](https://circleci.com/gh/peter-evans/nominatim-docker/tree/master)

Docker image for [Nominatim](https://github.com/openstreetmap/Nominatim), an open source tool to search OpenStreetMap data by name and address (geocoding) and to generate synthetic addresses of OSM points (reverse geocoding).

## Supported tags and respective `Dockerfile` links

- [`1.5.0`, `1.5`, `latest`  (*1.5/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.5.0)
- [`1.4.0`, `1.4` (*1.4/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.4.0)
- [`1.4.0-trusty`, `1.4-trusty`, `trusty`  (*1.4/trusty/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.4.0/trusty)
- [`1.3.4`, `1.3` (*1.3/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.3.4)
- [`1.3.4-trusty`, `1.3-trusty` (*1.3/trusty/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.3.4/trusty)
- [`1.2.0`, `1.2` (*1.2/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.2.0)
- [`1.2.0-trusty`, `1.2-trusty` (*1.2/trusty/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.2.0/trusty)
- [`1.1.0`, `1.1` (*1.1/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.1.0)
- [`1.1.0-trusty`, `1.1-trusty` (*1.1/trusty/Dockerfile*)](https://github.com/peter-evans/nominatim-docker/tree/v1.1.0/trusty)

## Usage
Pass the `NOMINATIM_PBF_URL` environment variable to the container referencing the URL of your PBF file:

```bash
docker run -d -p 8080:8080 \
-e NOMINATIM_PBF_URL='http://download.geofabrik.de/asia/maldives-latest.osm.pbf' \
--name nominatim peterevans/nominatim:latest
```
The PBF file will be downloaded and the database will begin building. Note that very large databases may take hours to be built.

Tail the logs to verify the database has been built and Apache is serving requests:
```
docker logs -f <CONTAINER ID>
```
Then point your web browser to [http://localhost:8080/](http://localhost:8080/)

For documentation see [https://wiki.openstreetmap.org/wiki/Nominatim](https://wiki.openstreetmap.org/wiki/Nominatim)

## Persistent Storage
For a solution to persisting the database and immutable deployments check out [Nominatim for Kubernetes](https://github.com/peter-evans/nominatim-k8s).

## License

MIT License - see the [LICENSE](LICENSE) file for details
