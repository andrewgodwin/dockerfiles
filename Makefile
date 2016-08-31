.PHONY: all base simple-www varnish www-ssl www-router utilishell cron get_iplayer

all: base simple-www varnish www-ssl utilishell

base:
	docker build -t andrewgodwin/base base

simple-www:
	docker build -t andrewgodwin/simple-www simple-www

www-router:
	docker build -t andrewgodwin/www-router www-router

varnish:
	docker build -t andrewgodwin/varnish varnish

www-ssl:
	docker build -t andrewgodwin/www-ssl www-ssl

utilishell:
	docker build -t andrewgodwin/utilishell utilishell

cron:
	docker build -t andrewgodwin/cron cron

get_iplayer:
	docker build -t andrewgodwin/get_iplayer get_iplayer
