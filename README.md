# Scripts for copying images to a internal registry

### Prerequisites

- [Skopeo](https://github.com/containers/skopeo)

### Usage

```shell
get_images_from_helmchart.sh <helmchart> <image_list_file> [version]
```

if no version specified `latest` is used

```shell
copy_images_to_repository.sh <image_list_file> <repository>
```

`docker.io/rancher/rancher` will become `registry.example.com/docker.io/rancher/rancher`

```shell
copy_images_to_repository_with_project.sh <image_list_file> <repository> <project>
```

`docker.io/rancher/rancher` will become `registry.example.com/project/rancher`

```shell
copy_images_to_archive.sh <image_list_file> <archivename> [platform]
```

**docker needed**
