# Pulp

## What is Pulp?

Pulp is an open-source content management platform used to mirror, manage, and distribute software repositories.

It is commonly used to manage RPM, container, Python, Debian, and other package repositories.

## Why is Pulp Important?

Pulp provides:

* Repository synchronization
* Content storage
* Content publication
* Repository versioning
* Content distribution

Pulp is a core component of several enterprise products, including Red Hat Satellite.
## Common Use Cases

### RPM Repositories

* Mirror Red Hat repositories
* Mirror EPEL repositories
* Internal package distribution
### Container Images

* Mirror container registries
* Distribute container images internally

### Python Packages

* Mirror PyPI repositories
* Provide local package caches

## Architecture

```text
Client
  │
  ▼
Published Repository
  │
  ▼
Distribution
  │
  ▼
Repository Version
  │
  ▼
Repository
  │
  ▼
Content
```

## Relationship with Other Technologies

```text
Red Hat Satellite
├── Foreman
├── Katello
├── Pulp
└── Candlepin
```

### Component Roles

| Component | Purpose                                |
| --------- | -------------------------------------- |
| Foreman   | Provisioning and inventory             |
| Katello   | Content lifecycle management           |
| Pulp      | Repository synchronization and storage |
| Candlepin | Subscription management                |
## References

* https://pulpproject.org/
* https://theforeman.org/plugins/katello/
