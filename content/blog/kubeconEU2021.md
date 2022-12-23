+++
title = "KubeCon / Cloud Native Con Europe 2021"
date = 2021-12-07T00:00:00+00:00
tags = []
categories = []
+++

I went to Virtual KubeCon EU, almost 2 weeks ago. I wrote down some notes, and thought it might be interesting to share them on my blog to wake it up from it's slumber.

**UPDATE 07/12/2021**: I realise this blogpost is not really coherent, as it came forth from my note taking during the event. I cleaned it up a bit, and I want to publish this, but it is not as polished as I would like. The event is too long ago to recall everything properly, so I decided to spend time on writing new content instead of making this one really great.

Also, realizing I'm typing this just after Kubecon NA is funny to me. I didn't really pick up any talks from that event.

## 5 May

### Keynote day 1

The keynotes were pretty generic as expected. A bunch of partner spotlights and generic stuff.

- More cloudnative due to COVID
- Need to get the end users in scope
- More connected devices due to 5g?
- Digital transformation is no longer a buzzword
- Focus on COVID...
- More than 20% growth in CNCF member companies
- #TeamCloudNative

Quote: Let's build for the ultimate end user, the human experience and make our lives safer, healthier, and happier

Peleton had to scale massively during COVID to enable people to workout at home. They used a lot of CloudNative technologies to enable this.

RedHat is working on a minimal kubernetes API which provides multi-tenant support, isolating crds between different teams.

- github.com/kcp-dev/kcp

Justin Cormack from Docker gave us an overview of all CNCF sandbox projects. Of which there are a lot. Tool selection is getting harder.

A presentation from Weaveworks about Flux. Flux is a very nice project on which I am building a proof of concept in my own time. Managing more and more Kubernetes clusters and making sure the config is in sync is getting old quick. Flux helps by keeping clusters in sync by using a git repository as a single source of truth.

- GitOps Toolkit Flux

Liz Rice gave an update on how Kubernetes SIGs were renamed to TAG (Technical Advisory Group) and which ones are available

- App Delivery
- Contrib-strat
- Security
- Runtime
- Observability
- Storage
- Network

[Live Tweet of Keynotes](https://twitter.com/breakawaybilly/status/1389856081799692289)

### Session: DEMYSTIFYING CLOUD NATIVE CONCEPTS FOR THE BUSINESS WORLD

- More tech-savvy business leaders
- Tech dicisions are made by leadership and board
- We need to be able to communicate technical topics with business leaders
- We need shared terms, let's start with an open source glossary

### Session: CLOUDEVENTS - LOOKING BEYOND EVENT DELIVERY

Cloud events wants to standardize how events are formatted. Talk about the format of this standard using multiple transport methods.

SDKs are available for multiple languages. You can pick from multiple transports (mqtt, nats, kafka, http)

For consuming these events, a discovery API should be provided. This API should tell what system produces APIs of interests, which events are produced and how to subscribe to them. Cloudevents wants to deliver an API specification with an http / json mapping.

To subscribe to events, a subscription api needs to be provided. In this API, consumers can subscribe to events and tell systems where to publish these events.

Another part is a schema registry, which defines the openapi specifications for all events in an organisation.

### Session: How DoD Uses K8s and Flux to Achieve Compliance and Deployment Consistency - Michael Medellin & Gordon Tillman, Department of Defense

The DoD has some interesting challenges

- Globally distributed
- Multiple air-gapped networks
- Commercials & On-Prem infra
- Compliance & regulatory challenges

They solved that by:

- Use flux to add security to their Kubernetes environment
  - All in Gitlab
  - Signed commits
- Cluster API
- Rancher for k8s management
- Terraform for initial provisioning of networking
- Setup nodes with load balancer in management cluster
- Populate cluster-specific secrets in Hashicorp Vault
- Service prerequisites
  - Istio
  - Flux
  - Bitnami sealed secrets
- New cluster is added to manifest for common deployment with Flux. (Ingress, host security, etc)
- Application teams also use Flux for deployment
- CRDS are used to standup standard services like databases

The way they do governance is really interesting to me!

### Session: SEAMLESS MULTI-CLUSTER COMMUNICATION AND OBSERVABILITY WITH LINKERD - MAX KÖRBÄCHER, LIQUID REPLY

Session started with some research in how clusters are partitioned. Per app, per domain, all in one cluster etc.

More clusters means more management and more complexity, which leads to more stuff that can break.

Linkerd provides some help to solve this problem

- mTLS for free
- Observability out of the box
- Service mirroring for easy connection between clusters

This reminds me of the Consul demo I have laying around and need to finish.

Look into linkerd service mirroring. (uses annotations?) What is the advantage over Consul / Istio multi DC?

take aways:

- Existing apps need to update the endpoints they call
- Linkerd upgrades are hard
- Service Meshes are a rabbit hole, think twice before you use them.

## 6 May

### Keynote day 2

Kubernetes moves to three releases per year. (Instead of four) tThis will allow for more focus on quality, discussions and overall the state of the project. It is seen as a quality of life improvement.

TODO more research on this topic as the presentation was a bit onsamenhangend.

PSP will be depricated! Move to OPA / Kyverno

focus on security, automation and governance?

Interesting story by DT about their Kubernetes story.

- github.com/telekom/das-shiff

### Session: The Art of Hiding Yourself - Lorenzo Fontana, Sysdig

Lorenzo from Sysdig shows us how to persist his rogue access in our Kubernetes cluster without us noticing. ;-)

- Environmental awareness
- Persistency

Hiding processes using libprocesshider.

Mitigations:

- Secure boot
- Rootless container
- R/O Filesystem
- System updates

Awesome demo as always. ;-)

[libprocesshider](https://github.com/gianlucaborello/libprocesshider/blob/master/processhider.c)
[blog](https://sysdig.com/blog/hiding-linux-processes-for-fun-and-profit/)

### Session: HACKING INTO KUBERNETES SECURITY FOR BEGINNERS - ELLEN KÖRBES, TILT & TABITHA SABLE, DATADOG

Ellen starts with trying to exploit her dev cluster starting with what looks like investigation switching to a black hat half way the demo. ;-) Fun stuff.

Tabitha starts with a throwback to the AWESOME talk by Brad and Ian of last year.

[Brad & Ian's talk](https://www.youtube.com/watch?v=auUgVullAWM)

This talks was an amazing story about security within Kubernetes delivered in a hillarious story and gave insight on what attack vectors are present within Kubernetes.

[k8s vulns mailing list](https://groups.google.com/g/kubernetes-security-announce?pli=1)

### Session: When Prometheus Can’t Take the Load Anymore - Liron Cohen, Riskified

Problems / challenges with Prometheus

- Started with two prometheus servers scraping the same targets
  - Didnt scale
  - No real HA
  - Retention

Possible solutions:

- M3
- Thanos
- Cortex

Similarities:

- Written in Go
- Opensource
- Compatible with Prom
- Long term storage
- Global queries & views
- Horizontally scalable

focus on Performance, Ha, costs and operational complexity

M3 uses Prometheus and writes to a horizontally scalable m3db. Managed / coordinated by etcd.

Advantages:

- Data resides in cluster
- Push model
- Few components
- Cache

Disadvantages

- Complex to operate
- External dependencies?
- Push model?

Cortex

TODO look into architecture

Prom remote write to Cortex distributor -> Cortex Ingester. K/V in Consul or ETCD. Writes to Big Table / Cassandra / Dynamo, S3 and Memcache.

Advantages

- Query frontend
- Caching
- Psh based
- Chunk storage for performance, block storage for easier / cheaper storage

Disadvantage

- Complexity
- External dependencies
- Push based
- Chunks is expensive, Block storage is lower performance

Thanos uses a sidecar next to Prometheus pushing to object storage
TODO Look into architecture

Advantages

- Simple architecture
- Gradual deploy
- Block storage
- Pull and Push based model
- Query frontend improves performance

Disadvantages

- Block storage is slower
- Push / Pull based model
- Query frontend doesn't cache as well

In the end it doesn't really matter which one you pick. Presenter took Thanos for simplicity.

## 7 May

### Keynote day 3

Cloud Native & WebAssembly: Better Together - Liam Randall, Founder, Cosmonic & Co-Founder, Wasmcloud & Ralph Squillace, Principal PM, Azure Core Upstream, Microsoft Azure (10:00-10:15) Starts about the decoupling of physical hardware. But not decoupling gets harder. WASM might be the solution as it builds on the entire cloud native ecosystem. WASM is a polyglot compilation target for the web.

- Bytecode alliance
- Compile Go to WASM

Meshes are awesome

- Discovery
- Consume
- Connect
- Observe

Layer 7: mostly http traffic
Layer 3: Network Service Mesh (networkservicemesh.io)
Streaming media - github.com/media-streaming-mesh (based on UDP)
Public Health Data Mesh: bit-broker.io

RISC-V is a cool new movement regarding an open api to hardware. Which is super interesting and I need to read up on that as well...

### Session: Trust No One: Bringing Confidential Computing to Containers - Samuel Ortiz, Intel & Eric Ernst, Apple

Confidential computing is making the guest workload no longer trust the host shared components. Only the tenant can see & modify the its data. The infra owner (CSP) no longer needs to be trusted. I have done some research on this subject in December 2020 for my current customer engagement and it was good to refresh upon the subject.

Requirements:

- Host software can no longer see & tamper with the tenants data
- Tenant needs to be able to verify where, what and how it is running

Data can be in transit with VPNs, TLS. It's protected and we know how to do it.
Encryption at rest can also be done easily

Data in use is harder since we need to encrypt the memory we are using and our data moves through the CPU. (Which can be eavesdropped on)

Dependencies:

- Hardware support (Intel TDX, IBM PEF. AMD SEV)
  - Memory encryption and integrity
  - CPU state encryption and integrity
  - Quoting and assestation
  - All designed as virtualization extensions
- Software
  - You need to run as a VM
  - Talk to Hypervisor API's (KVM + QEMU, Hyper-V)

How to apply to containers

- Abstract all hw and software dependencies to container runtime
- Runc does not talk to KVM
  - Cannot access conf compute hw extensions
  - Cannot protect tenant data when it is in use
- CRI runtime mount container images on the host
  - Which means the host can read the content

Solution space:

Kata containers <--- Most natural solution
Firecracker
gVisor

- Container needs to run inside a vm
  - Use HW virt as an isolation layer

Fully offload to the guest

- Offload CRI image services to the guest entirely
- Guest to pull, decrypt, verify, mount and store container images
- Will use a lot of disk / cpu and network bandwith

Mixed:

- Host pulls images, shares layers with guests
- Guest decrypts, verifies and mount

Attestation service. kata-agent.

Impact on infra operator

- Container introspection no longer available. This is the goal though.
- Manage the number of keys as a finite resource

We need VMs. For end users, not much should change. This is a work in progress and requires more work.

[link](https://github.com/kata-containers/kata-containers/issues/1332)

### Session: Open Policy Agent Intro - Ash Narkar, Styra & Oren Shomron, VMware

OPA wants to unify policy enforcement across the stack. Services can offload policy decision to OPA by querying it. It is up to the service to enforce the policy, decision is made by OPA based on the rego policy.

OPA is written in Go and runs as a sidecar or a host-level daemon. It can be compiled to WASM. It contains a management api for control and visibility. Which can be used for offline auditing.

OPA supplies tooling to build, test and debug policies.

[Conftest](https://conftest.dev)

Gatekeeper is an extensible admission controller for K8S using OPA policies.
Gatekeeper is also able to inject / modify requests. e.g. insert sidecarts or add labels.

### Session: Traces from Events: A New Way to Visualise Kubernetes Activities - Bryan Boreham, Weaveworks

Events in k8s can be sent to something that can compose them as spans so we can correlate it.

weaveworks-experimental/kspan picks up all events and creates spans from then, and sends them into Jaeger. Pretty cool technology to debug things going wrong in K8S!

[source](https://github.com/weaveworks-experiments/kspan)

## Replays

I've watched some replays of talks as well, as so much is going on at the same time.

### Session: From Tweet to BadIdea: Creating an Embeddable Kubernetes Style API Server - Jason DeTiberus, Equinix Metal

Jason DeTiberus came up with a 'bare-bones' API server which does not require a full Kubernetes cluster and can be embedded in applications to support CRDS

Use cases:

- Rapid application development using CRDs for standalone binaries without needing a hard dependency on Kubernetes.
- Bootstrapping infrastructure management tooling, such as Cluster API (to avoid needing a Kubernetes cluster before you have a Kubernetes cluster)

[Github organisation](https://github.com/thetirefire/)

### Session: Cluster API Deep Dive - Jason DeTiberus, Equinix Metal & Marcel Mue, Giant Swarm

The Cluster API is a Kubernetes project to bring declarative, Kubernetes-style APIs to cluster creation, configuration, and management. It provides optional, additive functionality on top of core Kubernetes to manage the lifecycle of a Kubernetes cluster.

Cool demo about Cluster API being used to created Kubernetes clusters

### Session: Notary v2: Supply Chain Security for Containers - Justin Cormack, Docker & Steve Lasker, Microsoft

The solarwinds attack was a wake-up call for a lot of people to not always trust software running in your supply chain / CI-CD environments. It would be nice if containers, like freight containers, come with a bill of material, their content and are signed off upon. Managing signatures involves a lot of key to be managed, and it is not something native to registries. Also, people like to detach the container and the signature, so it is easy to add signatures afterwards. In the end, people want to be able to validate what they are running in their container platform.

Container signing is not being used a lot. The idea is to make it easier to start using it. Notary is working on the base infrastructure to support this.

A usable signing solution will be shipped by the second half of 2021 with iterative updates. You will also be able to attach metadata in the form of JSON documents to images using the same mechanics.

## Interesting projects that require more research

- Portainer
- Keptn
- Jaeger
- Falco
- Helm
- Cloud Custodian
- Cuelang
- Flagger
  - [docs](https://docs.flagger.app/)
- Ambassador
  - [developer control plane](https://blog.getambassador.io/introducing-the-ambassador-developer-control-plane-339c97fa4716)
- Tilt
- OpenFAAS
- ClusterAPI
- [https://spiffe.io/](spiffe)
- Contour