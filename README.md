# Download and cache a file in GitHub Actions

This GitHub Action downloads a file from a URL and caches it for subsequent workflow runs. It can also verify the file against an expected SHA-256 checksum.

## Overview

This action:

- Accepts a file URL and optional destination, filename, and SHA-256 checksum.
- Uses the expected SHA-256 checksum as the cache identity when provided; otherwise, it uses a hash of the URL.
- Downloads the file when no matching cache entry is available.
- Verifies both downloaded and cached files when an expected SHA-256 checksum is provided.
- Caches a newly downloaded file only after any requested verification succeeds.

## Usage notes

- Use this action only for files whose contents are fixed and predictable. It is not suitable for URLs whose contents can change, because a cached response may continue to be reused.
- Providing `sha256` is strongly recommended to ensure that the downloaded or cached file contains the expected data.
- If `sha256` is omitted and an HTTP error response, such as a 5xx error page, is cached unexpectedly, delete the corresponding cache entry from the repository's GitHub Actions cache management page before rerunning the workflow.
- The default filename is derived only from the literal URL path; the action does not inspect the HTTP response or the final redirected URL for a filename. When the URL does not end with the intended filename, provide the `filename` input explicitly.

## Inputs

- **url**: *Required.* The URL of the file to download. It must not be empty or contain line breaks.
- **destination**: *Optional.* The directory in which to save the downloaded file. The default is `temp`. Line breaks, backslashes, glob characters (`*`, `?`, `[` and `]`), and a leading `#`, `!`, or `~` are not allowed.
- **filename**: *Optional.* The name to use for the downloaded file. It must be a single filename rather than a path, and it cannot contain glob characters (`*`, `?`, `[` and `]`). When omitted, it is derived from the final component of the URL path after the query string and fragment are removed.
- **sha256**: *Optional.* The expected SHA-256 checksum as a 64-character hexadecimal string. When provided, both downloaded and cached files are verified against it, and the action fails if verification does not succeed.

## Outputs

- **filename**: The resolved name of the downloaded file.
- **filepath**: The path to the downloaded file. If the `destination` is a relative path, this value will also be a relative path.

## Usage

Example workflow:

```yaml
jobs:
  your-job:
    runs-on: ubuntu-latest
    steps:
      - name: Download and cache file
        id: download
        uses: mercury233/action-cache-download-file@v1.3.0
        with:
          url: 'https://example.com/file.zip'
          destination: 'downloads'
          filename: 'example.zip'
          sha256: '1234567890123456789012345678901234567890123456789012345678901234'
      - name: Use downloaded file
        env:
          DOWNLOADED_FILEPATH: ${{ steps.download.outputs.filepath }}
        run: printf 'File downloaded to %s\n' "$DOWNLOADED_FILEPATH"
```

## License

WTFPL
