# Use an official miniconda image as a parent image
FROM continuumio/miniconda3

# Set the working directory in the container to /maws
WORKDIR /maws

# Add the current directory contents into the container at /maws
COPY . /maws

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y curl gcc g++ gfortran cmake flex bison zlib1g-dev libbz2-dev

# Create a conda environment with Python 3.7
RUN conda create -n maws-env python=3.7

# Activate the conda environment and install OpenMM
RUN /bin/bash -c "source activate maws-env && conda install -y -c conda-forge openmm scipy matplotlib tk"

# Extract the AmberTools tarball
RUN tar -xjf /maws/AmberTools23.tar.bz2

# Navigate into the AmberTools directory and install it using cmake
RUN /bin/bash -c "source activate maws-env && cd /maws/amber22_src/build && cmake -DCOMPILER=GNU -DDOWNLOAD_MINICONDA=FALSE ../ && make install"

# Here you could add any additional dependencies or setup steps.
