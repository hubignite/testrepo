## Claim Document Storage C4 PoC

### System Context
```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Claim Document Storage - System Context"]
    style diagram fill:#ffffff,stroke:#ffffff

    1["<div style='font-weight: bold'>User</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Policy Holder and/or<br />Claimant. Submits and Views<br />Claim Documents.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    2["<div style='font-weight: bold'>Claim Admin</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Manages Claim Documents.</div>"]
    style 2 fill:#08427b,stroke:#052e56,color:#ffffff
    3("<div style='font-weight: bold'>Claim Document Storage</div><div style='font-size: 70%; margin-top: 0px'>[Software System]</div>")
    style 3 fill:#1168bd,stroke:#0b4884,color:#ffffff

    1-. "<div>Submit and Update Documents</div><div style='font-size: 70%'></div>" .->3
    2-. "<div>Manage Claim Documents</div><div style='font-size: 70%'></div>" .->3
  end
```

### Containers
```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Claim Document Storage - Containers"]
    style diagram fill:#ffffff,stroke:#ffffff

    1["<div style='font-weight: bold'>User</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Policy Holder and/or<br />Claimant. Submits and Views<br />Claim Documents.</div>"]
    style 1 fill:#08427b,stroke:#052e56,color:#ffffff
    2["<div style='font-weight: bold'>Claim Admin</div><div style='font-size: 70%; margin-top: 0px'>[Person]</div><div style='font-size: 80%; margin-top:10px'>Manages Claim Documents.</div>"]
    style 2 fill:#08427b,stroke:#052e56,color:#ffffff

    subgraph 3 ["Claim Document Storage"]
      style 3 fill:#ffffff,stroke:#0b4884,color:#0b4884

      11("<div style='font-weight: bold'>PostgreSQL DB</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 11 fill:#438dd5,stroke:#2e6295,color:#ffffff
      4("<div style='font-weight: bold'>Web Application</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 4 fill:#438dd5,stroke:#2e6295,color:#ffffff
      9("<div style='font-weight: bold'>Blob Storage (MinIO)</div><div style='font-size: 70%; margin-top: 0px'>[Container]</div>")
      style 9 fill:#438dd5,stroke:#2e6295,color:#ffffff
    end

    1-. "<div>Submit and Update Documents</div><div style='font-size: 70%'></div>" .->4
    2-. "<div>Manage Claim Documents</div><div style='font-size: 70%'></div>" .->4
    1-. "<div>List Claims</div><div style='font-size: 70%'>[#?]</div>" .->4
    1-. "<div>Submit Claim Documents</div><div style='font-size: 70%'></div>" .->4
    1-. "<div>View Claim Document</div><div style='font-size: 70%'></div>" .->4
    1-. "<div>List Claim Documents</div><div style='font-size: 70%'></div>" .->4
    1-. "<div>Delete Claim Document</div><div style='font-size: 70%'></div>" .->4
    2-. "<div>List User Claims</div><div style='font-size: 70%'>[#??]</div>" .->4
    2-. "<div>Submit User Claim Documents</div><div style='font-size: 70%'></div>" .->4
    2-. "<div>View User Claim Document</div><div style='font-size: 70%'></div>" .->4
    2-. "<div>List User Claim Documents</div><div style='font-size: 70%'></div>" .->4
    2-. "<div>Delete User Claim Document</div><div style='font-size: 70%'></div>" .->4
    4-. "<div>Store Claim Document DB</div><div style='font-size: 70%'></div>" .->11
    4-. "<div>Store Claim Blob Objects</div><div style='font-size: 70%'></div>" .->9
  end
```

### Components
```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Claim Document Storage - Web Application - Components"]
    style diagram fill:#ffffff,stroke:#ffffff

    subgraph 4 ["Web Application"]
      style 4 fill:#ffffff,stroke:#2e6295,color:#2e6295

      5("<div style='font-weight: bold'>Claim Documents Controller</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 5 fill:#85bbf0,stroke:#5d82a8,color:#000000
      6("<div style='font-weight: bold'>Claim Document UseCases</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 6 fill:#85bbf0,stroke:#5d82a8,color:#000000
      7("<div style='font-weight: bold'>Claim Document Services</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 7 fill:#85bbf0,stroke:#5d82a8,color:#000000
      8("<div style='font-weight: bold'>Claim Document Repository</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 8 fill:#85bbf0,stroke:#5d82a8,color:#000000
    end

  end
```
```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Claim Document Storage - Blob Storage (MinIO) - Components"]
    style diagram fill:#ffffff,stroke:#ffffff

    subgraph 9 ["Blob Storage (MinIO)"]
      style 9 fill:#ffffff,stroke:#2e6295,color:#2e6295

      10("<div style='font-weight: bold'>Blob S3 API Controller</div><div style='font-size: 70%; margin-top: 0px'>[Component]</div>")
      style 10 fill:#85bbf0,stroke:#5d82a8,color:#000000
    end

  end  
```
```mermaid
graph LR
  linkStyle default fill:#ffffff

  subgraph diagram ["Claim Document Storage - PostgreSQL DB - Components"]
    style diagram fill:#ffffff,stroke:#ffffff

  end
```

### Class/Code Drafts

#### DocumentController Class PoC
```mermaid
classDiagram
    class DocumentsController {
        +getDocument(id: string): Response
        +uploadDocument(file: Blob, metadata: Object): Response
        +deleteDocument(id: string): Response
        +listDocuments(): Response
    }

    class DocumentUploadUseCase {
        +uploadDocument(file: Blob, metadata: Object): Document
    }

    class DocumentGetUseCase {
        +getDocument(id: string): Document
    }

    class DocumentListUseCase {
        +listDocuments(): List<Document>
    }

    class DocumentDeleteUseCase {
        +deleteDocument(id: string): void
    }

    class DocumentRepository {
        +save(metadata: Object): Document
        +retrieve(id: string): Document
        +delete(id: string): void
    }

    class BlobStorage {
        +save(file: Blob): string
        +retrieve(id: string): Blob
        +delete(id: string): void
    }

    DocumentsController --> DocumentUploadUseCase : delegates
    DocumentsController --> DocumentListUseCase : delegates
    DocumentsController --> DocumentGetUseCase : delegates
    DocumentsController --> DocumentDeleteUseCase : delegates

    DocumentUploadUseCase --> DocumentRepository : stores document
    DocumentUploadUseCase --> BlobStorage : stores blob

    DocumentListUseCase --> DocumentRepository : lists documents

    DocumentGetUseCase --> DocumentRepository : retrieves document
    DocumentGetUseCase --> BlobStorage : retrieves blob

    DocumentDeleteUseCase --> DocumentRepository : deletes document
    DocumentDeleteUseCase --> BlobStorage : deletes blob
```



#### File Upload Sequence PoC
```mermaid
sequenceDiagram
    participant User
    participant Document UI (React)
    participant Document Storage API (.NET)
    participant Document DB

    User->>Document UI (React): Open upload page
    Document UI (React)->>User: Display File upload form
    User->>Document UI (React): Select File, Document Type and Submit document
    Document UI (React)->>Document Storage API (.NET): Send document and file metadata
    Document Storage API (.NET)->>Document Storage API (.NET): Validate file (type, size, etc.)
    Document Storage API (.NET)->>Document DB: Store file in the Blob Storage
    Document DB->>Document Storage API (.NET): Return DB success/failure response
    Document Storage API (.NET)->>Document UI (React): Return API success/failure response
    Document UI (React)->>User: Show user-friendly upload result
```

#### Claim State PoC
```mermaid
---
title: Claim States
---
stateDiagram-v2
    [*] --> New
    New --> InProgress: assignAgent [AgentAssigned]
    InProgress --> UnderReview: submitAllDocs [DocsSubmitted]

    UnderReview --> Approved: approve [ValidForApprove]
    UnderReview --> Rejected: reject

    New --> Cancelled: cancel [ValidCancelTiming or AdminOverride]
    InProgress --> Cancelled: cancel [ValidCancelTiming or AdminOverride]
    UnderReview --> Cancelled: cancel [ValidCancelTiming or AdminOverride]
```
