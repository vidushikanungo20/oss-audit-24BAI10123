

# --- List of standard system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/opt")

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR                       "
echo "============================================================"
echo ""
echo "  Scanning standard system directories..."
echo ""
printf "  %-20s %-20s %-10s\n" "Directory" "Permissions/Owner" "Size"
echo "  ------------------------------------------------------------"

# --- for loop: iterate over each directory ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions and ownership using ls and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')         # e.g. drwxr-xr-x
        OWNER=$(ls -ld "$DIR" | awk '{print $3 "/" $4}')  # e.g. root/root
        # Get disk usage; suppress "permission denied" errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-20s %-20s %-10s\n" "$DIR" "$PERMS $OWNER" "$SIZE"
    else
        # Directory does not exist on this system
        printf "  %-20s %-20s\n" "$DIR" "[does not exist]"
    fi
done

echo ""
echo "------------------------------------------------------------"
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT                         "
echo "------------------------------------------------------------"
echo ""

# --- Python config and library directories to check ---
PYTHON_DIRS=(
    "/usr/lib/python3"
    "/usr/lib/python3.11"
    "/usr/local/lib/python3.11"
    "/usr/local/lib/python3"
    "/etc/python3"
    "/usr/bin/python3"
)

echo "  Checking Python installation paths..."
echo ""

# --- for loop over Python-specific paths ---
for PYDIR in "${PYTHON_DIRS[@]}"; do
    if [ -e "$PYDIR" ]; then
        # It exists — check if file or directory and show details
        if [ -d "$PYDIR" ]; then
            PERMS=$(ls -ld "$PYDIR" | awk '{print $1}')
            OWNER=$(ls -ld "$PYDIR" | awk '{print $3 "/" $4}')
            SIZE=$(du -sh "$PYDIR" 2>/dev/null | cut -f1)
            echo "  [DIR]  $PYDIR"
            echo "         Permissions: $PERMS | Owner: $OWNER | Size: $SIZE"
        else
            # It's a file (e.g. /usr/bin/python3 binary)
            PERMS=$(ls -l "$PYDIR" | awk '{print $1}')
            OWNER=$(ls -l "$PYDIR" | awk '{print $3 "/" $4}')
            echo "  [FILE] $PYDIR"
            echo "         Permissions: $PERMS | Owner: $OWNER"
        fi
    else
        echo "  [--]   $PYDIR — not found on this system"
    fi
    echo ""
done

# --- Check for pip and virtual environment tool ---
echo "------------------------------------------------------------"
echo "  PYTHON TOOLCHAIN CHECK                                   "
echo "------------------------------------------------------------"
echo ""

# Array of Python-related commands to verify
TOOLS=("python3" "pip3" "python3 -m venv")

for TOOL in "python3" "pip3" "python3-config"; do
    if command -v "$TOOL" &>/dev/null; then
        echo "  [✔] $TOOL found at: $(which $TOOL)"
    else
        echo "  [✘] $TOOL not found in PATH"
    fi
done

echo ""
echo "============================================================"
echo "  Audit complete."
echo "============================================================"
