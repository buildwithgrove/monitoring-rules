#!/usr/bin/env bash

set -e

mkdir -p rules/alertmanager
mkdir -p rules/falco

find . -type f \( -iname "alerts.rule.yaml" -or -iname "records.rule.yaml" ! -iname ".*" \) \
| while read line
do
    echo "Copying $line..."
    cp $line "./rules/alertmanager/$(echo $line | sed -r -e "s|^\./||" -e 's/[\/]+/-/g')"
done

kubectl -n thanos create configmap rules-config --from-file=./rules/alertmanager -o yaml --dry-run > rules/alertmanager/rules-configmap.yaml
sed -i.bak '1s/^/---\n/' rules/alertmanager/rules-configmap.yaml


find . -type f \( -iname "rules.yaml" ! -iname ".*" \) \
| while read line
do
    echo "Copying $line..."
    cp $line "./rules/falco/$(echo $line | sed -r -e "s|^\./||" -e 's/[\/]+/-/g')"
done

kubectl -n falco create configmap rules-config --from-file=./rules/falco -o yaml --dry-run > rules/falco/rules-configmap.yaml
sed -i.bak '1s/^/---\n/' rules/falco/rules-configmap.yaml

find ./rules -type f -name '*.yaml.bak' -delete
