up:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
	 export SECRET_KEY="'\x00\xc2\xd7O\xadj\xce\xe91\x8e*p\xfdB\xb7\x9b\xe4\xbd\xb6\x95\xa1\xd6X\xd3'"; \
	 export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	 python /vagrant/repos/snailx_api/api/main.py"

build:
	vagrant provision
	vagrant up

install-requirements:
	pip install flask
	pip install flask-api
	pip install flask-sqlalchemy
	pip install flask-migrate
	pip install pyjwt
	pip install coverage
	pip install unittest-xml-reporting

destroy-all:
	vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
	ps -ef |grep VBox | awk '{print $2}' | xargs kill

init-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && . /vagrant/venv/bin/activate; \
	export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	python manage.py db init"

migrate-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && . /vagrant/venv/bin/activate; \
	export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	python manage.py db migrate && python manage.py db upgrade"

test:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
	export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	python /vagrant/repos/snailx_api/api/test_runner.py;"

test-coverage:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
	export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	coverage run --source /vagrant/repos/snailx_api/api /vagrant/repos/snailx_api/api/test_runner.py test; \
	coverage html -d /vagrant/coverage_html --skip-covered --omit /vagrant/repos/snailx_api/api/wsgi.py,/vagrant/repos/snailx_api/api/main.py"
	rm -rf /coverage_html
	scp -rP 2222 vagrant@127.0.0.1:/vagrant/coverage_html .

test-xml:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
	export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	python /vagrant/repos/snailx_api/api/test_runner.py"
	rm -rf test-reports
	scp -rP 2222 vagrant@127.0.0.1:/home/vagrant/test-reports .

up-gunicorn:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
	export SECRET_KEY="'\x00\xc2\xd7O\xadj\xce\xe91\x8e*p\xfdB\xb7\x9b\xe4\xbd\xb6\x95\xa1\xd6X\xd3'"; \
	export DATABASE_URL="postgresql://snailx_dev:snailx_dev_pass@localhost/snailx"; \
	cd /vagrant/repos/snailx_api/api; gunicorn --bind 0.0.0.0:5000 wsgi"
