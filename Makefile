help:
	@echo 'Individual commands:'
	@echo ' lint             - Lint the code with pylint and flake8 and check imports'
	@echo '                    have been sorted correctly'
	@echo ' test             - Run tests'
	@echo ''
	@echo 'Grouped commands:'
	@echo ' linttest         - Run lint and test'	
lint:
    # Lint the python code
	pylint *
	flake8
	isort -rc --check-only .
install:
	npm install
test:
	# Run python tests
	env `cat /code/config.tmpl.env | xargs` pytest -v
lintjs:
	# Lint the javascript code
	npm run lint
testjs:
	# Run javascript tests
	npm run test
linttest: lint test
linttestjs: install lintjs testjs
linttestall: lint test lintjs testjs
