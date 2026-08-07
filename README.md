# fLANexec

**fLANexec** is a multi-platform security and networking tool built with Flutter. It combines the powerful discovery capabilities of **Nmap** with the post-exploitation and enumeration features inspired by **NetExec**.

Designed for speed and visibility, fLANexec provides a reactive interface for network exploration across iOS, Android, and macOS.

## 🚀 Key Features

### 📡 Network Discovery
- **Parallel Scanning**: Fast ICMP and TCP-based host discovery using custom concurrency pools.
- **Smart CIDR Expansion**: Support for subnets up to /16 with intelligent IP generation.
- **Hybrid Resolution**: Resolve hostnames via standard DNS and local mDNS discovery.
- **DC Badging**: Automatic identification and badging of Active Directory Domain Controllers.

### 🔍 Deep Service Detection
- **Nmap-Style Output**: Monospace dashboard showing service versions, products, and OS guesses.
- **Protocol-Aware Probing**: Specialized deep probes for SSH, HTTP/HTTPS, FTP, SMTP, DNS, and SMB.
- **Banner Grabbing**: Automated capture and parsing of software identification strings.
- **Scripting Insights**: Extraction of HTTP titles, SSH keys, and AD RootDSE attributes.

#