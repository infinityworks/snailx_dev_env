up:
	vagrant ssh -c ". /vagrant/venv/bin/activate; export SECRET_KEY="'\x00\xc2\xd7O\xadj\xce\xe91\x8e*p\xfdB\xb7\x9b\xe4\xbd\xb6\x95\xa1\xd6X\xd3'"; python /vagrant/repos/snailx_admin_panel/snailx_admin.py"

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

up-gunicorn:
	vagrant ssh -c ". /vagrant/venv/bin/activate; export SECRET_KEY="'\x00\xc2\xd7O\xadj\xce\xe91\x8e*p\xfdB\xb7\x9b\xe4\xbd\xb6\x95\xa1\xd6X\xd3'"; cd /vagrant/repos/snailx_admin_panel; gunicorn --bind 0.0.0.0:5000 wsgi"
