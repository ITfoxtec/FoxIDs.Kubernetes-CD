# FoxIDs Kubernetes Continuous Delivery

This repository packages the continuous delivery assets used to run FoxIDs on Kubernetes. FoxIDs is a cloud-first identity and access control platform, and these manifests, bootstrapping scripts, and GitOps definitions let you deploy it reproducibly across environments.

## Highlights
- GitOps-first workflow driven by Argo CD, ensuring cluster state matches what is committed to this repo.
- Choice of single-instance or HA-cluster FoxIDs topologies, including clustered MongoDB and OpenSearch backends for higher availability.
- Bootstrap automation with either plain `kubectl` manifests or Terraform modules so you can pick the provisioning style that fits your platform team.
- Opinionated defaults for ingress, TLS certificates (Let's Encrypt via cert-manager), secrets templates, and domain naming to speed up initial setup while remaining customizable.
- Structured layout that separates stateless FoxIDs components, stateful data services, and supporting infrastructure for clarity and composability.

## Repository Layout
- **[Single-instance](single-instance)** - compact deployment for development, demos, or small installations with single instance MongoDB and OpenSearch. Includes Terraform, kubectl bootstrap, and the Argo CD application definitions.
- **[Single-instance console log](single-instance-console-log)** - The same as [Single-instance](single-instance) but without OpenSearch and logs in the console instead.
- **[HA-cluster](ha-cluster)** - production-focused deployment with horizontally scalable FoxIDs services plus MongoDB replica set and OpenSearch cluster. Provides detailed guidance and Argo CD apps for each subsystem.
- **[HA-cluster Istio](ha-cluster-istio)** - workspace reserved for service-mesh enabled topologies (Istio). Populate this when you need mTLS, traffic shaping, or mesh gateways in front of FoxIDs.

Each topology folder contains:
- `kubectl_setup/` - manifests and Kustomize overlays to bootstrap the cluster with core namespaces, secrets, and Argo CD.
- `terraform_setup/` - Terraform modules that apply the same bootstrap actions declaratively.
- `app/` - the Argo CD applications responsible for reconciling FoxIDs, MongoDB, OpenSearch, ingress, and supporting components once Argo CD is running.

## Deployment Flow
1. Clone the repository and choose the topology folder that matches your capacity and availability needs.
2. Search and replace placeholder domains such as `test-single-instance.foxids.com` or `test-ha-cluster.foxids.com`, along with placeholder email addresses like `xxx@my-domain.com`.
3. Provide cluster access by placing your `kubeconfig.yml` under the appropriate `kubectl_setup` or `terraform_setup` directory.
4. Bootstrap the cluster using either `kubectl` or Terraform instructions from the chosen topology README. This installs Argo CD and supporting primitives.
5. Point Argo CD at the `app/` manifests and monitor reconciliation. Argo CD will deploy FoxIDs services, databases, ingress, TLS issuers, and optional dashboards.
6. Continue managing releases through Git: merge changes to manifests, and let Argo CD propagate them to the cluster.

## Customization Checklist
- Update DNS records so Let''s Encrypt (via cert-manager) can validate your domains and issue certificates.
- Rotate the placeholder secrets (FoxIDs, MongoDB, OpenSearch, Argo CD) before moving to production.
- Adjust resource requests, storage classes, and replica counts to match workload expectations.
- Enable or disable optional components such as OpenSearch Dashboards depending on operational needs.

## Where to Go Next
- Read [single-instance/README.md](single-instance/README.md), [single-instance-console-log/README.md](single-instance-console-log/README.md), [ha-cluster/README.md](ha-cluster/README.md) or [ha-cluster-istio/README.md](ha-cluster-istio/README.md) for topology-specific prerequisites and sizing guidance.
- Explore e.g. [ha-cluster/app/README.md](ha-cluster/app/README.md) for a detailed breakdown of the HA-cluster GitOps applications and operational tips.
- Check the Terraform and kubectl setup folders for step-by-step bootstrap instructions tailored to your tooling.

Contributions and adaptations are welcome. Adjust the manifests to align with your organization''s standards, and keep changes under version control so Argo CD can manage them automatically.








