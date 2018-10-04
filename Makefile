up:
	vagrant ssh -c "python /vagrant/api/main.py"

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
	vagrant ssh -c "cd /vagrant && FLASK_APP=main.py flask db init && FLASK_APP=main.py flask db migrate && FLASK_APP=main.py flask db upgrade"
