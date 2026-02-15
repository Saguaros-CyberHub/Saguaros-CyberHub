# The Saguaros CyberHub Project

The official project overview and coordination repository for the UA Cyber Saguaros CyberHub.

This repository is the primary source of truth for CyberHub architecture, diagrams, standards, governance, and the cross-module roadmap. Each CyberHub module is implemented in its own repository under the same GitHub organization.

## Project Description

The Saguaros CyberHub is the official cybersecurity lab, cyber warfare range, and eLearning platform of the Cyber Saguaros, the University of Arizona's largest cybersecurity club. The CyberHub's purpose is split into a few main goals that guide our effort throughout this project:

1. Provide club members with the opportunity to supplement their undergraduate and graduate-level coursework with hands-on offensive and defensive security training.
2. Create a training model and environment for club Capture the Flag (CTF) teams.
3. Open a virtual learning and computing environment for student, researcher, and faculty projects.
4. Stay free for club members.

## Project Ethos

Our goal is to follow this set of ethos set by the team:

1. **Open Source First**: Prioritize free, open-source software to ensure accessibility and transparency. All core components are built on community-supported technologies.
2. **Infrastructure as Code**: Maintain complete portability through IaC practices, automated deployment scripts, and containerization. The entire environment can be reproduced on any compatible hardware platform.
3. **Student Accessibility**: Keep deployments free for all students while ensuring enterprise-grade security and performance standards.
4. **Continuous Learning**: Provide hands-on experience with real-world tools and scenarios that mirror professional cybersecurity environments.
5. **Community Driven**: Foster collaboration between students, faculty, and industry professionals to create a comprehensive learning ecosystem.
6. **Security by Design**: Implement defense-in-depth strategies and zero-trust principles throughout the infrastructure to create a secure learning environment.

## Repository Layout

CyberHub is organized as a single GitHub organization containing multiple repositories. This repository contains project-wide documentation and direction. Each module below has its own dedicated repository for its code, deployment artifacts, and module-specific documentation.

### Primary Project Repository

- **Saguaros-CyberHub**: Project overview, architecture diagrams, shared standards, governance, and the cross-module roadmap.

### Module Repositories

- **CyberCore**: Central management system handling authentication, automation, and orchestration across all modules.
- **The Hub**: The website and landing page where users authorize and get access to the other sections of the CyberHub.
- **CyberLabs**: Virtualization environment for student and faculty projects.
- **The Crucible**: A CTF-style cyber warfare range with isolated lanes, vulnerable hosts, and scoring workflows.
- **Saguaros University**: Moodle learning management system with courses and digital badges.
- **The Library**: Indexed repository of eBooks, PDF guides, research articles, and cybersecurity resources.
- **CyberWiki**: Wiki with walkthroughs, red and blue team skill playbooks, cheat sheets, and project documentation.
- **The Archive**: Deep archive of malware samples, projects, and research artifacts.
- **The Forge**: Isolated environment for developing and reverse engineering malicious software for education.
- **CyberProbe**: Automated fuzzing and vulnerability discovery environment for testing applications and identifying weaknesses.

## Live Preview

In progress. Demo environments will be hosted internally during alpha testing. Public preview pending.

## How to Install

In progress. An installation script will be provided to guide your through the setup of all required dependancies and modules. Will prompt you for cluster information, as well as administrator and database credentials, and generate the necessary keys.

## Project Diagram

![CyberHub Architecture](https://github.com/Saguaros-CyberHub/Saguaros-CyberHub/blob/97c90549d6e269e96fab546df7b03c37780c07c6/resources/images/CyberHub-Architecture-v1.1.png)

# CyberHub Project Roadmap (Updated – 2026)

This roadmap reflects current architecture decisions, recent development activity, and the evolving role of the **CyberCore** as the system control plane. Obsolete items have been removed or consolidated, and missing but critical work has been added.

## Stage 0 — Foundation and Control Plane (Mostly Complete)

**Goal:** Stable, automatable core infrastructure  
**Status:** Active (~90% complete)

- [x] Physical network deployment
- [x] Compute and storage hardware deployment (Proxmox and Ceph)
- [x] Proxmox SDN baseline (zones, VNets, VXLAN ranges)
- [x] Base VM and container templates
  - [x] Linux base templates
  - [x] Windows Server base templates
- [x] CyberCore initial deployment
- [x] PostgreSQL backend schema (users, modules, allocations, lanes)
- [x] Automation orchestration layer (n8n as control fabric)
- [x] Proxmox API and Ansible integration groundwork
- [ ] Nested virtualization templates finalized
- [ ] Secrets and credentials strategy
  - [ ] Vault or justified alternative
  - [ ] Service authentication and key rotation model
- [ ] Centralized logging baseline
  - [ ] Proxmox, VM, and container logs
  - [ ] SIEM scope definition (Wazuh or alternative)

## Stage 1 — CyberCore Maturation

**Goal:** Establish CyberCore as the authoritative control plane  
**Status:** Active

- [x] CyberCore service separation and module awareness
- [x] SDN and VXLAN dynamic lane workflows
- [x] Database-driven orchestration model
- [x] Context-based isolation (users, teams, lanes)
- [ ] Module registration and capability discovery
- [ ] Resource lifecycle tracking
  - [ ] VM lifetime
  - [ ] Lane TTL
  - [ ] Persistent vs non-persistent state
- [ ] RBAC enforcement via Keycloak roles
- [ ] Admin observability dashboard (initial)

## Stage 2 — Crucible (CTF and Cyber Range)

**Goal:** Fully isolated, repeatable cyber warfare range  
**Status:** Active

- [ ] Crucible authentication via CyberCore
- [ ] Lane orchestration (solo, team, KOTH)
- [ ] Vulnerable environment deployment
  - [ ] GOAD
  - [ ] Linux vulnerability chains
  - [ ] ICS and OT scenarios
- [ ] Flag validation and scoring backend
- [ ] Lane reset and rebuild automation
- [ ] Operator visibility and abuse controls
- [ ] Documentation and walkthrough authoring
- [ ] Internal proof-of-concept CTF event

## Stage 3 — CyberLabs

**Goal:** Student-facing lab provisioning at scale  
**Status:** Planned

- [ ] CyberLabs authentication via CyberCore
- [ ] Student-requested lab provisioning workflow
- [ ] Persistent vs non-persistent lab logic
- [ ] OS and tooling access models (RDP, SSH, browser-based)
- [ ] Instructor and admin controls
- [ ] Documentation
  - [ ] Student guides
  - [ ] Instructor guides
  - [ ] Operator docs
- [ ] Proof-of-concept demonstration
- [ ] Offline and constrained network mode testing

## Stage 4 — Alpha Deployment

**Goal:** Controlled real-world usage  
**Status:** Planned

- [ ] CyberLabs and Crucible integration testing
- [ ] Identity and authentication backbone integration
  - [ ] Keycloak (OIDC and SAML)
  - [ ] FreeIPA or AD integration
  - [ ] SSSD on Linux guests
- [ ] Security review (auth boundaries, isolation)
- [ ] Performance and scaling tests (10 to 50+ concurrent users)
- [ ] Vulnerable content expansion
- [ ] Logging, alerting, and failure handling
- [ ] Documentation freeze (alpha)
- [ ] Private alpha launch for UA Cyber Saguaros

## Stage 5 — Beta and External Readiness

**Goal:** Stability, UX, and portability  
**Status:** Future

- [ ] Post-alpha bug fixes and stabilization
- [ ] Performance optimization
- [ ] UI and UX improvements (admin and student)
- [ ] Security and compliance refinement
- [ ] Expanded testing (faculty, partners)
- [ ] Public-facing documentation
- [ ] Beta launch with controlled external access

## Stage 6 — Release and Expansion

**Goal:** Sustainable platform and academic impact  
**Status:** Long-term

- [ ] Versioned public release
- [ ] Live demo and preview deployment
- [ ] Curriculum alignment across courses
- [ ] Modular deployment profiles
  - [ ] Full CyberHub
  - [ ] Modular mobile deployments
  - [ ] Range-only installs
- [ ] Ongoing improvements

## Network Traffic Diagram

![CyberHub Network Traffic](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberHub%20Traffick%20v1.2.png?raw=true)  
*Infrastructure subject to change*

## Network Architecture

![Saguaros CyberLab Network](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberLabs-Network-v1.0.png?raw=true)

## Virtualization Infrastructure

![CyberHub Virtualization](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberHub-Virtualization-v1.0.png?raw=true)

## Proxmox SDN Design for Isolation & Scalability

![Proxmox SDN Design](https://github.com/Saguaros-CyberHub/Saguaros-CyberHub/blob/97c90549d6e269e96fab546df7b03c37780c07c6/resources/images/ProxmoxSDN-Fabric-v1.0.png)

## Infrastructure and Automation

The CyberHub infrastructure is managed through Infrastructure as Code principles:

- **Ansible Automation**: Playbooks for service deployment and configuration
- **Docker Orchestration**: Containerized services using Docker Compose for portability
- **Proxmox Templates**: Automated VM provisioning for various Linux distributions
- **Internal Services**: Monitoring, logging, SIEM and SOAR, and backup solutions
- **Secrets Management**: Vault or a justified alternative for secure credential storage

## Module Overview

This section provides a short summary of each module. For module deployment instructions, configuration, and module-specific documentation, refer to each module's repository.

### CyberCore

CyberCore serves as the central nervous system of the CyberHub, providing:

- Authentication integration with Keycloak, FreeIPA, LDAP, and Samba
- Automation framework for Ansible playbooks and inventory management
- Module coordination and orchestration workflows
- APIs for inter-module communication
- Database-backed state tracking for users, modules, allocations, and lanes

### CyberLabs

CyberLabs is the student and faculty lab provisioning environment. It provides time-bound project environments with defined resources and access models. It is designed for scalable provisioning, isolation, and operational monitoring aligned with CyberHub policies.

### The Crucible

The Crucible is the cyber range module focused on repeatable, isolated training environments that support solo play, teams, and competitive modes.

Planned range types include:

1. Single player vs single target
2. Single player vs multiple targets and networks
3. Multiple players vs single target (King of the Hill)
4. Team vs single target
5. Team vs multiple targets and networks
6. Team vs team (attack and defend)
7. Live SOC incident response

Planned shared services include:

1. Web-based RDP Kali machine for users who cannot run a local VM
2. SIEM and SOAR stack for defensive visibility and training
3. Hashcat server for password cracking workflows

### Saguaros University

Saguaros University is the learning module built on Moodle. It provides structured courses and digital badges aligned with CyberHub training paths.

### The Library

The Library provides an indexed, searchable repository of cybersecurity references, guides, research papers, and learning resources.

### CyberWiki

CyberWiki provides walkthroughs, playbooks, cheat sheets, and project documentation for CyberHub modules and range content.

### The Archive

The Archive provides long-term storage for malware samples, research artifacts, scraped datasets, and related materials. Access is expected to be restricted and policy-driven.

### The Forge

The Forge provides an isolated environment for malware development, reverse engineering, and high-risk experimentation for educational purposes.

### CyberProbe

CyberProbe provides automated fuzzing and vulnerability discovery workflows designed to generate malformed inputs, detect failures, and help identify security weaknesses.
