.PHONY: run
run:
	./pico8 -run smity.p8

.PHONY: html
html:
	$(eval EPOCH=$(shell date +'%s'))
	./pico8 smity.p8 -export smity.html
	rm html/*.js
	mv smity.html smity.js html/
	mv html/smity.js html/smity-$(EPOCH).js
	cat html/smity.tpl.html | EPOCH=$(EPOCH) envsubst > html/smity.html
	

.PHONY: deploy
deploy: html
	git add -A html/
	git commit -m "Updated HTML export"
	git push origin master:gh-pages