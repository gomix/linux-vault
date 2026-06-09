# Candlepin

## What is Candlepin?

Candlepin is an open-source subscription management service used to track software entitlements, subscriptions, and system registrations.

It is a core component of Red Hat Satellite and provides the backend services used to manage subscriptions and content access.

## Why is Candlepin Important?

Candlepin is responsible for:

- Subscription management
- Entitlement tracking   
- System registration
- Content access authorization
- License consumption tracking

Without Candlepin, systems would not know which repositories they are entitled to access.

## Common Use Cases

### Host Registration

Register a system to a Satellite server.

### Subscription Assignment

Attach subscriptions to registered systems.

### Content Access

Determine which repositories a system can consume.

### Compliance Reporting

Track subscription utilization and entitlement status.

## Architecture

```text
Managed Host
    │
    ▼
Subscription Manager
    │
    ▼
Candlepin
    │
    ├── Entitlements
    ├── Consumers
    ├── Pools
    └── Subscriptions
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

|Component|Purpose|
|---|---|
|Foreman|Provisioning and inventory|
|Katello|Content lifecycle management|
|Pulp|Repository management|
|Candlepin|Subscription management|

## References

- [https://www.candlepinproject.org/](https://www.candlepinproject.org/)
