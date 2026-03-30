#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Author: Vidushi Kanungo 24BAI10123
# Course: Open Source Software | Chosen Software: Python
# Description: Checks if a FOSS package is installed, shows
#              version/license info, and prints a philosophy
#              note about each package using a case statement.
# =============================================================

# --- Target package: python3 is the standard package name ---
PACKAGE="python3"

echo "============================================================"
echo "         FOSS PACKAGE INSPECTOR                            "
echo "============================================================"
echo ""

# --- Detect package manager and check installation ---
# Try dpkg first (Debian/Ubuntu), then rpm (RHEL/Fedora/CentOS)

if command -v dpkg &>/dev/null; then
    # --- Debian/Ubuntu path ---
    if dpkg -l "$PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "[✔] $PACKAGE is INSTALLED on this system (dpkg)."
        echo ""
        echo "--- Package Details ---"
        # Extract version, description from dpkg
        dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "  Version : " $3}'
        # Show more details using dpkg -s
        dpkg -s "$PACKAGE" 2>/dev/null | grep -E '^(Package|Version|License|Maintainer|Description):' | \
            sed 's/^/  /'
    else
        echo "[✘] $PACKAGE is NOT installed."
        echo "    To install on Debian/Ubuntu: sudo apt install python3"
    fi

elif command -v rpm &>/dev/null; then
    # --- RPM-based path (CentOS, RHEL, Fedora) ---
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "[✔] $PACKAGE is INSTALLED on this system (rpm)."
        echo ""
        echo "--- Package Details ---"
        # Show version, license, summary from rpm database
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary|Packager' | \
            sed 's/^/  /'
    else
        echo "[✘] $PACKAGE is NOT installed."
        echo "    To install on RHEL/CentOS: sudo dnf install python3"
    fi

else
    # --- Fallback: try 'python3 --version' directly ---
    if command -v python3 &>/dev/null; then
        echo "[✔] python3 is available on this system."
        echo "  Version : $(python3 --version 2>&1)"
        echo "  Path    : $(which python3)"
    else
        echo "[✘] python3 is NOT found on this system."
    fi
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTES"
echo "------------------------------------------------------------"
echo ""

# --- case statement: prints a philosophy note per package name ---
case $PACKAGE in
    python3 | python)
        echo "  Python: A language shaped entirely by its community."
        echo "  Guido van Rossum created Python to make programming"
        echo "  accessible and readable. The PSF License ensures it"
        echo "  remains free for everyone — from students to enterprises."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Apache HTTP Server helped democratize web publishing"
        echo "  under the permissive Apache 2.0 license."
        ;;
    mysql | mysql-server)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual-license model (GPL + Commercial) is a fascinating"
        echo "  study in how open source and business can coexist."
        ;;
    git)
        echo "  Git: Linus Torvalds built this after a proprietary tool"
        echo "  failed the Linux community. GPL v2 ensures it stays free,"
        echo "  and it now underpins virtually all software development."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  Mozilla's MPL 2.0 license balances openness with the"
        echo "  ability to build commercial products on top of it."
        ;;
    vlc)
        echo "  VLC: Built by students in Paris who just wanted to watch"
        echo "  video over their university network. LGPL/GPL licensed,"
        echo "  it became the universal media player for the world."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice.org."
        echo "  A real lesson in how open source communities reclaim"
        echo "  their work when corporate control threatens freedom."
        ;;
    *)
        echo "  $PACKAGE: An open-source tool contributing to the"
        echo "  global commons of freely available software."
        ;;
esac

echo ""
echo "============================================================"
