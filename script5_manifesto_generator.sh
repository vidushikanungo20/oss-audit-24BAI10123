
# --- Get current date for the manifesto header ---
DATE=$(date '+%d %B %Y')
TIME=$(date '+%H:%M:%S')
AUTHOR=$(whoami)

# --- Output filename: personalised per user ---
OUTPUT="manifesto_${AUTHOR}.txt"

echo "============================================================"
echo "     OPEN SOURCE MANIFESTO GENERATOR                      "
echo "============================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open-source philosophy statement."
echo ""
echo "------------------------------------------------------------"

# --- Question 1: Daily tool ---
read -p "  1. Name one open-source tool you use every day: " TOOL

# --- Question 2: What freedom means ---
read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

# --- Question 3: What they would build and share ---
read -p "  3. Name one thing you would build and share freely: " BUILD

echo ""
echo "------------------------------------------------------------"
echo "  Composing your manifesto..."
echo ""

# --- Compose the manifesto using string concatenation ---
# Build paragraph line by line using >> to append to the file

# Overwrite/create file with header first (single >)
echo "============================================================" > "$OUTPUT"
echo "              MY OPEN SOURCE MANIFESTO                     " >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"
echo "  Author  : $AUTHOR"                                         >> "$OUTPUT"
echo "  Date    : $DATE at $TIME"                                  >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"
echo "------------------------------------------------------------" >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"

# --- The personalised philosophy paragraph ---
# String concatenation: variables embedded directly in echo strings
echo "  Every day, I rely on $TOOL — a tool that someone built"   >> "$OUTPUT"
echo "  not for profit, but for the world. That act of sharing"    >> "$OUTPUT"
echo "  is what open source means to me: it is the living proof"   >> "$OUTPUT"
echo "  that $FREEDOM is not just an abstract idea, but something" >> "$OUTPUT"
echo "  you can compile, run, and give away."                      >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"
echo "  I believe that knowledge grows when it is shared. The"     >> "$OUTPUT"
echo "  programmers who built $TOOL did not hoard their work —"    >> "$OUTPUT"
echo "  they released it so others could learn from it, fix it,"   >> "$OUTPUT"
echo "  and build on it. That is the tradition I want to carry"    >> "$OUTPUT"
echo "  forward."                                                   >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"
echo "  One day, I will build $BUILD and release it freely."       >> "$OUTPUT"
echo "  Not because I have to, but because the developers who"     >> "$OUTPUT"
echo "  came before me did the same — and because $FREEDOM,"       >> "$OUTPUT"
echo "  real $FREEDOM, is only meaningful when it is passed on."   >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"
echo "  This is my commitment to the open-source community."       >> "$OUTPUT"
echo ""                                                             >> "$OUTPUT"
echo "------------------------------------------------------------" >> "$OUTPUT"
echo "  Signed: $AUTHOR | $DATE"                                   >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Confirm file was created ---
echo "  [✔] Manifesto saved to: $OUTPUT"
echo ""
echo "============================================================"
echo "  YOUR MANIFESTO:"
echo "============================================================"
echo ""

# --- Display the saved file using cat ---
cat "$OUTPUT"
