#!/usr/bin/env python3

# ==============================================================================
#  ASUSTeK Confidential
# ==============================================================================
#  Copyright 2025 The ASUSTeK Robot Engine Authors. All rights reserved.
# ==============================================================================

"""
The script is for checking duplicate test case name.
Usage:
  python3 check_duplicate_names.py [test_directory]
"""

from robot.api import ExecutionResult
from robot import run
import sys
import subprocess


def execute_dryrun(robot_execute_path: str) -> bool:
    try:
        run(
            robot_execute_path,
            outputdir=robot_execute_path,
            dryrun=True,
            console="none",
        )
        print(f"Generate result by robot dryrun, path={robot_execute_path}")
    except subprocess.CalledProcessError as e:
        print(f"execute robot --dryrun failed:{e.stderr}")
        return False
    return True


def get_test_case_names_from_suite(suite):
    test_case_names = []
    for test in suite.tests:
        test_case_names.append(test.name)
    for subsuite in suite.suites:
        test_case_names.extend(get_test_case_names_from_suite(subsuite))
    return test_case_names


def find_duplicates(test_case_names):
    seen = set()
    duplicates = set()
    for name in test_case_names:
        if name in seen:
            duplicates.add(name)
        else:
            seen.add(name)
    return duplicates


def find_duplicate_test_names(robot_execute_path):
    """
    Parses a Robot Framework test file and identifies duplicate test case names.

    Args:
        robot_execute_path (str): The path to the Robot execution.

    Returns:
        dict: A dictionary where keys are duplicate test names and values are lists
              of suite names where the test case appears.  Returns an empty dictionary
              if no duplicates are found.
    """

    dryrun_result = execute_dryrun(
        robot_execute_path
    )  # execution robot dryrun for generating output.xml
    if dryrun_result:
        print("Parsing output.xml...")
        robot_framework_output_xml = f"{robot_execute_path}/output.xml"
        print(robot_framework_output_xml)
    else:
        print("Error executing Robot Framework dry run")
        sys.exit(1)

    try:
        result = ExecutionResult(robot_framework_output_xml)  # Parse the output.xml
    except Exception as e:
        print(f"Error parsing Robot file: {e}")
        sys.exit(1)

    duplicates = []
    test_case_names = []

    print(f"Total Test Cases: {result.statistics.total.total}")
    test_case_names = get_test_case_names_from_suite(result.suite)
    duplicates = find_duplicates(test_case_names)

    return duplicates


def main():
    # if len(sys.argv) < 2:
    #    print("No file path provided, defaulting to '.'")
    file_path = "."
    # else:
    #    file_path = f"./{sys.argv[1]}"

    duplicate_tests = find_duplicate_test_names(file_path)
    duplicates_number = len(duplicate_tests)
    print(f"Looking for duplicate test names under file path: {file_path}")
    print(f"Number of Duplicates: {duplicates_number}")

    if duplicate_tests:
        print("Duplicate Test Cases Found:")
        print("=" * 50)
        for name in duplicate_tests:
            print(name)
        print("=" * 50)
        sys.exit(1)
    else:
        print("No duplicate test cases found.")
        sys.exit(0)


if __name__ == "__main__":
    main()
