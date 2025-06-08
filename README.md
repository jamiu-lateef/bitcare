# BitCare - Transparent Donation Management System

**A Bitcoin-native charitable donation platform leveraging Stacks Layer 2 for transparent fund management, milestone tracking, and automated compliance reporting.**

![Stacks](https://img.shields.io/badge/Stacks-Layer%202-orange)
![Bitcoin](https://img.shields.io/badge/Bitcoin-Native-f7931a)
![Clarity](https://img.shields.io/badge/Language-Clarity-blue)

---

## 🌟 Overview

BitCare revolutionizes charitable giving by providing a trustless, transparent donation ecosystem built on Bitcoin's security through Stacks Layer 2. The platform enables seamless donor contributions, real-time fund tracking, milestone-based disbursements, and comprehensive utilization reporting.

### Key Features

- **🔐 Multi-Role Access Control** - Admin, Moderator, and Beneficiary hierarchies
- **📊 Real-Time Fund Tracking** - Transparent donation and utilization monitoring
- **🎯 Milestone-Based Disbursement** - Controlled fund release with approval workflows
- **📜 Immutable Transaction History** - Complete audit trail on Bitcoin blockchain
- **⚡ Bitcoin-Native Security** - Leveraging Stacks Layer 2 for scalability

---

## 🏗️ System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        BitCare Platform                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
│  │   Donors    │   │ Moderators  │   │ Beneficiaries│          │
│  │             │   │             │   │             │          │
│  │ • Donate    │   │ • Register  │   │ • Receive   │          │
│  │ • Track     │   │   Benefic.  │   │   Funds     │          │
│  │   Impact    │   │ • Verify    │   │ • Report    │          │
│  └─────────────┘   └─────────────┘   └─────────────┘          │
│         │                  │                  │               │
│         └──────────────────┼──────────────────┘               │
│                            │                                  │
│  ┌─────────────────────────┼─────────────────────────────────┐ │
│  │            Smart Contract Layer (Clarity)               │ │
│  │                         │                               │ │
│  │  ┌──────────────┐  ┌────┴──────┐  ┌──────────────┐     │ │
│  │  │     Role     │  │   Fund    │  │ Utilization  │     │ │
│  │  │ Management   │  │ Tracking  │  │  Tracking    │     │ │
│  │  └──────────────┘  └───────────┘  └──────────────┘     │ │
│  └─────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │                  Stacks Layer 2                             │ │
│  │  • Transaction Processing  • State Management              │ │
│  │  • Smart Contract Execution • Event Logging               │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │                   Bitcoin Blockchain                        │ │
│  │  • Final Settlement  • Security Anchor  • Immutability     │ │
│  └─────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📋 Contract Architecture

### Core Components

#### 1. **Role Management System**

```clarity
ROLE-ADMIN (u1)        // Full system control
ROLE-MODERATOR (u2)    // Beneficiary management
ROLE-BENEFICIARY (u3)  // Fund recipients
```

#### 2. **Data Structures**

**Beneficiaries Registry**

```clarity
{
  id: uint,
  name: string-utf8,
  description: string-utf8,
  target-amount: uint,
  received-amount: uint,
  status: string-ascii
}
```

**Donation Records**

```clarity
{
  id: uint,
  donor: principal,
  beneficiary-id: uint,
  amount: uint,
  timestamp: uint
}
```

**Utilization Tracking**

```clarity
{
  id: uint,
  beneficiary-id: uint,
  milestone: uint,
  description: string-utf8,
  amount: uint,
  status: string-ascii
}
```

#### 3. **Access Control Matrix**

| Function | Public | Admin | Moderator | Beneficiary |
|----------|--------|-------|-----------|-------------|
| Donate | ✅ | ✅ | ✅ | ✅ |
| Register Beneficiary | ❌ | ✅ | ✅ | ❌ |
| Add Utilization | ❌ | ✅ | ❌ | ❌ |
| Approve Utilization | ❌ | ✅ | ❌ | ❌ |
| Manage Roles | ❌ | ✅ | ❌ | ❌ |

---

## 🔄 Data Flow

### Donation Process

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Donor     │    │   Smart     │    │ Beneficiary │    │   Bitcoin   │
│  Initiates  │───▶│  Contract   │───▶│   Account   │───▶│  Blockchain │
│  Donation   │    │  Validates  │    │  Receives   │    │   Records   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
      │                     │                     │              │
      │                     │                     │              │
      ▼                     ▼                     ▼              ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Amount    │    │   Update    │    │   Trigger   │    │ Immutable   │
│ Validation  │    │ Beneficiary │    │   Event     │    │  Audit      │
│  & Transfer │    │  Balance    │    │   Logging   │    │   Trail     │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

### Fund Utilization Workflow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Admin    │    │   Smart     │    │  Milestone  │
│  Proposes   │───▶│  Contract   │───▶│   Tracking  │
│ Utilization │    │  Validates  │    │   Update    │
└─────────────┘    └─────────────┘    └─────────────┘
      │                     │                     │
      │                     │                     │
      ▼                     ▼                     ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Admin     │    │   Balance   │    │ Utilization │
│  Approves   │    │    Check    │    │   Record    │
│  Milestone  │    │ & Validation│    │   Created   │
└─────────────┘    └─────────────┘    └─────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

- Stacks CLI installed
- Clarinet development environment
- Node.js 16+ (for frontend integration)

### Deployment

1. **Clone the repository**

```bash
git clone https://github.com/jamiu-lateef/bitcare.git
cd bitcare
```

2. **Install dependencies**

```bash
npm install
clarinet install
```

3. **Deploy to testnet**

```bash
clarinet deploy --testnet
```

4. **Verify deployment**

```bash
clarinet call-read-only .bitcare get-donation-count
```

### Usage Examples

#### Register a Beneficiary

```bash
clarinet call .bitcare register-beneficiary \
  "Emergency Relief Fund" \
  "Supporting families affected by natural disasters" \
  u1000000
```

#### Make a Donation

```bash
clarinet call .bitcare donate u1 u50000
```

#### Track Utilization

```bash
clarinet call .bitcare add-utilization \
  u1 \
  "Food supplies for 100 families" \
  u25000
```

---

## 📊 Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| 100 | ERR-NOT-AUTHORIZED | Insufficient permissions |
| 101 | ERR-ALREADY-REGISTERED | Entity already exists |
| 102 | ERR-NOT-FOUND | Resource not found |
| 103 | ERR-INSUFFICIENT-FUNDS | Insufficient balance |
| 104 | ERR-BENEFICIARY-NOT-FOUND | Invalid beneficiary ID |
| 105 | ERR-UTILIZATION-NOT-FOUND | Invalid utilization record |
| 106 | ERR-INVALID-INPUT | Invalid input parameters |

---

## 🔧 API Reference

### Public Functions

#### `donate(beneficiary-id: uint, amount: uint)`

Process a donation to a registered beneficiary.

#### `register-beneficiary(name: string-utf8, description: string-utf8, target-amount: uint)`

Register a new beneficiary (requires moderator role).

#### `add-utilization(beneficiary-id: uint, description: string-utf8, amount: uint)`

Add fund utilization record (requires admin role).

### Read-Only Functions

#### `get-beneficiary(id: uint)`

Retrieve beneficiary details by ID.

#### `get-donation-by-id(donation-id: uint)`

Retrieve donation details by ID.

#### `get-utilization-by-id(utilization-id: uint)`

Retrieve utilization details by ID.

---

## 🛡️ Security Considerations

- **Role-based Access Control**: Hierarchical permissions prevent unauthorized actions
- **Input Validation**: All user inputs are validated before processing
- **Overflow Protection**: Safe arithmetic operations prevent integer overflow
- **Immutable Records**: All transactions create permanent audit trails
- **Bitcoin Security**: Final settlement on Bitcoin blockchain

---

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md).

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
