# MibiTools R Package

![MibiTools Logo](https://example.com/mibitools_logo.png)

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
