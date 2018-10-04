up:
	vagrant ssh -c "python /vagrant/main.py"

build:
	vagrant provision
	vagrant up

destroy-all:
	vagrant box list | cut -f 1 -d ' ' | xargs -L 1 vagrant box remove -f
	ps -ef |grep VBox | awk '{print $2}' | xargs kill