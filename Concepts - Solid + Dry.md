**Dry**: Don't repeat yourself
- eliminate dupes in code, config, processes
	- repetition increases maintenance burden, encourages human errors, decentralizes
	- don't commit files that can be regenerated from source code or downloaded from registries
- Separation of Concerns: Centralized config management file for upload paths, ports, etc
	- - keep config separate from code; personal IDE settings shouldn't affect TMs

**Solid (5)**: business logic should be extracted and separated
- Single Responsibility: Each component or script should do one thing and should have ONLY ONE reason to change
	- atomicity -- eg separate pipeline stages for build-test-deploy instead of 1 job
- Open/Closed: Systems should be open for extension but closed for modification.
	- extensible -- add steps without changing existing logic (legos)
	- do not hardcode variables
- Liskov Substitution (LSP): Components should be replaceable without breaking the system.
	- swap something out and it shouldn't break
- Interface Segregation: Avoid forcing components to depend on things they don’t need.
	- "no junk"
	- instead of 1 config-big, break up config-build vs config-deploy
- Dependency Inversion: Dynamic dependencies
	- Depend on abstractions, not concrete implementations 
		- eg1 - use env variables or secretes managers instead of hardcoding credentials in scripts)
		- eg2 - harold asking for startsfromkey to be dynamic



# Data Application
Dry -- Deduped; 
* Normalization -- minimize data redundancy; improve data integrity (for ease we normally go up to 2NF)
	* 1NF -- violation if "Math,Physics" in 1 cell -- columns s/b atomic (no string aggs)
	* 2NF -- violation if SourceSystemName in table and not in SourceSystemName for (composite key: ssid+guid)
	* 3NF -- violation if rollups are in table (TreatmentGroupName) vs in TreatmentGroupTable via key; 
* Anomalies (To Prevent) due to NOT having → Cascade Update, Cascade Delete
	* Insertion Anomaly: adding a department when precondition is employee needs to be assigned to it first
	* Update Anomaly: w/o cascade update; inconsistent records → normalization = update 1 place
	* Deletion Anomaly: w/o cascade delete; orphaned records → normalization = delete 1 place
Solid -- Atomic; Dynamic; Extensible 

# Violation Examples

| Dry                          | regex text extraction is in both .py scripts                                                                               |
| ---------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| Single Responsibility        | Business logic is mixed / convuleted in app.py                                                                             |
| Open / Closed                | "Rosa" hardcoded in app.js → should be <u>dynamic</u>                                                                      |
| Dependency Inversion         | Functions create DB connections instead of receiving them → testing := difficult                                           |
| Configuration Management     | Missing? Need centralized config file for upload paths, ports, etc; magic numbers and paths should not be scattered around |
| Error Handling Inconsistency | Some functions have try-catch, some don't; Error handling should be centralized                                            |
