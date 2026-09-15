# Subscription Manager

## What is it?

`subscription-manager` is the RHEL client used to register systems and manage subscriptions, entitlements, and repositories.

It communicates with [[Candlepin]], either through Red Hat Customer Portal or [[Red Hat Satellite]].

## Common Tasks

* Register a host
* Attach subscriptions
* Enable repositories
* Check subscription status

## Common Commands

```bash
subscription-manager status
subscription-manager identity
subscription-manager register
subscription-manager repos --list-enabled
```
