# Local Docker Registry

A simple local Docker registry for storing and managing Docker images.

## Quick Start

1. Start the registry:
   ```bash
   docker-compose up -d
   ```

2. Test the registry:
   ```bash
   curl http://localhost:32000/v2/_catalog
   ```

## Usage

### Push an image to the registry:
```bash
# Tag your image for the local registry
docker tag your-image:latest localhost:32000/your-image:latest

# Push to the registry
docker push localhost:32000/your-image:latest
```

### Pull an image from the registry:
```bash
docker pull localhost:32000/your-image:latest
```

### List images in the registry:
```bash
curl http://localhost:5000/v2/_catalog
```

### List tags for a specific image:
```bash
curl http://localhost:32000/v2/your-image/tags/list
```

## Configuration

- **Port**: 32000 (accessible at localhost:32000)
- **Storage**: Persistent volume `registry-data`
- **Delete enabled**: Yes (can delete images)
- **Max threads**: 100

## Stop the registry:
```bash
docker-compose down
```

## Clean up (removes all data):
```bash
docker-compose down -v
``` # registry
