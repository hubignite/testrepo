workspace "Claim Document Storage" "Single Region System Context with Roles" {

    model {
        
        user = person "User" "Policy Holder and/or Claimant. Submits and Views Claim Documents." { 
            tags "Person", "External", "Roles:PolicyHolder", "Roles:Claimant"
        }

        claimAdmin = person "Claim Admin" "Manages Claim Documents." {
            tags "Person", "Internal", "Roles:ClaimAdmin"
        }
        
        claimDocumentStore = softwareSystem "Claim Document Storage" {
            webapp = container "Web Application" {
                claimDocController  = component "Claim Documents Controller" {
                    tags "REST API"
                    properties {
                        "Class" "DocumentsController"
                        "FilePath" "/DocumentsController.cs"
                    }
                }
                claimDocUseCases = component "Claim Document UseCases" {
                    tags "Application"
                }
                claimDocServices = component "Claim Document Services" {
                    tags "Application"
                }
                claimDocRepo = component "Claim Document Repository" {
                    tags "Application"
                }
            }
            blob = container "Blob Storage (MinIO)" {
                tags "PII", "PHI"
                blobController  = component "Blob S3 API Controller" {
                    tags "REST API"
                }
            }
            db = container "PostgreSQL DB" {
                tags "PII"
            }
            user -> webapp "Submit and Update Documents"
            claimAdmin -> webapp "Manage Claim Documents"
        }

        adIDP = softwareSystem "AD/OIDC Identity Provider" {
            tags "PII"
            idp = container "Identity Provider"
            claimAdmin -> idp "Authenticate, get token"
        }
        
        extIDP1  = softwareSystem "Google Identity Provider" {
            tags "PII"
            extIdp = container "Identity Provider"
            user -> extIdp "Authenticate, get token"
        }

        user -> webapp "List Claims" #?
        user -> webapp "Submit Claim Documents"
        user -> webapp "View Claim Document"
        user -> webapp "List Claim Documents"
        user -> webapp "Delete Claim Document"

        claimAdmin -> webapp "List User Claims" #??
        claimAdmin -> webapp "Submit User Claim Documents"
        claimAdmin -> webapp "View User Claim Document"
        claimAdmin -> webapp "List User Claim Documents"
        claimAdmin -> webapp "Delete User Claim Document"

        webapp -> db "Store Claim Document DB"
        webapp -> blob "Store Claim Blob Objects"
    }

    views {
        systemContext claimDocumentStore {
            include claimDocumentStore
            include claimAdmin
            include user

            autolayout lr
        }

        container claimDocumentStore {
            include *
            autolayout lr
        }

        component webapp {
            include claimDocController
            include claimDocUseCases
            include claimDocServices
            include claimDocRepo

            autolayout lr
        }

        component blob {
            include blobController

            autolayout lr
        }

        component db {
            include *

            autolayout lr
        }


        theme default
    }
}
