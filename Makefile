# polib Makefile, useful for developers only.
# Make sure you have pep8 and tox python modules installed.

.PHONY: clean lint test dist

all: lint test clean

clean:
	@find . -name '*.pyc' -delete
	@find . -name '*.pyo' -delete
	@find . -name '*.orig' -delete
	@rm -rf MANIFEST build dist .coverage .tox __pycache__ docs/_build *.egg-info

lint:
	@type pycodestyle >/dev/null 2>&1 || { echo >&2 "Please install pycodestyle package."; exit 1; }
	@pycodestyle -r polib.py && { echo >&2 "PEP8: congrats, everything is clean !"; }

test:
	@if type tox >/dev/null 2>&1; then tox; else ./runtests.sh; fi

dist: clean
	@python setup.py register
	@python setup.py sdist upload
	@python setup.py bdist_wheel upload
