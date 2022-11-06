#!/bin/bash

# Update package repository
sudo apt update

# Install Postgres
sudo apt install postgresql -y
sudo apt install postgresql-contrib -y

# Check that Postgres is running
sudo systemctl start postgresql.service