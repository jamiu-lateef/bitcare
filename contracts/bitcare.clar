;; Title: BitCare - Transparent Donation Management System
;;
;; Summary:
;; A Bitcoin-native charitable donation platform leveraging Stacks Layer 2
;; for transparent fund management, milestone tracking, and automated
;; compliance reporting.
;;
;; Description:
;; BitCare revolutionizes charitable giving by providing a trustless,
;; transparent donation ecosystem built on Bitcoin's security through
;; Stacks. The platform enables seamless donor contributions, real-time
;; fund tracking, milestone-based disbursements, and comprehensive
;; utilization reporting. With role-based access control and immutable
;; transaction records, BitCare ensures every satoshi donated reaches
;; its intended purpose while maintaining full transparency and
;; accountability in the charitable sector.
;;
;; Features:
;; - Multi-role access control (Admin, Moderator, Beneficiary)
;; - Real-time donation tracking and fund management
;; - Milestone-based fund utilization with approval workflows
;; - Immutable donation and utilization history
;; - Bitcoin-native transactions through Stacks Layer 2

;; CONTRACT OWNERSHIP & INITIALIZATION

(define-data-var contract-owner principal tx-sender)

;; ERROR CONSTANTS

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-ALREADY-REGISTERED (err u101))
(define-constant ERR-NOT-FOUND (err u102))
(define-constant ERR-INSUFFICIENT-FUNDS (err u103))
(define-constant ERR-BENEFICIARY-NOT-FOUND (err u104))
(define-constant ERR-UTILIZATION-NOT-FOUND (err u105))
(define-constant ERR-INVALID-INPUT (err u106))

;; ROLE DEFINITIONS

(define-constant ROLE-ADMIN u1)
(define-constant ROLE-MODERATOR u2)
(define-constant ROLE-BENEFICIARY u3)

;; DATA STRUCTURES

;; User roles mapping
(define-map roles
  { user: principal }
  { role: uint }
)

;; Beneficiary registry with fund tracking
(define-map beneficiaries
  { id: uint }
  {
    name: (string-utf8 50),
    description: (string-utf8 255),
    target-amount: uint,
    received-amount: uint,
    status: (string-ascii 20),
  }
)

;; Donation transaction records
(define-map donations
  { id: uint }
  {
    donor: principal,
    beneficiary-id: uint,
    amount: uint,
    timestamp: uint,
  }
)

;; Fund utilization tracking with milestones
(define-map utilization
  { id: uint }
  {
    beneficiary-id: uint,
    milestone: uint,
    description: (string-utf8 255),
    amount: uint,
    status: (string-ascii 20),
  }
)

;; GLOBAL COUNTERS

(define-data-var beneficiary-count uint u0)
(define-data-var donation-count uint u0)
(define-data-var utilization-count uint u0)

;; HELPER FUNCTIONS

;; Check if user has required authorization level
(define-private (is-authorized
    (user principal)
    (required-role uint)
  )
  (let ((role-data (default-to { role: u0 } (map-get? roles { user: user }))))
    (>= (get role role-data) required-role)
  )
)