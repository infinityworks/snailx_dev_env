up:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
		python /vagrant/repos/snailx_api/api/main.py"

build:
	vagrant provision
	vagrant up

destroy-all:
	vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
	ps -ef |grep VBox | awk '{print $2}' | xargs kill

init-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && . /vagrant/venv/bin/activate; \
		python manage.py db init"

migrate-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && . /vagrant/venv/bin/activate; \
		python manage.py db migrate"

upgrade-db:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && . /vagrant/venv/bin/activate; \
		python manage.py db upgrade"

dummy-data-save-db:
	vagrant ssh -c "pg_dump -h localhost -p 5432 -U dev
		-d snailx -T alembic_version -f /vagrant/repos/snailx_api/api/db/dummy_data.dump --format custom"

dummy-data-load-db:
	vagrant ssh -c "PGPASSWORD="snailx_dev_pwd" pg_restore -h localhost -p 5432 \
		-U dev -d snailx --clean -v /vagrant/repos/snailx_api/api/db/dummy_data.dump"

test:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
		python /vagrant/repos/snailx_api/api/test_runner.py;"

test-coverage:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
		coverage run --source /vagrant/repos/snailx_api/api /vagrant/repos/snailx_api/api/test_runner.py test; \
		coverage html -d /vagrant/coverage_html --skip-covered --omit /vagrant/repos/snailx_api/api/wsgi.py,/vagrant/repos/snailx_api/api/main.py"
	rm -rf /coverage_html
	scp -rP 2222 vagrant@127.0.0.1:/vagrant/coverage_html .

test-xml:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
		python /vagrant/repos/snailx_api/api/test_runner.py"
	rm -rf test-reports
	scp -rP 2222 vagrant@127.0.0.1:/home/vagrant/test-reports .

up-gunicorn:
	vagrant ssh -c ". /vagrant/venv/bin/activate; \
		cd /vagrant/repos/snailx_api/api; gunicorn --bind 0.0.0.0:5000 wsgi"

create-user:
	vagrant ssh -c "cd /vagrant/repos/snailx_api/api && . /vagrant/venv/bin/activate; \
		python manage.py create_user"
