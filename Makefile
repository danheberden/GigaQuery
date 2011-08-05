JS_DIR = js
CSS_DIR = css
DIST_DIR = dist
GIGA_JS = ${DIST_DIR}/gigaquery.js
GIGA_CSS = ${DIST_DIR}/gigaquery.css

giga: js css images
	@@echo "GIGGGGGGGGGA QUERY!!"

js:
	@@mkdir -p ${DIST_DIR}
	@@echo "/* GigaQuery JS! Built on "$(shell git log -1 --pretty=format:%ad)"*/" > ${GIGA_JS}
	@@for g in ${JS_DIR}/*; do \
		echo "giga $$g"; \
		cat $$g >> ${GIGA_JS}; \
	done;

css:
	@@mkdir -p ${DIST_DIR}
	@@echo "/* GigaQuery CSS! Built on "$(shell git log -1 --pretty=format:%ad)"*/" > ${GIGA_CSS};
	@@for g in ${CSS_DIR}/*; do \
		echo "giga $$g"; \
		cat $$g >> ${GIGA_CSS}; \
	done;\

images:
	@@mkdir -p ${DIST_DIR}/images
	@@cp -rf images/* ${DIST_DIR}/images

dude:
	@@if test ! -z ${JS_ENGINE}; then \
		echo "Minifying jQuery" ${JQ_MIN}; \
		${COMPILER} ${JQ} > ${JQ_MIN}.tmp; \
		${POST_COMPILER} ${JQ_MIN}.tmp > ${JQ_MIN}; \
		rm -f ${JQ_MIN}.tmp; \
	else \
		echo "You must have NodeJS installed in order to minify jQuery."; \
	fi


clean:
	@@echo "Destroying Distribution Directory:" ${DIST_DIR}
	@@rm -rf ${DIST_DIR}

.PHONY: giga js css images clean
