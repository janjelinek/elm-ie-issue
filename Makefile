.PHONY: build dev


yarn.lock: package.json
	yarn install --yes


timestamp := $(shell /bin/date +%s)

prepareIndex: _index.html
	cp _index.html index.html && t= sed -i '.backup' "s/{VERSION}/$(timestamp)/g" index.html && rm index.html.backup

build: yarn.lock
	elm-make App.elm --output=app.js
	make prepareIndex

dev: build
	PATH=node_modules/.bin:$$PATH node_modules/http-server/bin/http-server ./ -a 0.0.0.0
