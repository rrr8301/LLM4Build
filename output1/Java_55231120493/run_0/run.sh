#!/bin/bash

# Run Maven build
mvn --batch-mode --update-snapshots verify

# Run Checkstyle
mvn checkstyle:check || true

# Run SpotBugs
mvn spotbugs:check || true

# Run PMD
mvn pmd:check || true