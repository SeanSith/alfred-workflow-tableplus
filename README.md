# Alfred Workflow for TablePlus

An Alfred [Workflow](https://www.alfredapp.com/help/workflows/) for executing connections to databases with [TablePlus](https://tableplus.com).

## Requirements
- Ruby >= 2.x with Bundler (macOS system installed is preferred)
- TablePlus
  - [Direct from website](https://tableplus.com)
  - [Homebrew](https://brew.sh)
  - [SetApp](https://setapp.com)

## Configuration

All custom configuration is handled via Alfred Workflow Configuration or [Environment Variables](https://www.alfredapp.com/help/workflows/advanced/variables/#environment).

### Custom Configuration Path

- [TODO] `TABLEPLUS_SHARED_CONNECTION_PATH` - Filesystem path to TablePlus Connections and ConnectionGroups Plist files

## Development

To update the Alfred package metadata and create a `.alfredworkflow` file, run `bundle exec rake alfred:release`
