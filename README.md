# Download file from URL and cache it in GitHub Actions

This GitHub Action downloads a file from a specified URL and caches it to avoid repeated downloads on subsequent runs.

## Overview

This action:
- Accepts a file URL and optional download destination and filename.
- Checks if the file is already cached using the URL as the cache key.
- Downloads the file if it isn't cached.
- Caches the downloaded file for future runs.

## Inputs

- **url**: *Required.* The URL of the file to download.
- **destination**: *Optional.* The directory where the file will be saved. Default is `temp`.
- **filename**: *Optional.* The name to assign to the downloaded file. If not provided, the action will use the basename from the URL.

## Outputs

- **filename**: The name of the downloaded file.
- **filepath**: The path to the downloaded file. If the `destination` is a relative path, this value will also be a relative path.

## Usage

Below is an example workflow usage:

```yaml
jobs:
  your-job:
    runs-on: ubuntu-latest
    steps:
      - name: Download and cache file
        id: download
        uses: mercury233/action-cache-download-file@v1
        with:
          url: 'https://example.com/file.zip'
          destination: 'downloads'
          filename: 'example.zip'
      - name: Use downloaded file
        run: echo "File downloaded to ${{ steps.download.outputs.filepath }}"
```

## License

WTFPL
