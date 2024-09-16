# Docker Build and Push Reusable Workflow

This GitHub Actions workflow automates the process of building and pushing Docker images to an Azure Container Registry (ACR). It provides flexibility through input parameters, allowing customization for different Dockerfile paths, image names, versions, and tagging options.

## Usage

To use this reusable workflow, call it from another workflow in your repository:

### Example Workflow

```yaml
name: Build and Deploy

on:
  push:
    branches:
      - main

jobs:
  deploy:
    uses: ./.github/workflows/docker-build-push.yml
    with:
      registry_url: 'yourregistry.azurecr.io'
      image_name: 'your-image-name'
      version: '1.0.0'  # Optional: If not provided, uses GitHub run number as version.
      latest_tag: true  # Optional: Set to 'true' to tag the image as 'latest'.
      dockerfile_path: '.'  # Optional: Path to the Dockerfile. Defaults to the root directory.
    secrets:
      ACR_USERNAME: ${{ secrets.ACR_USERNAME }}
      ACR_PASSWORD: ${{ secrets.ACR_PASSWORD }}
```
## Inputs

- **`registry_url`** (required): The URL of your Azure Container Registry (e.g., `yourregistry.azurecr.io`).
- **`image_name`** (required): The name of the Docker image to build and push.
- **`version`** (optional): The version tag for the Docker image. If not provided, the workflow uses the GitHub run number to set the version in the format `0.0.<run_number>`.
- **`latest_tag`** (optional, boolean, default: `false`): Set to `true` to push the image with the `latest` tag.
- **`dockerfile_path`** (optional, default: `.`): The path to the directory containing the Dockerfile. If not provided, it defaults to the root directory.

## Secrets

- **`ACR_USERNAME`** (required): The username for the Azure Container Registry.
- **`ACR_PASSWORD`** (required): The password for the Azure Container Registry.

## Workflow Details

This reusable workflow performs the following steps:

1. **Check out the Repository**: Uses `actions/checkout@v4` to check out the repository containing the Dockerfile.

2. **Set Version**: Checks if a version input is provided. If not, it defaults to `0.0.<GitHub run number>`.

3. **Log in to Azure Container Registry**: Logs into the specified ACR using the provided secrets (`ACR_USERNAME` and `ACR_PASSWORD`).

4. **Build Docker Image**: Builds the Docker image using the specified Dockerfile path and tags it with the version.

5. **Push Docker Image**: Pushes the Docker image to the specified ACR with the given version tag.

6. **Push "Latest" Tag (Optional)**: If `latest_tag` is set to `true`, it tags the image as `latest` and pushes it to the ACR.

7. **Log out from Azure**: Logs out from the Azure Container Registry.

## Notes

- Ensure that the Dockerfile exists in the specified path when calling the workflow.
- The workflow supports using the GitHub run number as a versioning mechanism if no explicit version is provided.
- Make sure to add `ACR_USERNAME` and `ACR_PASSWORD` as secrets in your GitHub repository for authentication.

## Example Use Cases

- **Automated Docker Builds**: Integrate this workflow into your CI/CD pipeline to automate building and pushing Docker images to your ACR.
- **Versioned Deployments**: Use the `version` input to manage and deploy specific versions of your application.
- **Tagging as "Latest"**: Enable the `latest_tag` option to maintain an up-to-date "latest" tag for your Docker images.

