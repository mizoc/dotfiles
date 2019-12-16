ifeq ($(shell uname),Linux)
all:
	./first && ./install.sh
uninstall:
	./last && ./uninstall.sh
else
all:
	./first_darwin && ./install.sh
uninstall:
	./last_darwin && ./uninstall.sh
endif

install:
	./install.sh
