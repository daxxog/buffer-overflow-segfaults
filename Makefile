.PHONY: _default
_default: iter
	@true


.PHONY: _always-rebuild
_environment: _always-rebuild
	@echo '/*' > $@.tmp
	@echo $$(env) >> $@.tmp
	@echo '*/' >> $@.tmp
	@diff -q $@ $@.tmp || cp $@.tmp $@
	@rm -f $@.tmp


.PHONY: iter
iter:
	./segfault-iter-test-runner.sh
	cat segfaults.csv


BOF.c: BOF.template.c _environment
	cat $^ | \
	sed "s/__TRY_BUFFER_SIZE__/$${TRY_BUFFER_SIZE}/g" \
	> BOF.c


.PHONY: build
build: BOF.c
	make BOF
	make pretty && make BOF


.PHONY: test
test: build
	valgrind -v ./bf.sh


.PHONY: clean
clean:
	-rm segfaults.csv
	-rm BOF.c
	-rm BOF
	-rm _environment


.PHONY: pretty
pretty: BOF.template.c
	clang-format $^ > $^.tmp
	if diff $^ $^.tmp; then \
		true; \
	else \
		cat $^.tmp | tee $^; \
	fi
	rm $^.tmp


BOF: BOF.c
	gcc -ggdb $^ -o BOF -fno-stack-protector -z execstack


.PHONY: help
help:
	@echo ':: available targets -->'
	@echo ''
	@cat Makefile | grep '.PHONY: ' | grep -v '.PHONY: _' | sed 's/.PHONY: //g'
