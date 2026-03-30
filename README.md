OSS Audit — Python
Open Source Software Capstone Project | VIT University

About This Project
This repository contains the complete submission for the Open Source Audit capstone project. The audit examines Python — one of the world's most widely used open-source programming languages — across five dimensions: its origin story, its license, its Linux footprint, its FOSS ecosystem, and a critical comparison against its proprietary alternative (MATLAB).
The project includes five shell scripts that demonstrate practical Linux command-line skills.


Shell Scripts
Script 1 — System Identity Report
File: script1_system_identity.sh
Displays a formatted welcome banner showing the Linux distribution, kernel version, current user, home directory, uptime, date/time, and the open-source license covering the OS.
Concepts: Variables, command substitution $(), echo, output formatting
Run:
bashchmod +x script1_system_identity.sh
./script1_system_identity.sh

Script 2 — FOSS Package Inspector
File: script2_package_inspector.sh
Checks whether Python (python3) is installed on the system, displays its version and license details using dpkg or rpm, and prints a philosophy note about each package using a case statement.
Concepts: if-then-else, case statement, dpkg -s / rpm -qi, pipe with grep
Run:
bashchmod +x script2_package_inspector.sh
./script2_package_inspector.sh

Script 3 — Disk and Permission Auditor
File: script3_disk_permission_auditor.sh
Loops through a list of standard system directories and Python-specific paths, reporting permissions, owner/group, and disk usage for each. Uses a for loop over a bash array.
Concepts: for loop, arrays ${arr[@]}, du -sh, ls -ld, awk, cut
Run:
bashchmod +x script3_disk_permission_auditor.sh
./script3_disk_permission_auditor.sh

Script 4 — Log File Analyzer
File: script4_log_analyzer.sh
Reads a log file line by line, counts how many lines contain a given keyword, retries if the file is missing or empty, and prints the last 5 matching lines.
Concepts: while read loop, if-then, counter variables, command-line arguments $1/$2, tail, grep
Run:
bashchmod +x script4_log_analyzer.sh

# Basic usage (default keyword: 'error')
./script4_log_analyzer.sh /var/log/syslog

# With custom keyword
./script4_log_analyzer.sh /var/log/syslog python

# On RHEL/CentOS (different log path)
./script4_log_analyzer.sh /var/log/messages error

Script 5 — Open Source Manifesto Generator
File: script5_manifesto_generator.sh
Asks the user three interactive questions and generates a personalised open-source philosophy statement, saving it to manifesto_[username].txt in the current directory.
Concepts: read for user input, string concatenation, file output (> and >>), date command, aliases (demonstrated via comment)
Run:
bashchmod +x script5_manifesto_generator.sh
./script5_manifesto_generator.sh
Sample interaction:
1. Name one open-source tool you use every day: python3
2. In one word, what does 'freedom' mean to you?  access
3. Name one thing you would build and share freely: a compiler
Output is saved to manifesto_[yourusername].txt and displayed on screen.

Dependencies
All scripts require a standard Linux environment. No additional packages are needed beyond what ships with any modern Linux distribution.
DependencyPurposeAvailable onbash ≥ 4.0Script interpreterAll Linux distroscoreutilsecho, cut, date, cat, tail, duAll Linux distrosgrepPattern matching in scripts 2 and 4All Linux distrosawkField extraction in scripts 2 and 3All Linux distrosdpkg or rpmPackage info in script 2Debian/Ubuntu or RHEL/Fedorapython3Subject of the audit (script 2 checks for it)Install via apt/dnf

Running All Scripts at Once
bash# Make all scripts executable
chmod +x *.sh

# Run them in sequence
./script1_system_identity.sh
./script2_package_inspector.sh
./script3_disk_permission_auditor.sh
./script4_log_analyzer.sh /var/log/syslog error
./script5_manifesto_generator.sh
