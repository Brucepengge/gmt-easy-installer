#!/bin/bash
sudo yum install -y epel-release
sudo yum install -y gcc gcc-c++ cmake make glibc ghostscript netcdf-devel \
                    glib2-devel gdal-devel gdal-python lapack-devel \
                    pcre-devel fftw-devel wget
