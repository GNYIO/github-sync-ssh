#!/bin/sh -l

set -e

UPSTREAM_REPO=$1
BRANCH_MAPPING=$2

if [[ -z "$UPSTREAM_REPO" ]]; then
  echo "Missing \$UPSTREAM_REPO"
  exit 1
fi

if [[ -z "$BRANCH_MAPPING" ]]; then
  echo "Missing \$SOURCE_BRANCH:\$DESTINATION_BRANCH"
  exit 1
fi

echo "UPSTREAM_REPO=$UPSTREAM_REPO"
echo "BRANCHES=$BRANCH_MAPPING"

# split env var BRANCH_MAPPING
SOURCE_BRANCH=${BRANCH_MAPPING%%:*}
DESTINATION_BRANCH=${BRANCH_MAPPING#*:}
echo "source branch: ${SOURCE_BRANCH}"
echo "destination branch: ${DESTINATION_BRANCH}"


git remote set-url origin "git@github.com:$GITHUB_REPOSITORY.git"
git remote add tmp_upstream "$UPSTREAM_REPO"

# checkout branch

git fetch tmp_upstream
git fetch tmp_upstream --tags

git checkout ${SOURCE_BRANCH}

echo "print git tags: $(git tag)"

git reset --hard $(git describe --tags --abbrev=0)

git remote -v

git push --set-upstream origin ${BRANCH_MAPPING} --force
# git push origin "refs/remotes/tmp_upstream/${SOURCE_BRANCH}:refs/heads/${DESTINATION_BRANCH}" --force

git remote rm tmp_upstream
git remote -v
