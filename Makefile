DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .git .gitmodules .gitignore .DS_Store
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

all: install

help:
	@echo "make list     #==> Show dotfiles in this repo"
	@echo "make deploy   #==> Create symlink to home directory"
	@echo "make init     #==> Setup environment settings"
	@echo "make update   #==> Fetch changes for this repo"
	@echo "make install  #==> Run make update, deploy, init"
	@echo "make clean    #==> Remove the dotfiles and this repo"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/lib/init/init.sh

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: deploy init
	@exec $$SHELL

clean:
	@echo 'Remove dotfiles in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	#-rm -rf $(DOTPATH)
