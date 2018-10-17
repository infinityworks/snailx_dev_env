up:
	vagrant ssh -c ". /vagrant/venv/bin/activate; python /vagrant/repos/snailx_admin_panel/snailx_admin.py"

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
	vagrant ssh -c "cd /vagrant/repos/snailx_admin_panel && . /vagrant/venv/bin/activate; \
		python manage.py db init"

migrate-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_admin_panel && . /vagrant/venv/bin/activate; \
		python manage.py db migrate"

upgrade-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_admin_panel && . /vagrant/venv/bin/activate; \
		python manage.py db upgrade"

test:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
		python /vagrant/repos/snailx_admin_panel/test_runner.py;"

up-gunicorn:
	vagrant ssh -c ". /vagrant/venv/bin/activate; cd /vagrant/repos/snailx_admin_panel; gunicorn --bind 0.0.0.0:5000 wsgi"
