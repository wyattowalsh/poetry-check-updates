#  python check updates Makefile

.ONESHELL:

# https://www.gnu.org/prep/standards/html_node/Makefile-Basics.html#Makefile-Basics
SHELL = /bin/bash

help:           ## Show this help.
	fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


notebook:  ## Launch jupyter lab from project root
	echo "Starting Jupyter Lab..."
	poetry shell && poetry install --with notebook
	poetry run jupyter lab

format: ## Run formatters on the python check updates package
	echo "Running formatters..."
	poetry shell && poetry install
	poetry run isort python check updates/ tests/
	poetry run autoflake --recursive python check updates/ tests/
	poetry run yapf -i --recursive python check updates/ tests/

lint: ## Run linters on the python check updates package
	echo "Running linters..."
	poetry shell && poetry install
	poetry run ruff check python check updates/ tests/
	poetry run mypy python check updates/ tests/
	poetry run pylint python check updates/ tests/

test: ## Run tests on the python check updates package
	echo "Running tests..."
	poetry shell && poetry install
	poetry run pytest tests/