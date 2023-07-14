# MibiTools R Package

`* place holder picture *`

## Overview

The MibiTools R package is designed to assist scientists in the Mibi working group in efficiently working with their measurement data. The package provides functions specifically tailored for reading data from various probes, devices, and loggers commonly used within the group. It aims to simplify the data analysis process by providing standardized methods for data importation into R.

## Features

The MibiTools package currently supports the following devices and loggers:

- Contros CO2 probes
- EGM CO2 analyzers
- Gas chromatograph
- Hobo loggers
- Zebra loggers (O2)
- Minidot O2 loggers

The package includes dedicated functions for reading data from each device, allowing scientists to easily import their specific data files for analysis within R. The functions handle the intricacies of each device's data format, making it effortless to incorporate the data into their workflows.

## Installation

To install the MibiTools package, you can use the `devtools` package in R. Run the following command:

```R
devtools::install_github("your-username/mibitools")
```
## Usage

To import data from a specific device, simply call the corresponding function provided by the MibiTools package. For example, to read data from a Contros CO2 probe, you can use the read_contros() function:

```R

data <- read_contros(filename, probeid)
```
Make sure to replace filename with the path to your data file and probeid with the specific identifier of your Contros CO2 probe.
## Extensibility

The MibiTools package has been designed with extensibility in mind. It aims to support additional devices, probes, and loggers commonly used within the Mibi working group. The package can easily be extended by adding new functions to read data from new devices as needed. We encourage contributions from the Mibi working group members to expand the functionality of the package.

## Feedback and Contributions

We welcome feedback, bug reports, and feature requests from users of the MibiTools package. If you encounter any issues or have suggestions for improvements, please open an issue on our GitHub repository.

If you would like to contribute to the package by adding support for new devices or enhancing existing functionalities, you can submit a pull request on GitHub. Your contributions will be greatly appreciated and will help benefit the entire Mibi working group.

Please copy the above content as is, and it should work seamlessly in your README.md file.
