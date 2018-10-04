up:
	vagrant ssh -c ". /vagrant/venv/bin/activate; python /vagrant/repos/snailx_api/api/main.py"

build:
	vagrant provision
	vagrant up

install-requirements:
	pip install flask
	pip install flask-api
	pip install flask-sqlalchemy
	pip install flask-migrate

destroy-all:
	vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
	ps -ef |grep VBox | awk '{print $2}' | xargs kill

migrate-db:
	vagrant ssh -c ". /vagrant/venv/bin/activate; cd /vagrant/repos/snailx_api/api && FLASK_APP=main.py flask db init && FLASK_APP=main.py flask db migrate && FLASK_APP=main.py flask db upgrade"

test:
	vagrant ssh -c ". /vagrant/venv/bin/activate; python -m unittest discover -s /vagrant/repos/snailx_api/api -p "*_test.py""