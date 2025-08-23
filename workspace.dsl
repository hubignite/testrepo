workspace "Claim Document Storage" "Single Region System Context with Roles" {
    !const PLANTUML_ENABLED true

    model {
        
        user = person "User" "Policy Holder and/or Claimant. Submits and Views Claim Documents." { 
            tags "Person", "External", "Roles:PolicyHolder", "Roles:Claimant"
            
        }

        claimAdmin = person "Claim Admin" "Manages Claim Documents." {
            tags "Person", "Internal", "Roles:ClaimAdmin"
        }
        
        claimDocumentStore = softwareSystem "Claim Document Storage" {
            webapp = container "Web Application"
            user -> webapp "Submit and Update Documents"
            claimAdmin -> webapp "Manage Claim Documents"
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

        theme default
    }
}
