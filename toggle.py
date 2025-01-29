#!/usr/bin/env python3
'''
"""
Utility script to toggle between Tron and Forge implementations in Solidity files.
Handles commenting/uncommenting of code blocks marked with @custom:tron and @custom:forge.

Example input file:
    function withdrawReward() internal returns (uint256) {
        ///@custom:tron
        // return withdrawreward();
        ///@custom:forge
        return getStake2().withdrawReward();
    }

After running with 'tron' mode:
    function withdrawReward() internal returns (uint256) {
        ///@custom:tron
        return withdrawreward();
        ///@custom:forge
        // return getStake2().withdrawReward();
    }

After running with 'forge' mode:
    function withdrawReward() internal returns (uint256) {
        ///@custom:tron
        // return withdrawreward();
        ///@custom:forge
        return getStake2().withdrawReward();
    }
"""


'''
import sys
import os
import re

def is_single_level_comment(line: str) -> bool:
    """
    Returns True if the line is commented with exactly one level of '//',
    ignoring leading whitespace. Example:
      '    // doThing();' -> True
      '    // // doThing();' -> False (multi-level)
      '/// doThing();' -> False (triple slash, typical NatSpec)
    """
    # Matches optional leading whitespace, then '//', 
    # but NOT followed by another slash.
    return bool(re.match(r'^\s*//(?!/)', line))

def is_commented(line: str) -> bool:
    """
    Returns True if the line is commented at all (one-level or multi-level),
    ignoring leading whitespace.
    """
    return bool(re.match(r'^\s*//', line))

def uncomment_single_level(line: str) -> str:
    """
    If the line is a single-level comment, remove the leading '//' (and one space 
    if present). Otherwise, return the line unchanged.
    This preserves indentation and line endings for idempotent toggling.
    """
    # Keep the original line ending by not stripping it
    match = re.match(r'^(\s*)//\s?(.*?)(\r?\n?)$', line)
    if match:
        indentation = match.group(1)
        rest = match.group(2)
        line_ending = match.group(3)
        return f"{indentation}{rest}{line_ending}"
    return line

def comment_line_if_needed(line: str) -> str:
    """
    If the line is not already commented, comment it out (preserving indentation).
    If it's already commented (single or multi-level), return unchanged.
    Preserves line endings.
    """
    if not is_commented(line):
        # Keep the original line ending by not stripping it
        match = re.match(r'^(\s*)(.*?)(\r?\n?)$', line)
        if match:
            indentation = match.group(1)
            rest = match.group(2)
            line_ending = match.group(3)
            # Insert '// ' after indentation
            return f"{indentation}// {rest}{line_ending}"
    return line

def transform_line(line: str, nat_spec_mode: str, script_mode: str) -> str:
    """
    Given a line that follows a NatSpec custom comment (nat_spec_mode = 'forge' or 'tron'),
    and the script's invocation mode (script_mode = 'forge' or 'tron'),
    return the appropriately toggled line.

    Rules Recap:
    - When script_mode = 'forge':
      - If nat_spec_mode = 'forge': uncomment line if single-level commented
      - If nat_spec_mode = 'tron': comment out line if not commented
    - When script_mode = 'tron':
      - If nat_spec_mode = 'tron': uncomment line if single-level commented
      - If nat_spec_mode = 'forge': comment out line if not commented
    """
    if script_mode == 'forge':
        if nat_spec_mode == 'forge':
            # Uncomment if single-level commented
            if is_single_level_comment(line):
                return uncomment_single_level(line)
        elif nat_spec_mode == 'tron':
            # Comment out if not commented
            return comment_line_if_needed(line)
    elif script_mode == 'tron':
        if nat_spec_mode == 'tron':
            # Uncomment if single-level commented
            if is_single_level_comment(line):
                return uncomment_single_level(line)
        elif nat_spec_mode == 'forge':
            # Comment out if not commented
            return comment_line_if_needed(line)
    return line

def preprocess_file(file_path: str, script_mode: str) -> None:
    """
    Reads the file at file_path, processes it in-place according to the 
    specified script_mode ('forge' or 'tron'), and writes back the result.
    """
    # Skip if not a .sol file
    if not file_path.endswith('.sol'):
        return
        
    # Read all lines
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
        return
    except OSError as e:
        print(f"Error: Could not open file '{file_path}': {e}")
        return

    # Process lines
    processed_lines = []
    i = 0
    while i < len(lines):
        line = lines[i]
        # Check if this line is a NatSpec directive
        match = re.match(r'^\s*///@custom:(forge|tron)', line)
        if match:
            nat_spec_mode = match.group(1)  # 'forge' or 'tron'
            processed_lines.append(line)    # keep the NatSpec comment line as-is

            # If there's a next line, transform it
            if i + 1 < len(lines):
                next_line = lines[i + 1]
                next_line = transform_line(next_line, nat_spec_mode, script_mode)
                processed_lines.append(next_line)
                i += 1  # skip the next line in the main loop
        else:
            # Not a NatSpec directive, just keep the line as-is
            processed_lines.append(line)
        i += 1

    # Write back the transformed content
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            f.writelines(processed_lines)
    except OSError as e:
        print(f"Error: Could not write to file '{file_path}': {e}")

def process_directory(directory: str, script_mode: str) -> None:
    """
    Recursively processes all .sol files in the given directory and its subdirectories.
    """
    try:
        for root, _, files in os.walk(directory):
            for file in files:
                if file.endswith('.sol'):
                    file_path = os.path.join(root, file)
                    print(f"Processing {file_path}...")
                    preprocess_file(file_path, script_mode)
    except OSError as e:
        print(f"Error accessing directory '{directory}': {e}")

def main():
    if len(sys.argv) != 3:
        print("Usage: python toggle.py [forge|tron] [directory]")
        sys.exit(1)

    script_mode = sys.argv[1].strip().lower()
    directory = sys.argv[2].strip()

    if script_mode not in ('forge', 'tron'):
        print("Error: Script mode must be either 'forge' or 'tron'.")
        sys.exit(1)

    if not os.path.isdir(directory):
        print(f"Error: '{directory}' is not a valid directory.")
        sys.exit(1)

    process_directory(directory, script_mode)
    print(f"Finished processing all .sol files in '{directory}' with mode '{script_mode}'.")

if __name__ == "__main__":
    main()