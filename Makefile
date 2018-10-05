up:
	vagrant ssh -c ". /vagrant/venv/bin/activate; export SECRET_KEY="'\x00\xc2\xd7O\xadj\xce\xe91\x8e*p\xfdB\xb7\x9b\xe4\xbd\xb6\x95\xa1\xd6X\xd3'"; python /vagrant/repos/snailx_api/api/main.py"

build:
	vagrant provision
	vagrant up

install-requirements:
	pip install flask
	pip install flask-api
	pip install flask-sqlalchemy
	pip install flask-migrate
	pip install pyjwt

destroy-all:
	vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
	ps -ef |grep VBox | awk '{print $2}' | xargs kill

migrate-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && FLASK_APP=main.py flask db init && FLASK_APP=main.py flask db migrate && FLASK_APP=main.py flask db upgrade"

test:
	vagrant ssh -c ". /vagrant/venv/bin/activate; python /vagrant/repos/snailx_api/api/test_runner.py"