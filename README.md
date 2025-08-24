# System Design Assessment

## Common Notes

### PoC design notes
    1. Use GitHub test repo *testrepo*
    2. Use C4 diagramm to design architecture PoC top-bottom
    3. Use Structurizr Model-as-a-Code approach with VS Code (mistake?)
    4. Use Mermaid for combined C4 and other State/Class/etc diagrams
    5. Use CLEAN with emphasis on DDD core in the PoC, once it has reach ruleset
    6. Use minimal code prototyping
    7. Commit model and impolementation PoC-s into the test repo

#### Assessment 1 Assumptions
    1. Use Postgres or any other relational DB for structured part of data.
    2. Consider Blob storage engine like MinIO etc for files to get better throughput comparing to traditional SQL engines. 
       This would also allow to implement more optimal backup, scaling and legal-related options

#### Assessment 2 Assumptions
    1. Rules related to the Domain that should be implemented at Domain CLEAN layer
    2. Adjustable/Programmable rules should be stored at DB
    3. Domain-specific rules should be covered with unit tests
    4. Adjustable rules should be covered with unit tests and integration tests with mock DB



### Common Assumptions
    1. Single-region/location/authority - it is not mentioned. It might be the main assessment point, but once it's not mentioned, then extracted.
    2. No PII/PHI-related staff regarding physical security, infrastructure setup, DR requirements etc.
    3. No multi-region-specific GDPR and GDPR-like rulesets management
    4. No Retention/Legal Hold-related staff (in deep, like retention Jobs and schedules especially with interation with Disaster Recovery and/or Legal Hold procedures)
    5. External systems are excluded from System Context
    6. No CDN/DDoS/Load Balancing staff here
    7. No IaC sources here
    8. No DR/HA/RTO/RPO/Backup related investigations here
    9. No Avg/Max Throughput/Storage Capacity and Retention-related calculations here


## Initial Task List PoC
### Document Storage
        1. As a Claim Document User I see Claim Document Store main page
        2. As a Claim Document User I see empty Claims list at the main page
        3. As a Claim Document User I see Login button at the main page
        4. As a Claim Document User I see logged user profile Link at the main page
        5. As a Claim Document User I see Login form on Login button click
        6. As a Claim Document User I see logged user name Link on successful authentication
        7. As authenticated Claim Document User I see user Claim List on the main page
        8. As authenticated Claim Document User I see Claim Document List on Claim click
        9. As authenticated Claim Document User I see Claim Document on Document icon click
        10. As a Claim Document User I see Add document element
        11. As a Claim Document User I see Add document form on Add Documnent element click
        12. As a Claim Document User I see Document type radio list
        13. As a Claim Document User I see select file element on Document selection form
        14. As a Claim Document User I can drop files on Document selection form
        15. As a Claim Document User I see file quantity and size warning on Document selection form
        16. As a Claim Document User I see file selection dialog on Select File element click
        17. As a Claim Document User I see files are being uploaded on selection and/or drop
        18. As a Claim Document User I see files uploading confirmation after files are uploaded
        19. As a Claim Document User I see files uploading error in case of error has occured
        20. As a Claim Admin I see default Retention Date calculated and set for the uploaded files
        21. As a Claim Document User I see Delete icon at uploaded File Icon
        22. As a Claim Document User I see Delete file confirmation on Delete icon click
        23. As a Claim Document User I see File is [Soft?] deleted on delete confirmation
        24. As a Claim Document User I see File content on File icon click

        25. As a Claim Admin User I see Claim Document Store main page
        26. As a Claim Admin User I see empty Claims list at the main page
        27. As a Claim Admin User I see Login button at the main page
        28. As a Claim Admin User I see logged Admin user profile Link at the main page
        29. As a Claim Admin User I see Login form on Login button click
        30. As a Claim Admin User I see logged user name Link on successful authentication
        31. As a Claim Admin User I see User list at Claim Document Store main page
        32. As a Claim Admin User I can search for user by name
        33. As a Claim Admin User I see User Claim List on user click
        34. As authenticated Claim Admin User I see Claim Document List on Claim click
        35. As authenticated Claim Admin User I see Claim Document on Document icon click
        36. As a Claim Admin User I see Add document element
        37. As a Claim Admin User I see Add document form on Add Documnent element click
        38. As a Claim Admin User I see Document type radio list
        39. As a Claim Admin User I see select file element on Document selection form
        40. As a Claim Admin User I can drop files on Document selection form
        41. As a Claim Admin User I see file quantity and size warning on Document selection form
        42. As a Claim Admin User I see file selection dialog on Select File element click
        43. As a Claim Admin User I see files are being uploaded on selection and/or drop
        44. As a Claim Admin User I see files uploading confirmation after files are uploaded
        45. As a Claim Admin User I see files uploading error in case of error has occured
        46. As a Claim Admin User I see Delete icon at uploaded File Icon
        47. As a Claim Admin User I see Delete file confirmation on Delete icon click
        48. As a Claim Admin User I see File is [Soft?] deleted on delete confirmation
        49. As a Claim Admin User I see File content on File icon click

### Claim Business Rules
        1. As a Claim Admin I see created Claim with New State Status Code
    