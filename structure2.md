# Retrowrite-ARM
# Thesis structure outline

### 0. Title 
##### 0.1 Acknowledgements
Give thanks to family, prof Payer, prof Paterson, the HexHive research group, the original RetroWrite authors, etc.
##### 0.2 Abstract
Overview of the whole thesis that must fit into a single page

...
We show that static rewriting is a viable way to instrument ARM binaries at low runtime overhead. ...
We present a port of the original user-mode Retrowrite project to ARM, and we use it to instrument binaries and add memory sanitization. The Retrowrite implementation is modular, so it is easy to add new instrumentation passes if needed.
...
In our evaluation, we show that the performance impact is comparable to source-based instrumentation approaches, and significantly less expensive than dynamic rewriting techiques.
...

### 1. Introduction

Binary rewriting is changing the semantics of a program without having the source code at hand. It is used for diverse purposes such as emulation (e.g., QEMU), optimization (e.g., DynInst), observation (e.g., Valgrind) and hardening (e.g., Control flow integrity enforcement). This survey gives detailed insight into the development and state-of-the-art in binary rewriting by reviewing 67 publications from 1966 up to 2018. Starting from these publications we provide an in-depth investigation of the challenges and respective solutions to accomplish binary rewriting. Based on our findings we establish a thorough categorization of binary rewriting approaches with respect to their use-case, applied analysis technique, code-transformation method and code generation techniques. We contribute a comprehensive mapping between binary rewriting tools, applied techniques and their domain of application. Our findings emphasize that although much work has been done over the last decades, most of the effort was put into improvements aiming at rewriting general purpose applications, but ignoring other challenges like altering throughput-oriented programs, or software with real-time requirements, that are often used in the emerging field of the Internet of Things. To the best of our knowledge, our survey is the first comprehensive overview on the complete binary rewriting process.

(the above copied from random paper)

> Problem statement: why do we need binary rewriting
> 
> Challenges for binary rewriting on ARM
> 
> Small explanation about what are the goals of the Retrowrite project, why is it so important, why in some cases dynamic instrumentation is not enough.

General overlook on what was the status of Retrowrite before I joined, and what will be my contributions.

>How the challenges are addressed
>
>Short discussion of implementation and results


### 2. Background

##### 2.1 Dynamic vs Static Instrumentation
Go into detail on what are the pros/cons of each method. Explain what is the current state of the art on both sides, and give some examples of each method. Explain what is the reason behind Retrowrite being a static rewriter and not a dynamic one. 

##### 2.2 Binary Rewriting
Explain our focus on static instrumentation *without* source code.

Explain key concepts of binary rewriting.  Explain what are the problems that spawn from the lack of source code. 


##### 2.3 Instrumentation details
Give some examples of instrumentation commonly used. 
Get more in-depth on how certain kinds of instrumentation are particularly useful for fuzzing
>
>One paragraph each about ASan, fuzzing, and maybe CFI. Say what each
>instrumentation looks like and reference a paper for RW.
>

##### 2.4 ARM architecture
Get into detail on what are the key differences between x86 and ARM. Give some foreshadowing on the challenges that will be faced because of ARM quirks.


### 3. Design

##### 3.1 Goals

>Tell me the design goals here! :)

Give a rundown of specific goals that we set ourselves at the start of the project:
	- Study the ARM architecture and the main differences from x86
	- Study the codebase of the retrowrite project, understand the theory behind it and its implementation
	- Write tests to ensure the robustness of the implementation
	- Implement and introduce support for ARM in the retrowrite project
	- Develop a sample instrumentation pass (bASAN)
	- Evaluate the resulting implementation against state-of-the-art techniques
	 

##### 3.2 System overview
High level rundown of how retrowrite works. Explain how it is split into a single Symbolizer and multiple possible instrumentation modules
>This will be a figure and not an individual section.

##### 3.3 Symbolizer
High level rundown of how the original x86 Symbolizer works. Explain the key challenges introduced by porting it to ARM:

- Alignment issues
- Global variables (!)
- Jump tables (!!)
- Control flow broken by too much instrumentation (e.g. short jumps)
- Literal pools (maybe move to only chapter 4, implementation?)

>These issues should be key issues mentioned at the top of this chapter. The
>symbolizer section here will then focus exclusively on ARM
>
>

##### 3.4 Instrumentation (ASAN)
Explain the ASAN algorithm, the concept of shadow memory, etc.
Explain the limitations of our binary ASAN compared to source ASAN:
- No checks on global variables
- Checks on the stack only at the stack-frame level
- Many more instructions instrumented because of lack of source code


>This may be its own section
>
>
### 4. Implementation

##### 4.1 Symbolizer
Go into the nitty-gritty details of my horrible hackish implementation, yay!
>
##### 4.1.1 Global variables
- How were they detected
- How were they fixed 
- The literal pool dilemma

##### 4.1.2 Jump Tables
- How were they detected
	- Pseudo-emulating ARM binaries to detect jump tables
- How were they fixed 
	- List all ideas we had
	- Explain why we chose to implement the ungodly hack of expanding them 
	- also, nop padding between cases

##### 4.2 ASAN instrumentation
- Overview of the ASAN algorithm, how it was hand-translated to ARM assembly
- Various optimizations that were introduced to lower instrumentation overhead

### 5. Evaluation

##### 5.1 Experiment overview
Explain our setup, the hardware we used, what we were measuring.

Talk a bit on also the difficulties caused by the nature of the benchmarks, namely very long times (up to 48 hours, and probably more now that I have cloudLab :D ), very high RAM usage, and so on.

Talk a bit on how those difficulties were approached, with the very strict collection of experiment metadata using github CI and the telegram bot.

##### 5.2 SPEC CPU
Explain how much do I hate the SPEC CPU benchmark, who developed it, the crazy fact that it is the accepted state of the art method for benchmarking single-core performace, how counter-intuitive their directory structure, config files, and bash scripts are. 
/s

##### 5.3 Results
Present  plots and tables, and a detailed explanation on each one.
Make sure to respect the style of Mathias' previous papers/theses, to avoid getting him unnecessarily angry

Compare it to state-of-the-art dynamic instrumentation (qemu).


### 6. Related Work
Still need to look up what's best to put here
>Other binary rewriters both static and dynamic ones. Similarly papers that
>utilize binary rewriting. Try to categorize and split up a bit

### 7. Future work
- kRetrowrite-ARM :)

### 8. Conclusion

### 9. Bibliography
- The original retrowrite paper
- Give credit to CloudLab for letting me use their mega computers

Still need to look up what's best to put here

--- 
### Extra
If there is space, I could also add the following, even though it's a bit off-topic:
- A good big old rant about Capstone for ARM, about how many bugs I found (4 up to now, and counting), about the fact that I even fixed one and submitted a pull request but it was completely ignored
- A great speech on my love for GDB, on how I hated it at first, on how eventually we got past our relationship problems, on how much time we ended up spending together, how much did it save me from problems I thought were impossible, which shiny debugging techniques I learnt, and so on.
