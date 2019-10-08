#!/usr/bin/env bash

rubocop
foodcritic .
foodcritic test/fixtures/cookbooks/account_site
foodcritic test/fixtures/cookbooks/faculty_site
foodcritic test/fixtures/cookbooks/test_harness
