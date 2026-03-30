

# --- Student Details ---
STUDENT_NAME="Vidushi Kanungo"           
ROLL_NUMBER="24BAI10123"     
SOFTWARE_CHOICE="Python"             

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                   # Linux kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                  # Currently logged-in user
HOME_DIR=$HOME                       # Home directory of current user
UPTIME=$(uptime -p)                  # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y') # Formatted current date
CURRENT_TIME=$(date '+%H:%M:%S')     # Current time

# --- Determine OS License ---
# Linux (and most distros) are licensed under GPL v2
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# --- Display formatted welcome banner ---
echo "============================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT        "
echo "============================================================"
echo ""
echo "  Student  : $STUDENT_NAME"
echo "  Roll No  : $ROLL_NUMBER"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged-in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "------------------------------------------------------------"
echo "  This operating system (Linux) is covered under:"
echo "  $OS_LICENSE"
echo ""
echo "  This means you have the freedom to:"
echo "    [1] Run the program for any purpose"
echo "    [2] Study and modify the source code"
echo "    [3] Redistribute copies"
echo "    [4] Distribute modified versions"
echo ""
echo "============================================================"
echo "  Audit system ready. Chosen software: $SOFTWARE_CHOICE"
echo "============================================================"
