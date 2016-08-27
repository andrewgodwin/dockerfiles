.PHONY: all base simple-www varnish www-ssl utilishell cron

all: base simple-www varnish www-ssl utilishell

base:
	docker build -t andrewgodwin/base base

simple-www:
	docker build -t andrewgodwin/simple-www simple-www

varnish:
	docker build -t andrewgodwin/varnish varnish

www-ssl:
	docker build -t andrewgodwin/www-ssl www-ssl

utilishell:
	docker build -t andrewgodwin/utilishell utilishell

cron:
	docker build -t andrewgodwin/cron cron
