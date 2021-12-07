+++
title = "Designing Azure topologies for scale and security"
date = 2021-10-16T00:00:00+00:00
draft = true
tags = []
categories = []
+++

In the last three years at my current engagement, I have been working on managing a SAAS application in the public cloud. Azure is the platform of choice, and the infrastructure supporting the application was setup in an ad-hoc way. As the company started, it aimed to provide value to its customers as soon as it could. Our infrastructure team focussed on delivering services to our development teams and business stakeholders. Less time was spent on topics like governance and architecture.

Looking at the existing environment at that time, there were points that could be improved upon.

- Naming conventions were attempted but not followed in a strict way, causing resources being named in an inefficient way
- Our application was running on Kubernetes, but instead of the Azure Kubernetes Service offering, the company had decided to roll their own solution on top of VMs
  - At the time, this was due to features required that were not yet available on AKS
- All infrastructure was ran in one Azure subscription
- In this Azure subscription, a lot of high privileged access was available for the infrastructure team

In order to scale the environment in the future, and make things more secure, we decided to make some architectural changes. The following constraints were taken into account:

- We had a pretty small team with a broad scope of responsibilities
- An "Azure First" strategy
- As in every company: being VERY cost effective

## Migrate to Azure Kubernetes Service

## Introduce a formal naming convention

## Move to a hub-spoke topology

### Architectural overview

### Use Infrastructure as Code

#### Terraform and Terragrunt

#### Continuous Delivery

## Make this scale for multiple SAAS instances

## Improvements
