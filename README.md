# Download file from URL and cache it in GitHub Actions

This GitHub Action downloads a file from a specified URL and caches it to avoid repeated downloads on subsequent runs.

## Overview

This action:
- Accepts a file URL and optional download destination, filename, and SHA256 hash.
- Checks if the file is already cached using the URL as the cache key.
- Downloads the file if it isn't cached.
- Verifies the file's SHA256 hash if one is provided (validates both cached and newly downloaded files).
- Caches the downloaded file for future runs (only if verification passes).

## Inputs

- **url**: *Required.* The URL of the file to download.
- **destination**: *Optional.* The directory where the file will be saved. Default is `temp`.
- **filename**: *Optional.* The name to assign to the downloaded file. If not provided, the action will use the basename from the URL.
- **sha256**: *Optional.* Expected SHA256 hash of the file (hex string). If provided, the downloaded or cached file will be verified against this hash. The action fails if they do not match.

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
          sha256: '1234567890123456789012345678901234567890123456789012345678901234'
      - name: Use downloaded file
        run: echo "File downloaded to ${{ steps.download.outputs.filepath }}"
```

## License

WTFPL
