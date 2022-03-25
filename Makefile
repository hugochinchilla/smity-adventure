.PHONY: run
run:
	./pico8 -run smity.p8

.PHONY: html
html:
	rm -f smity.html smity.js
	./pico8 smity.p8 -export smity.html
	mv smity.html smity.js html/

.PHONY: deploy
deploy: html
	git add html/
	git commit -m "Updated HTML export"
	git push origin master:gh-pages