#!/bin/bash
set -e

echo
echo "  Configs:"
echo "  - api-key: $api_key"
echo "  - platform: $platform"
echo "  - app_version: $app_version"
echo "  - build_number: $build_number"
echo "  - bundle_filepath: $bundle_filepath"
echo "  - source_map_filepath: $source_map_filepath"
echo

[[ $bundle_filepath != /* ]] && bundle_filepath="${BITRISE_SOURCE_DIR}/$bundle_filepath"
[[ $source_map_filepath != /* ]] && source_map_filepath="${BITRISE_SOURCE_DIR}/$source_map_filepath"

echo
echo "Using $("${BITRISE_SOURCE_DIR}/node_modules/.bin/bugsnag-source-maps" --version)"
echo

platform="$(echo $platform | tr '[:upper:]' '[:lower:]')"

ARGS=(
    "--api-key" "${api_key}"
    "--platform" "${platform}"
    "--bundle" "${bundle_filepath}"
    "--source-map" "${source_map_filepath}"
    "--project-root" "${BITRISE_SOURCE_DIR}"
    "--app-version" "${app_version}"
    )

case "$platform" in
  android)
    ARGS+=("--app-version-code" "$build_number")
    ;;
  ios)
    ARGS+=("--app-bundle-version" "$build_number")
    ;;
esac

echo
set -x

${BITRISE_SOURCE_DIR}/node_modules/.bin/bugsnag-source-maps upload-react-native ${ARGS[@]}

{ set +x; } 2>/dev/null
echo

# TODO: validate inputs (required, file exists, valid values)
# TODO: check for @bugsnag/source-maps and install it?