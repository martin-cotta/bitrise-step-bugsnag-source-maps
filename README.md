# Bugsnag source maps step

Process and upload React Native source map & bundle to [Bugsnag](https://www.bugsnag.com/)

## Usage

```yaml
# bitrise.yml

- git::https://github.com/<fork-name>/bitrise-step-bugsnag-source-maps@main:
    title: Upload source map & bundle to Bugsnag
    inputs:
    - api_key: "<bugsnag-api-key>"
    - platform: "android | ios"
    - app_version: "1.0.0"
    - build_number: "1234"
    - bundle_filepath: "./path/to/main.jsbundle"
    - source_map_filepath: "./path/to/main.jsbundle.map"
```

That's all ;)
