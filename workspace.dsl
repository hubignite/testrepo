workspace "Claim Document Storage" "Single Region System Context with Roles" {

    model {
        
        user = person "User" "Policy Holder and/or Claimant. Submits and Views Claim Documents." { 
            tags "Person", "External", "Roles:PolicyHolder", "Roles:Claimant"
        }

        claimAdmin = person "Claim Admin" "Manages Claim Documents." {
            tags "Person", "Internal", "Roles:ClaimAdmin"
        }
        
        claimDocumentStore = softwareSystem "Claim Document Storage" {
            userWebApp = container "User Web Application" {
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
                claimDocRepo = component "Claim Document Repository" {
                    tags "Application"
                }
            }
            adminWebApp = container "Admin Web Application" {
                claimAdminDocController  = component "Admin Documents Controller" {
                    tags "REST API"
                    properties {
                        "Class" "DocumentsController"
                        "FilePath" "/DocumentsController.cs"
                    }
                }
                claimAdminDocUseCases = component "Claim Admin Document UseCases" {
                    tags "Application"
                }
                claimAdminDocRepo = component "Claim Admin Document Repository" {
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
            user -> userWebApp "Submit and Update Documents"
            claimAdmin -> adminWebApp "Manage Claim Documents"
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

        user -> userWebApp "List Claims" #?
        user -> userWebApp "Submit Claim Documents"
        user -> userWebApp "View Claim Document"
        user -> userWebApp "List Claim Documents"
        user -> userWebApp "Delete Claim Document"

        claimAdmin -> adminWebApp "List Users" #??
        claimAdmin -> adminWebApp "List User Claims" #??
        claimAdmin -> adminWebApp "Submit User Claim Documents"
        claimAdmin -> adminWebApp "View User Claim Document"
        claimAdmin -> adminWebApp "List User Claim Documents"
        claimAdmin -> adminWebApp "Delete User Claim Document"

        userWebApp -> db "Store Claim Document DB"
        userWebApp -> blob "Store Claim Blob Objects"

        adminWebApp -> db "Store Claim Document DB"
        adminWebApp -> blob "Store Claim Blob Objects"

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

        component userWebApp {
            include claimDocController
            include claimDocUseCases
            include claimDocRepo

            include db
            include blob

            autolayout lr
        }

        component adminWebApp {
            include claimAdminDocController
            include claimAdminDocUseCases
            include claimAdminDocRepo

            include db
            include blob

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
