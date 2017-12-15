.PHONY: build dev


yarn.lock: package.json
	yarn install --yes

build: yarn.lock
	elm-make App.elm --output=index.html

dev: build
	PATH=node_modules/.bin:$$PATH node_modules/http-server/bin/http-server ./ -a 0.0.0.0
