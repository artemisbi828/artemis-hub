# LLM Context & Agentic Standards
## Goal -- create a readme_agent.md that I can feed with my standard preferences that minimize rework and errors based on my experience so far building solutions with LLM. The main painpoints have been asking to test products that are not working due to false positives and burning resources, reworks, of credits when it could have been prevented by having more precise clear prompts, more frequent check points, or better counter-prompting to user to create less ambiguity that produces errors in the build.

## Philosophy
- abide by  DRY, FAST, SOLID approach (don't repeat yourself, eliminate duplicate or extraneous info)
- build philosophy: pragmatic modernism, modern robustness
- interact w user with NO FLUFF: Zero "validating" phrases (eg, "Great question or great idea or that is a good approach"). Prompt and respond to the point w concise abstracts (3 sentence max). 
- go for core features and quickest time-to-value;
	- for any ambiguity -- prompt user (eg to identitfy which is core for MVP (minimum-viable-product))
- plan for manual checkpoints to perform test, but definitely create testing harnesses in folder = "testing_harness"
- avoid agent screenshots or designing test using wait/sleep > seconds; instead prompt user to generate and send screenshots to validate


## Directory Standards
1. README.md 
	- 1st section: "Quickstart" -- how to init the project / run / test in concrete micro-steps w minimized ambiguity for user to follow
	- 2nd section: General function or purpose of project
2. 3 main folders
- folder1: documentation
- folder2: website or app or function
- folder3: testing_harness
3. readme_agent.md -- this document to provide LLM guidance and standards

##  Documentation Standards
In folder.documentation create 3 items: 
- ProjectSummary.md that has an ascii tree of: 
	- tech stack (w version details) 
	- project directory 
	- on each commit, update ProjectSummary.md
- ImplementationPlan.md -- after a major build section or checkpoint, implementationplan.md is created to hand back to user for manual testing and verification
	- list what features to test 
- Changelog.txt: w following format: 
	- DateTime - Action: Concise summary of details and change 
	- eg: "2026-01-25 09:30 AM - Debugged: changed a --> b due to c. ver_num: 0.0.0"


## Script Standards
- at the top, have an LLM instruction so that as LLM scans, it knows to reference readme_agent.md and be consistent in all script generation; 
- declare all variables at the top
- ensure logic abides by basic syntax rules and would not trip any standard errors
- demarcate sections clearly w comments explaining the purpose of each and identify which are: methods, aliases
- also comment to explain how this section relates or interacts with another section (as an input or an output)
- at the end of each script should be a ver_num: 0.0.0 → which should correspond to changes to 

When generating or editing any script, ensure that each section has comment lines or blocks that annotate every non-standard identifier with a comment distinguishing its origin. Use the tag [STD] for built-in keywords/methods and [USR] for user-defined variables, functions, or parameters. Ensure comments explain the specific role of [USR] elements within the script’s logic to prevent confusion with library-specific syntax. This eliminates "hallucinated" syntax recognition and forces the model to verify the source of every string it writes.

## Testing Standards
- check for sequencing errors and prompt user to warn for any subsequent functions that overwrite any previous functions, rendering any previous functions obsolete, unnecessary, or 
project planning:
- Create checkpoints w manual testing check-ins in ImplementationPlan.md
- Prioritize agent self testing harness to check for: 
	- be outcome focused: for example, test for version compatibility between tools in tech stack for false positives 
		-- eg: for a website UX project, verify pagges are not rendering blank, meaning even though no error is displayed, outcome is not what is expected
	- data type integrity


## Background and Preferences
I am on a Windows 11 PC 64 bit. I have strong background in SQL as a BI developer. I like to use sublime for writing atomic scripts and using custom built functions to improve my writing or correct my code
I like using obsidian and markdown for notes. Use VS Code and Algorithm.
I want to strengthen my full stack capabilities esp in Powershell, Linux, Python. 
I have built some websites and apps with agent assistance but am fuzzy about all the components that need to happen in order for everything to work together. Especially when it comes to docker. 
I prefer using modern best practices eg for UI websites Node.Js, etc
I want to use more google tools in general and have a GoogleVM on Linux. 