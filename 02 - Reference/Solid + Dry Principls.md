Dry -- Deduped; 
Solid -- Atomic; Dynamic; Extensible 


**Dry**: Don't repeat yourself
- eliminate dupes in code, config, processes
	- repetition increases maintenance burden, encourages human errors, decentralizes
	- don't commit files that can be regenerated from source code or downloaded from registries
- Separation of Concerns: Centralized config management file for upload paths, ports, etc
	- - keep config separate from code; personal IDE settings shouldn't affect TMs

**Solid (5)**: business logic should be extracted and separated
- Single Responsibility: Each component or script should do one thing well.
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

