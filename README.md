# github-sync-ssh action

## Inputs

## Outputs

## Example usage

on:
  schedule:
  - cron:  "*/15 * * * *"
jobs:
  repo-sync:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: repo-sync
      env: 
        SSH_PRIVATE_KEY: ${{secrets.SSH_PRIVATE_KEY}}
      uses: repo-sync/github-sync@v2
      with:
        source_repo: "git@github.com:GNYIO/gny-experiment.git"
        source_branch: "develop"
        destination_branch: "master"
