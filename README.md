# The Saguaros CyberHub Project

The official repo of the UA Cyber Saguaros CyberHub project.

## Project Description

The Saguaros CyberHub is the official cybersecurity lab, cyber warfare range, and eLearning platform of the Cyber Saguaros, the University of Arizona's largest cybersecurity club. The CyberHub's purpose is split into a few main goals that guide our effort throughout this project:

1. Provide club members with the opportunity to supplement their undergraduate and graduate-level coursework with hands-on offensive and defensive security training.
2. Create a training model & environment for club Capture the Flag (CTF) teams.
3. Open a virtual learning and compute environment for student, researcher, and faculty projects. 
4. Stay free for club members.

## Project Ethos

Our goal is to follow this set of ethos set by the team:

1. **Open Source First**: Prioritize free, open-source software to ensure accessibility and transparency. All core components are built on community-supported technologies.
2. **Infrastructure as Code**: Maintain complete portability through IAC practices, automated deployment scripts, and containerization. The entire environment can be reproduced on any compatible hardware platform.
3. **Student Accessibility**: Keep deployments free for all students while ensuring enterprise-grade security and performance standards.
4. **Continuous Learning**: Provide hands-on experience with real-world tools and scenarios that mirror professional cybersecurity environments.
5. **Community Driven**: Foster collaboration between students, faculty, and industry professionals to create a comprehensive learning ecosystem.
6. **Security by Design**: Implement defense-in-depth strategies and zero-trust principles throughout the infrastructure to create a secure learning environment.

## Project Modules

Here are the main modules that will make up the CyberHub:

1. **CyberCore** - Central management system handling authentication, automation, and orchestration across all modules.
2. **The Hub** - The website/landing page where users authorize and get access to the other sections of the CyberHub.
3. **CyberLabs** - Virtualization environment for student and faculty projects.
4. **The Crucible** - A fully featured, CTF-style cyber warfare range with vulnerable hosts, networking devices, and enterprise environments.
5. **Saguaros University** - Moodle eLearning platform (LMS) with courses and digital badges.
6. **The Library** - An organized, properly indexed repository of eBooks, PDF guides, research articles, and cybersecurity resources.
7. **Saguaros Wiki** - A wiki with vulnerable machine walkthroughs, red/blue team skill playbooks, cheat sheets, and the CyberHub project documentation.
8. **The Archive** - A deep archive of malware samples, projects, scrapped data samples, etc.
9. **The Forge** - An isolated environment where users can deploy, develop, and reverse engineer malicious software for educational purposes.
10. **CyberProbe** - An automated fuzzing and vulnerability discovery environment that generates malformed inputs to test application security and identify potential weaknesses.

## Live Preview

🚧 In progress! Demo environments will be hosted internally during alpha testing. Public preview pending.

## Project Diagram

![alt text](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberHub-Architecture-v1.0.png?raw=true)

# CyberHub Project Roadmap (Updated – 2026)

This roadmap reflects current architecture decisions, recent development activity, and the evolving role of the **CyberCore** as the system control plane. Obsolete items have been removed or consolidated, and missing but critical work has been added.

## Stage 0 — Foundation & Control Plane (Mostly Complete)

**Goal:** Stable, automatable core infrastructure
**Status:** Active (~90% complete)

- [x] Physical network deployment
- [x] Compute & storage hardware deployment (Proxmox + Ceph)
- [x] Identity & authentication backbone integration
  - Keycloak (OIDC/SAML)
  - FreeIPA / AD integration
  - SSSD on Linux guests
- [x] Proxmox SDN baseline (zones, VNets, VXLAN ranges)  
- [x] Base VM & container templates
  - Linux base templates
  - Windows Server base templates
- [x] CyberCore initial deployment
- [x] PostgreSQL backend schema (users, modules, allocations, lanes)
- [x] Automation orchestration layer (n8n as control fabric)
- [x] Proxmox API + Ansible integration groundwork
- [ ] Nested virtualization templates finalized
- [ ] Secrets & credentials strategy
  - Vault (or justified alternative)
  - Service auth and key rotation model
- [ ] Centralized logging baseline
  - Proxmox, VM, container logs
  - SIEM scope definition (Wazuh or alternative)

## Stage 1 — CyberCore Maturation

**Goal:** Establish CyberCore as the authoritative control plane  
**Status:** Active

- [x] CyberCore service separation & module awareness  
- [x] SDN + VXLAN dynamic lane workflows  
- [x] Database-driven orchestration model  
- [x] Context-based isolation (users, teams, lanes)  
- [ ] Module registration & capability discovery
- [ ] Resource lifecycle tracking
  - VM lifetime
  - Lane TTL
  - Persistent vs non-persistent state
- [ ] RBAC enforcement via Keycloak roles
- [ ] Admin observability dashboard (initial)

## Stage 2 — Crucible (CTF / Cyber Range)

**Goal:** Fully isolated, repeatable cyber warfare range  
**Status:** Active

- [ ] Crucible authentication via CyberCore  
- [ ] Lane orchestration (solo, team, KOTH)  
- [ ] Vulnerable environment deployment  
  - GOAD
  - Linux vulnerability chains
  - ICS/OT scenarios  
- [ ] Flag validation & scoring backend  
- [ ] Lane reset / rebuild automation  
- [ ] Operator visibility & abuse controls  
- [ ] Documentation & walkthrough authoring  
- [ ] Internal proof-of-concept CTF event

## Stage 3 — CyberLabs

**Goal:** Student-facing lab provisioning at scale  
**Status:** Planned

- [ ] CyberLabs authentication via CyberCore  
- [ ] Student-requested lab provisioning workflow  
- [ ] Persistent vs non-persistent lab logic  
- [ ] OS and tooling access models (RDP, SSH, browser-based)  
- [ ] Instructor / admin controls  
- [ ] Documentation
  - Student guides
  - Instructor guides
  - Operator docs
- [ ] Proof-of-concept demonstration
- [ ] Offline / constrained network mode testing


## Stage 4 — Alpha Deployment

**Goal:** Controlled real-world usage
**Status:** Planned

- [ ] CyberLabs + Crucible integration testing
- [ ] Security review (auth boundaries, isolation)
- [ ] Performance & scaling tests (10–50+ concurrent users)
- [ ] Vulnerable content expansion
- [ ] Logging, alerting, and failure handling
- [ ] Documentation freeze (alpha)
- [ ] Private alpha launch for UA Cyber Saguaros

## Stage 5 — Beta & External Readiness

**Goal:** Stability, UX, and portability
**Status:** Future

- [ ] Post-alpha bug fixes and stabilization
- [ ] Performance optimization
- [ ] UI / UX improvements (admin and student)
- [ ] Security and compliance refinement
- [ ] Expanded testing (faculty, partners)
- [ ] Public-facing documentation
- [ ] Beta launch with controlled external access

## Stage 6 — Release & Expansion

**Goal:** Sustainable platform and academic impact  
**Status:** Long-term

- [ ] Versioned public release
- [ ] Live demo / preview deployment
- [ ] Curriculum alignment across courses
- [ ] Modular deployment profiles
  - Full CyberHub
  - Modular mobile deployments
  - Range-only installs
- [ ] Ongoing improvements

## Network Traffic Diagram

![alt text](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberHub%20Traffick%20v1.2.png?raw=true)
*Infrastructure subject to change*

## Network Architecture

![Saguaros CyberLab Network](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberLabs-Network-v1.0.png?raw=true)

## Virtualization Infrastructure

![CyberHub Virtualization](https://github.com/echumley/Saguaros-CyberHub/blob/main/resources/images/CyberHub-Virtualization-v1.0.png?raw=true)

## Infrastructure & Automation

The CyberHub infrastructure is managed through Infrastructure as Code (IaC) principles:

- **Ansible Automation**: Comprehensive playbooks for service deployment and configuration
- **Docker Orchestration**: Containerized services using Docker Compose for portability
- **Proxmox Templates**: Automated VM provisioning for various Linux distributions
- **Internal Services**: Monitoring, logging, SIEM/SOAR, and backup solutions
- **Secrets Management**: HashiCorp Vault integration for secure credential storage

## CyberHub Modules

### CyberCore

CyberCore serves as the central nervous system of the CyberHub, providing:

- **Authentication Services**: Integration with Keycloak, FreeIPA, LDAP, and Samba for unified authentication
- **Automation Framework**: Ansible playbooks and inventory management for infrastructure deployment
- **Front-end Management**: The Hub interface for user access and module navigation
- **Service Orchestration**: Docker Compose configurations for containerized service deployment
- **API Integration**: RESTful APIs for inter-module communication

### CyberLabs

The CyberLabs will be a cloud-like virtualization environment for use by students and faculty in order to ensure computation-heavy projects are supported without the need to deal with the  "red tape" often involved in large projects. This environment will be available to all university students and faculty upon request for a set amount of time and resources necessary to complete their proposed project. These environments will be based on a per-project Debian GNOME desktop environment utilizing KVM/QEMU and Cockpit facilitate virtualization. These desktop environments and their traffic will be closely monitored to ensure users are following the Terms of Service agreed upon following their request approval.

### The Crucible

#### Range Types

Below is a general list of planned range types or "lanes." These are isolated networks in which one player or team will connect to access their target machines(s).

1. Single player vs. single target
2. Single player vs. multiple targets/network
3. Multiple players vs. single target (King of the Hill)
4. Team vs. single target
5. Team vs. multiple targets/network
6. Team vs. team (Attack-Defend)
7. Live SOC incident response

#### Extra Services

These services will be openly available for use by registered players (internally or externally) to assist in CTF competitions.

1. Web-based RDP Kali machine (for those who can't run it locally)
2. SIEM/SOAR stack (inspired by WRCCDC)
3. Hashcat server (GPU server running Hashtopolis)

---

### Saguaros University

#### Learning Courses

1. CTF fundamentals
2. Networking fundamentals
3. IT concept fundamentals
4. Red team fundamentals
5. Blue team fundamentals
6. King of the hill fundamentals
7. Tool spotlights
8. Malware development