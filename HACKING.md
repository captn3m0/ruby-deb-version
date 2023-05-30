# Development

The all-debian-versions.lst file is a sorted version of the file 
from https://github.com/FauxFaux/deb-version/blob/42c0e61f62b6776fa1bd77b0da3327fa31dcc1c4/all-debian-versions.lst. The sorting was done using the following script:

```
import sys
from functools import cmp_to_key
import apt_pkg
apt_pkg.init_system()
def compare_versions(version1, version2):
    # Implement your comparison logic here
    # Return -1 if version1 < version2
    # Return 0 if version1 == version2
    # Return 1 if version1 > version2
    # You can use apt_pkg.version_compare or any other comparison logic

    # Example comparison logic using apt_pkg.version_compare
    return apt_pkg.version_compare(version1, version2)

def sort_debian_package_numbers(package_numbers):
    # Sort the package numbers using cmp_to_key and compare_versions
    return sorted(package_numbers, key=cmp_to_key(compare_versions))

if __name__ == "__main__":
    # Read package numbers from stdin
    package_numbers = [line.strip() for line in sys.stdin]

    # Sort the package numbers
    sorted_package_numbers = sort_debian_package_numbers(package_numbers)

    # Write the sorted list to stdout
    for package_number in sorted_package_numbers:
        sys.stdout.write(package_number + '\n')
```

Keeping a sorted version in the repository lets us avoid the libapt dependency.