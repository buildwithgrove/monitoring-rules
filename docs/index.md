# Monitoring Rules

## Falco Rules

> The files containing the falco rules should be created as: `rules.yaml`

### Rules

Conditions under which an alert should be generated. A rule is accompanied by a descriptive output string that is sent with the alert.

### Macros

Rule condition snippets that can be re-used inside rules and even other macros. Macros provide a way to name common patterns and factor out redundancies in rules.

### Lists

Collections of items that can be included in rules, macros, or other lists. Unlike rules and macros, lists cannot be parsed as filtering expressions.

## Prometheus Alertmanager Rules

### Alert rules

Alerting rules allow you to define alert conditions based on Prometheus expression language expressions and to send notifications about firing alerts to an external service. Whenever the alert expression results in one or more vector elements at a given point in time, the alert counts as active for these elements' label sets.

> The file containing the alert rules should be created as: `alerts.rule.yaml`

### Alert unit tests

You may define a [unit test file](https://prometheus.io/docs/prometheus/latest/configuration/unit_testing_rules/) to test your rules based on predefined input series and expected outputs.

> The file containing tests should be created as: `alerts.test.yaml`

Then execute the unit test running:
```
promtool test rules /path/to/alerts.test.yaml
```

### Record rules

Recording rules allow you to precompute frequently needed or computationally expensive expressions and save their result as a new set of time series. Querying the precomputed result will then often be much faster than executing the original expression every time it is needed. This is especially useful for dashboards, which need to query the same expression repeatedly every time they refresh.

> The file containing the record rules should be created as: `records.rule.yaml`
