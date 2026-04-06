+++
title = "Designing Azure topologies for scale and security"
date = 2021-10-16T00:00:00+00:00
draft = true
tags = []
categories = []
+++

In the last three years at my current engagement, I have been working on managing a SAAS application in the public cloud. Azure is the platform of choice, and the infrastructure supporting the application was setup in an ad-hoc way. As the company started, it aimed to provide value to its customers as soon as it could. Our infrastructure team focussed on delivering services to our development teams and business stakeholders. Less time was spent on topics like governance and architecture. Understandable, because you want to become prifitable soon, which is done by aquiring a steady inflow of money.

Looking at the existing environment at that time, there were points that could be improved upon.

- Naming conventions were attempted but not followed in a strict way, causing resources being named in an inconsistent way
- Creating of infrastructure was done by running an occassional ARM template, ad-hoc scripts or by clicking resources together in Azure Portal manually.
- Our application is running on Kubernetes, but instead of the Azure Kubernetes Service offering, the company had decided to roll their own solution on top of VMs
  - At the time, this was due to AKS being deemed not mature enough to support the companies needs
- All infrastructure was ran in one Azure subscription
  - In this Azure subscription, a lot of high privileged access was available for the infrastructure team, at all time.

In order to scale the environment in the future, and make things more secure, we decided to make some architectural changes. The following constraints were taken into account:

- We have a small team with a broad scope of responsibilities
- An "Azure First" strategy
- As in every company: being cost effective

During the last three years, I was involved in multiple projects, slowly but steadily inproving on existing systems, bringing architecture in place and getting our environments to the next level of maturity. I believe in a iterative approach, and by using the smallest amount of work/tech/steps possible to get the biggest pay-back. As always, projects are much more complex than you initially scope as the business adds complexity to standards. Fortunately this is what keeps it fun.
## Migrate to Azure Kubernetes Service

One of the first things we did was starting to migrate our home-grown Kubernetes clusters to AKS. These clusters were composed of individual vms, with Chef managing the Kubernetes installation. Upgrades were a bit painfull and took a lot of work. You also need to take care of a lot of things that a cloud provider can do for you instead.

- Certificate management is a manual process if not setup correctly
- Cluster nodes are nursed back to health when they are not feeling well. In a managed service, the node would get decommissioned and replaced by a new one
- Kubernetes composes of many individual components. Even though I feel it is required to know how the system works, even when using a cloud provider which does the bulk of the work, it is important to know how Kubernetes works under the covers to debug issues. Not having to maintain all these components leaves a lot of time to spend on work that will actually bring value to the business.

The migration was a big topic and we had a lot of involvement from stakeholders. It felt like a big thing, but looking back... it was a non-issue. We started with a proof of concept, learning how Azure Kubernetes Service behaves. After learning a lot of lessons, an architetural overview was created. We wrote a script which we use to rollout the cluster in a standardized way, and did this for all clusters we had. As the API Kubernetes offers is the same anywhere, we hardly had to do rework. And the migration went pretty smoothly.

Things that changed for us:

- We're using Azure CNI, which gives all pods a 'real' IP address in the VNETs we use
- Kubernetes control plane maintenance was no longer done by ourselves, but by Azure
- Clusters automatically scale up and down to save costs
  - We're using the awesome downscaler project to stop applications from running outside of office hours in certain environments. This causes AKS to remove compute nodes from the scalesets, which in turn save costs
- We added the Kured application, to ensure nodes reboot in a safe way when kernel patches are rolled out by AKS
- It became much easier to rollout new clusters to support the business

## Introduce a formal naming convention

## Move to a hub-spoke topology

### Architectural overview

### Use Infrastructure as Code

#### Terraform and Terragrunt

#### Continuous Delivery

## Make this scale for multiple SAAS instances

## Improvements
